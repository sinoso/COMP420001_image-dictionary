//
//  dicSearchViewController.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 20/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import UIKit

class dicSearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func searchButtonPressed(_ sender: Any) {
        if let _ = searchTextField.text {
            performSegue(withIdentifier: "searchSegue", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dicsVC = segue.destination as? dicsTableViewController {
            if let text = searchTextField.text {
                dicsVC.queryText = text
                                print("\(text)") //찾기용
            }
        }
    }
}
