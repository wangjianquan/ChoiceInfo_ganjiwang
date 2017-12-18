//
//  ChoiceInfoCell.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

let choiceInfoCell_Id = "ChoiceInfoCell"


class ChoiceInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var isUseEnabled : Bool?
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let isUseEnabled = isUseEnabled else { return  }
        textField.isUserInteractionEnabled = isUseEnabled

    }

}
