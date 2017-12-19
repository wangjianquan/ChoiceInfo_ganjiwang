//
//  WJPickerView.swift
//  CollectionSelected
//
//  Created by landixing on 2017/12/18.
//  Copyright © 2017年 wjq. All rights reserved.
//

import UIKit

class WJPickerView: UIView {
    

    var components: NSMutableArray = NSMutableArray()
    var rows_components: NSMutableArray = NSMutableArray()
    
    
    var selectPickerBlock: ( (_ result: String) -> ())?
    var result = String()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40))
        headerView.layer.borderWidth = 1.0
        headerView.layer.borderColor = UIColor.init(white: 0.94, alpha: 1.0).cgColor
        addSubview(headerView)
        
        let trueBtn = UIButton(frame: CGRect(x: headerView.frame.size.width - 66, y: 0, width: 66, height: headerView.frame.size.height))
        trueBtn.setTitle("确定", for: .normal)
        trueBtn.setTitleColor(UIColor.black, for: .normal)
        trueBtn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        headerView.addSubview(trueBtn)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: headerView.frame.size.height, width: self.frame.size.width, height: self.frame.size.height -  headerView.frame.size.height))
        pickerView.delegate = self
        pickerView.dataSource = self
        addSubview(pickerView)
    }
    
    @objc fileprivate func btnAction()  {
    
        if selectPickerBlock != nil {
            selectPickerBlock!(result)
        }
    }
   
}



extension WJPickerView: UIPickerViewDelegate, UIPickerViewDataSource{
   
    //MARK: -- 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    //MARK: -- 每列的行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rows_components.count
    }
    
    //设置pickerView各选项的内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return rows_components.object(at: row) as? String
    }
    
    //pickerView选中某一项后会触发
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        result = rows_components.object(at: row) as! String
        if selectPickerBlock != nil {
            selectPickerBlock!(result)
        }
        
    }
    
    //指定列的宽度
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if let numbers = components.count {
//            return self.frame.size.width / numbers
//        }
//    }
    
    //MARK: -- 设置单元格高度
  
}










