//
//  PickerInfoController.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit


class PickerInfoController: UIViewController {
   
    var title_Str: String!
    var result: String!
    var current_Index:IndexPath!
    var type: String!
    var cell: ChoiceInfoCell?
   
    var resultBlock: ( (_ resultStr: String, _ index: IndexPath ) -> () )?

    var info = NSMutableArray()
   
    
    
    //pickerView显示的数据
    let pickerData : NSMutableArray = ["一月", "二月", "三月", "四月", "五月", "六月",
                                       "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    lazy var collection: ChoiceInfoCollectionVC = {
        let collection = ChoiceInfoCollectionVC(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: (getLinesWithThree(info) * choiceInfo_Item_height )), collectionViewLayout: UICollectionViewFlowLayout())
        collection.data_Source = info
        return collection
    }()
    lazy var datePicker: WJDatePickerView = {
        let picker = WJDatePickerView(frame: CGRect(x: 0, y: collection.frame.size.height + 15, width: self.view.frame.width, height: 230))
        picker.components = [""]
        picker.pickerType = PickerViewType(rawValue: type!)
        picker.rows_components = pickerData
        return picker
    }()
    
    init(_ cell: ChoiceInfoCell, _ item_Id: IndexPath, _ type: String) {
        self.cell = cell
        self.current_Index = item_Id
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
        datePicker.title.text = "请选择 · "+title_Str!
      
        datePicker.trueBlock = {[weak self] (dateString) in
            self?.result = dateString
            self?.collection.currentIndex = self?.current_Index
        }
        
        collection.selectedItemBlock = { [weak self] (cell, index, type) in
            self?.current_Index = index
            self?.datePicker.title.text = "请选择 · "+cell.title.text!
            if cell.textField.text != nil {
                 cell.textField.text = self?.result
                cell.textField.text = " "
            }
            cell.textField.text = self?.result
            cell.textField.textColor = UIColor.orange
            self?.datePicker.pickerType = PickerViewType(rawValue: type)
            print("\(String(describing: cell.textField.text))  \(index.row)  \(type)")
            self?.cell = cell
            if self?.resultBlock != nil && self?.result != nil {
                self?.resultBlock!((self?.result)!, index)
            }
        }
        
        
        view.addSubview(collection)
        view.addSubview(datePicker)
    }
    


    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
    }

    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ?  100 : collection.frame.size.height + datePicker.frame.size.height );
    }

    
    
    
    

}


















