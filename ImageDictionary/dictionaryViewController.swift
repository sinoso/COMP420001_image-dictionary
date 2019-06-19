//
//  dictionaryViewController.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 19/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import UIKit

class dictionaryViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if let query = searchTextField.text {
            performSegue(withIdentifier: "searchSegue", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ImageDicVC = segue.destination as? dictionaryTableviewController {
            if let text = searchTextField.text {
                ImageDicVC.queryText = text
            }
        }
    }
    
    
    
}

