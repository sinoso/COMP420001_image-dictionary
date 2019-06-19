//
//  dicTableViewCell.swift
//  ImageDictionary
//
//  Created by 14 김세현 on 20/06/2019.
//  Copyright © 2019 comp420. All rights reserved.
//

import UIKit

class dicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dsecLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
