//
//  PickerInfoController.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit


protocol PickerInfoDelegate {
    func pickerInfo(_ cell: ChoiceInfoCell, _ index: NSInteger, _ edit: Bool)
}

class PickerInfoController: UIViewController , ChoiceInfoSelectItemDelegate,ChoiceInfoDelegate{
  
    
   

    var current_Index: NSInteger!
    var edit: Bool?
    var resultBlock: ( (_ resultStr: String) -> () )?

    var title_Str:String?
    var dataSource = NSMutableArray()
   
    var result: String?
    
    //pickerView显示的数据
    let pickerData : NSMutableArray = ["一月", "二月", "三月", "四月", "五月", "六月",
                                       "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    lazy var collection: ChoiceInfoCollectionVC = {
        let collection = ChoiceInfoCollectionVC(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: (getLinesWithThree(dataSource) * choiceInfo_Item_height )), collectionViewLayout: UICollectionViewFlowLayout())
        collection.data_Source = dataSource
        collection.selectDelegate = self
        collection.cell?.delegate = self
        return collection
    }()
    lazy var datePicker: WJDatePickerView = {
        let picker = WJDatePickerView(frame: CGRect(x: 0, y: collection.frame.size.height + 15, width: self.view.frame.width, height: 230))
        picker.components = [""]
        picker.pickerType = .datePicker
        picker.rows_components = pickerData
        return picker
    }()
    
    func currentItemSelect(_ cell: ChoiceInfoCell, _ index: NSInteger) {
        print("----------------")
    }
    func didSelectItem(_ cell: ChoiceInfoCell, _ item_Id: NSInteger, _ edit: Bool) {
        cell.textField.text = self.result
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
       
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
        datePicker.title.text = "请选择"+title_Str!
        
        
        view.addSubview(collection)
        view.addSubview(datePicker)
        datePicker.trueBlock = {[weak self] (dateString) in
            self?.result = dateString
            if self?.resultBlock != nil {
                self?.resultBlock!(dateString)
            }
        }
        datePicker.selectPickerBlock = {[weak self] (result) in
            self?.result = result
            if self?.resultBlock != nil {
                self?.resultBlock!(result)
            }
        }
        
    }
    


    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
    }

    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? collection.frame.size.height + datePicker.frame.size.height : 420);
    }

    
    
    
    

}


















