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
        let picker = WJDatePickerView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 230))
        
        return picker
    }()
    
    
    lazy var infoPicker: UIPickerView = {
        let infoPick = UIPickerView(frame: CGRect(x: 0, y: datePicker.frame.size.height + 100, width: self.view.frame.size.width, height: datePicker.frame.size.height))
        infoPick.delegate = self
        infoPick.dataSource = self
        infoPick.backgroundColor = UIColor.lightGray
        return infoPick
    }()
    
    
    
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
            print("\(dateString)")
        }
        
        view.addSubview(datePicker)
        view.addSubview(infoPicker)
        
    }
    
   


}

extension PickerInfoController: UIPickerViewDelegate, UIPickerViewDataSource{
  
    //设置pickerView的列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //设置pickerView的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)
        -> Int {
            return pickerData.count
    }
    
    //设置pickerView各选项的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return pickerData[row % pickerData.count] as? String
    }
    
    //pickerView选中某一项后会触发
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        // 使用一个UIAlertView来显示用户选中的列表项
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "\(pickerData.object(at: row))", style: .default, handler: { (action) in
            
        }))
        
        present(alert, animated: true, completion: nil)
       
        
    }
    
//    //指定列的宽度
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 60
//    }
    
    //MARK: -- 设置单元格高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    
}
















