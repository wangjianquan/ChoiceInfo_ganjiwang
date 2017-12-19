//
//  PubInfoCollectionCell.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

let pubInfoCollCell_ID = "PubInfoCollectionCell"


class PubInfoCollectionCell: UITableViewCell {
    
    @IBOutlet weak var collection: ChoiceInfoCollectionVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
