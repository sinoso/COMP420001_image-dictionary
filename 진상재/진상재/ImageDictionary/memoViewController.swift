//
//  memoViewController.swift
//  ImageDictionary
//
//  Created by 진상재 on 19/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class memoViewController: UIViewController {
    
    var myWords = Array<UIButton>()
    var language="aa";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bringMyWords();
        
        // Do any additional setup after loading the view.
    }
    
    
    func bringMyWords(){
        
        // 단어장에 가입된 갯수 N만큼 단어를 버튼의 형태로 만든다.
        var N=5;
        var x=20,y=100,width=100,height=50;
        var a=0;
        for a in 0 ..< N{
            let button = UIButton(frame: CGRect(x: x, y: y, width: width   , height: height))
            button.backgroundColor = .green
            button.setTitle(language, for: .normal)
            y+=height;
            y+=1;
            self.view.addSubview(button)
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
