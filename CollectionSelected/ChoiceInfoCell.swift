//
//  ChoiceInfoCell.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

protocol  ChoiceInfoDelegate : NSObjectProtocol {
    func currentItemSelect(_ cell: ChoiceInfoCell, _ index: NSInteger)
}

let choiceInfoCell_Id = "ChoiceInfoCell"
class ChoiceInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var line: UIView!
    
    weak var delegate: ChoiceInfoDelegate?
    
    var isUseEnabled: Bool?{
        didSet{
            guard let isUseEnabled = isUseEnabled else { return  }
            textField.isUserInteractionEnabled = isUseEnabled
        }
    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

}
