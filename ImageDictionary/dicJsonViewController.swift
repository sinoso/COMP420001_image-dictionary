//
//  dicJsonViewController.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 20/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import UIKit

struct dict : Codable{
    var title:String
    var link:String
    var description:String
    var thumbnail:String
}

class dicJsonViewController: UIViewController {
    

    
        let Naver_Books_URL = "https://openapi.naver.com/v1/search/encyc.json?query="
        @IBOutlet weak var Json_TextView: UITextView!
        @IBOutlet weak var Title_text: UITextField!
        @IBAction func Click_Btn(_ sender: Any) {
            if let text = Title_text.text{
                callURL(url1: Naver_Books_URL ,search: text)
            }
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func callURL(url1:String,search : String){
                //api 정보
            let ClientID = "T2URDbQcCejnzXkxvK7L"
            let ClientSecret = "RJ1z2QZC2B"
            
            let addQuery = url1+search
            let encoded = addQuery.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)        //한글 검색어도 사용할 수 있도록 함
            
            //Request
            var request = URLRequest(url: URL(string: encoded!)!)
            request.httpMethod = "GET"                 //검색 API는 GET
            request.addValue(ClientID,forHTTPHeaderField: "X-Naver-Client-Id")
            request.addValue(ClientSecret,forHTTPHeaderField: "X-Naver-Client-Secret")
            
            //Session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            //Task
            let task = session.dataTask(with: request) { (data, response, error) in
                //통신 성공
                if let data = data {
                    let str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
                    print(str)
                    
                    DispatchQueue.main.async {
                        self.Json_TextView.text = str
                    }
                    
                }
                //통신 실패
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            task.resume()
        }
    
    
}

