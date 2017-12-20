//
//  PubPickerViewCell.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-20.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

let pickerViewCell_ID = "PubPickerViewCell"

class PubPickerViewCell: UITableViewCell {

    @IBOutlet weak var pickerView: WJDatePickerView!
    
    @IBOutlet weak var collectionview: ChoiceInfoCollectionVC!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
