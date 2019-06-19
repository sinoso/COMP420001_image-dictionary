//
//  dicsTableViewController.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 20/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//
import UIKit
import os.log
import SafariServices

class dicsTableViewController: UITableViewController, XMLParserDelegate {
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    
    let dicImageQueue = DispatchQueue(label: "dicImage")
    
    let clientID        = "T2URDbQcCejnzXkxvK7L"    // ClientID
    let clientSecret    = "RJ1z2QZC2B"              // ClientSecret
    
    var queryText:String?                   // SearchVC에서 받아 오는 검색어
    var dictionarys:[Dictionary] = []    // API를 통해 받아온 결과를 저장할 array
    //
    
    // XML delegate
    var strXMLData: String?         = ""   // xml 데이터를 저장
    var currentTag: String?         = ""   // 현재 item의 tag를 저장
    var currentElement: String      = ""   // 현재 element의 내용을 저장
    var item: Dictionary?                = nil  // 검색하여 만들어지는 Dictionary 객체
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = queryText {
            titleNavigationItem.title = title
        }
        searchDics()
    }
    
    
    // MARK: - NaverAPI
    
    func searchDics() {
        // movies 초기화
        dictionarys = []
        
        // queryText가 없으면 return
        guard let query = queryText else {
            return
        }
        
        let urlString = "https://openapi.naver.com/v1/search/encyc.xml?query=" + query
        let urlWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlWithPercentEscapes!)
        
        var request = URLRequest(url: url!)
        request.addValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 있으면 리턴
            guard error == nil else {
                print(error as Any) // as Any는 지워도 됩니다!
                return
            }
            
            // 데이터가 비었으면 출력 후 리턴
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            // 데이터 초기화

            self.item?.description = ""
            self.item?.link = ""
            self.item?.thumbnail = ""
            self.item?.title = ""
            
            
            // Parse the XML
            let parser = XMLParser(data: Data(data))
            parser.delegate = self
            let success:Bool = parser.parse()
            if success {
                print(self.strXMLData as Any) // as Any는 지워도 됩니다!
            } else {
                print("parse failure!")
            }
        }
        task.resume()
    }
    

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" || elementName == "link" || elementName == "image" || elementName == "thumbnail" || elementName == "description"{
            currentElement = ""
            if elementName == "title" {
                item = Dictionary()
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentElement += string
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            item?.title = currentElement.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        } else if elementName == "link" {
            item?.link = currentElement
        } else if elementName == "description" {
            item?.description = currentElement
        } else if elementName == "thumbnail" {
            item?.thumbnail = currentElement
            if item?.thumbnail != "" {
                item?.thumbnail?.removeLast()
            }
        } else if elementName == "image" {
            item?.thumbnail = currentElement

        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionarys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellIdentifier", for: indexPath) as! dicTableViewCell
        let dictionary = dictionarys[indexPath.row]
        guard let title = dictionary.title, let _ = dictionary.description, let _ = dictionary.link else {
            return cell
        }
        
        // 제목
        cell.titleLabel.text = "\(title)"
        
        
        
        // Async activity
        // 이미지 불러오기
        if let posterImage = dictionary.image {
            cell.thumbImageView.image = posterImage
        } else {
            cell.thumbImageView.image = UIImage(named: "noImage")
            dicImageQueue.async(execute: {
                dictionary.getImage()
                guard let thumbImage = dictionary.image else {
                    return
                }
                DispatchQueue.main.async {
                    cell.thumbImageView.image = thumbImage
                }
            })
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = dictionarys[indexPath.row].link {
            if let url = URL(string: urlString) {
                let svc = SFSafariViewController(url: url)
                self.present(svc, animated: true, completion: nil)
            }
        }
    }
}

