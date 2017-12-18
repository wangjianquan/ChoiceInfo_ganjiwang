//
//  WJDatePickerView.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-18.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

class WJDatePickerView: UIView {

    var cancelBlock: ( ()->() )?
    var trueBlock:   ( (_ dateStr: String)->() )?
//    var changeDateBlock: ( (_ string: String)->() )?
   
    fileprivate var btnColor : UIColor = UIColor.black
    
    lazy var lineView: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40))
        lineView.layer.borderColor = UIColor(white: 0.94, alpha: 1).cgColor
        lineView.layer.borderWidth = 1.0
        return lineView
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
        let label = UILabel(frame: CGRect(x: cancelBtn.frame.size.width + space, y:0 , width: lineView.frame.size.width - 2 * btn_Width - 2 * space, height: lineView.frame.size.height))
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
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: lineView.frame.size.height, width: self.frame.size.width, height: self.frame.size.height - lineView.frame.size.height))
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
        let maxDate = datePicker.date
        datePicker.maximumDate = maxDate
        datePicker.addTarget(self, action: #selector(changeDate(_:)), for: .valueChanged)
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        addSubview(lineView)
        lineView.addSubview(self.cancelBtn)
        lineView.addSubview(self.title)
        lineView.addSubview(self.trueBtn)
        
        addSubview(datePicker)
    }
    
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
       changeDate(datePicker)
    }

}
