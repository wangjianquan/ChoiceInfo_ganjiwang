//
//  WJDatePickerView.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-18.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

enum PickerViewType {
    case datePicker
    case otherPicker
}

class WJDatePickerView: UIView {

    var pickerType: PickerViewType?{
        didSet{
            if pickerType == .datePicker {
                pickerView.alpha = 0
                datePicker.alpha = 1.0
            }else if pickerType == .otherPicker {
                datePicker.alpha = 0
                pickerView.alpha = 1.0
            }
        }
    }
    
    var cancelBlock: ( ()->() )?
    var trueBlock:   ( (_ dateStr: String)->() )?
   
    fileprivate var btnColor : UIColor = UIColor.black
    
    /*
      ** UIPickerView
     */
    var components: NSMutableArray = NSMutableArray()
    var rows_components: NSMutableArray = NSMutableArray()
    var selectPickerBlock: ( (_ result: String) -> ())?
    var result = String()
    
    
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40))
        headerView.layer.borderColor = UIColor(white: 0.94, alpha: 1).cgColor
        headerView.layer.borderWidth = 1.0
        return headerView
    }()
  
    fileprivate let btn_Width : CGFloat = 66
    fileprivate let btn_Height : CGFloat = 40
    fileprivate let space: CGFloat = 10
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: btn_Width, height: btn_Height))
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(btnColor, for: .normal)
        btn.addTarget(self, action: #selector(cancelBtnAction(_:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    
    lazy var title: UILabel = {
        let label = UILabel(frame: CGRect(x: cancelBtn.frame.size.width + space, y:0 , width: headerView.frame.size.width - 2 * btn_Width - 2 * space, height: headerView.frame.size.height))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var trueBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: title.frame.size.width + title.frame.origin.x + space, y: 0 , width: btn_Width, height: btn_Height))
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(btnColor, for: .normal)
        btn.addTarget(self, action: #selector(trueBtnAction(_:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: headerView.frame.size.height, width: self.frame.size.width, height: self.frame.size.height - headerView.frame.size.height))
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        let maxDate = datePicker.date
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(changeDate(_:)), for: .valueChanged)
        return datePicker
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: headerView.frame.size.height, width: self.frame.size.width, height: self.frame.size.height - headerView.frame.size.height))
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
   fileprivate func setupUI() {
    
    
        addSubview(headerView)
        headerView.addSubview(self.cancelBtn)
        headerView.addSubview(self.title)
        headerView.addSubview(self.trueBtn)
        
        addSubview(datePicker)
        addSubview(pickerView)
    }
    
    

}

extension WJDatePickerView {
    @objc fileprivate func changeDate(_ datePicker : UIDatePicker) {
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        let date = datePicker.date
        let dateText = formatter.string(from: date)
        //        if changeDateBlock != nil {
        //            changeDateBlock!(dateText)
        //        }
        if trueBlock != nil {
            trueBlock!(dateText)
        }
    }
    
    @objc fileprivate func cancelBtnAction(_ sender: UIButton) {
        if cancelBlock != nil {
            cancelBlock!()
        }
    }
    
    @objc fileprivate func trueBtnAction(_ sender: UIButton) {
        if pickerType == .datePicker {
            changeDate(datePicker)
        }else if pickerType == .otherPicker {
            if selectPickerBlock != nil {
                selectPickerBlock!(result)
            }
        }
        
    }
    
}

extension WJDatePickerView: UIPickerViewDelegate, UIPickerViewDataSource{
    
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
    
}



