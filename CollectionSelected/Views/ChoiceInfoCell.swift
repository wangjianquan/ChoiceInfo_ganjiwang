//
//  ChoiceInfoCell.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

//
//protocol  ChoiceInfoDelegate : NSObjectProtocol {
//    func currentItemSelect(_ cell: ChoiceInfoCell, _ index: NSInteger, _ type: String)
//}

let choiceInfoCell_Id = "ChoiceInfoCell"
class ChoiceInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var line: UIView!
    var index: NSInteger?
    
//    weak var delegate: ChoiceInfoDelegate?
    
    var  choiceModel: ChoiceModel?{
        didSet{
            // 1.nil值校验
            guard let model = choiceModel else {
                return
            }
            title.text = model.tit
            if model.isEdit == "true" {
                textField.isUserInteractionEnabled = true
            } else {
                textField.isUserInteractionEnabled = false
            }
            textField.placeholder = model.subTitle
            textField.tintColor = UIColor.orange
            
            let lineImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 2, height: 10))
            lineImg.image = UIImage(named:"line")
            textField.leftView = lineImg
            textField.leftViewMode = .whileEditing
        }
    }
    
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
      

    }

}
