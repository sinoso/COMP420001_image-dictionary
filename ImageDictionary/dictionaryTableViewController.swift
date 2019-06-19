//
//  dictionaryTableViewController.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 19/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class dictionaryTableviewController: UIViewController, XMLParserDelegate{
    

 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //API 키
    let clientID = "T2URDbQcCejnzXkxvK7L"
    let clientSecret = "RJ1z2QZC2B"
    
    //Data저장용
    var queryText:String?
    var dict_datas:[Dictionary_Data]  = []
    
    //XML delegate
    var strXMLData: String? = ""
    var currentTag: String? = ""
    var currentElement: String = ""
    var item: Dictionary_Data? = nil
    
    
    //쿼리를 이용한 검색
    func searchMovies() {
        // movies 초기화
        dict_datas = []
        
        // queryText가 없으면 return
        guard let query = queryText else {
            return
        }
        
        //query Url 작성
        let urlString = "https://openapi.naver.com/v1/search/encyc.xml?query=" + query
        let urlWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlWithPercentEscapes!)
        
        //UrlReauest 생성
        var request = URLRequest(url: url!)
        request.addValue("application/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 있으면 리턴
            guard error == nil else {
                print(error as Any)
                return
            }
            
            // 데이터가 비었으면 출력 후 리턴
            guard let data = data else {
                print("data empty")
                return
            }
            
            // data 초기화
            self.item?.thumbnail = ""
            self.item?.description = ""
            self.item?.link = ""
            self.item?.title = ""
            
            
            // Parse the XML
            let parser = XMLParser(data: Data(data))
            parser.delegate = self
            let success:Bool = parser.parse()
            if success {
                print(self.strXMLData as Any)
            } else {
                print("parse failure!")
            }
        }
        task.resume()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" || elementName == "link" || elementName == "description" || elementName == "thumbnail" {
            currentElement = ""
            if elementName == "title" {
                item = Dictionary_Data()
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
        } else if elementName == "thumbnail" {
            item?.thumbnail = currentElement
        } else if elementName == "description" {
            item?.description = currentElement
        }
    }
    
}
