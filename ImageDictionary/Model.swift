//
//  Model.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 20/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import Foundation
import UIKit

class Dictionary {
    var title:String?
    var link:String?
    var image:UIImage?
    var description:String?
    var thumbnail:String?
    
    init()
    {
        
    }
    
    func getImage() {
        guard thumbnail != nil else {
            return
        }
        if let url = URL(string: thumbnail!) {
            if let imgData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imgData) {
                    self.image = image
                }
            }
        }
        return
    }
}
