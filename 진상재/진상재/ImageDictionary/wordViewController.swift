//
//  wordViewController.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 19/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import UIKit

class wordViewController: UIViewController {

    
    var language="aa";
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choose language"{
            let lanName = (sender as? UIButton)?.currentTitle;
            
            if lanName! == "korean"{
                language="kor"
            }
            else if lanName! == "영어"{
                language="eng"
            }
            else {
                language="jap"
            }
            
            if let cvc=segue.destination as? memoViewController{
                cvc.language=language
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
