//
//  PickerInfoController.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

class PickerInfoController: UIViewController {

  
    lazy var datePicker: WJDatePickerView = {
        let picker = WJDatePickerView(frame: CGRect(x: 0, y: 90, width: self.view.frame.width, height: 230))
        picker.components = [""]
        picker.pickerType = .datePicker
        picker.rows_components = pickerData
        return picker
    }()
    
    
    
//    lazy var infoPicker: WJPickerView = {
//        let pickerView = WJPickerView(frame: CGRect(x: 0, y: datePicker.frame.size.height + 100 + 20, width: self.view.frame.size.width, height: datePicker.frame.size.height))
//        pickerView.components = [""]
//        pickerView.rows_components = pickerData
//        return pickerView
//    }()
    
    
    
    //pickerView显示的数据
    let pickerData : NSMutableArray = ["一月", "二月", "三月", "四月", "五月", "六月",
                      "七月", "八月", "九月", "十月", "十一月", "十二月"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let date = WJDatePickerView.newInstance()
        datePicker.title.text = "请选择日期"
        
        datePicker.cancelBlock = {[weak self] in
              print("cancelBlock")
        }
        
        datePicker.trueBlock = {[weak self] (dateString) in
            print("datePicker --> \(dateString)")
        }
        
        view.addSubview(datePicker)
//        view.addSubview(infoPicker)
        
        
        datePicker.selectPickerBlock = {[weak self] (result) in
            print("picker result --> \(result)")
        }
        
    }
    
   


}


















