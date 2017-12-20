//
//  PickerVC.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-20.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

class PickerVC: UIViewController {

    lazy var publishTableView: UITableView = {
        let tableview = UITableView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableview.separatorStyle = .none
        tableview.estimatedRowHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.estimatedSectionFooterHeight = 0
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        
        return tableview
    }()
    
    var info: NSMutableArray = NSMutableArray()
    //pickerView显示的数据
    let pickerData : NSMutableArray = ["一月", "二月", "三月", "四月", "五月", "六月",
                                       "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    var title_Str: String?
    var result: String?
    var current_Index:IndexPath?
    var type: String?
    var cell: ChoiceInfoCell?
    
    
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
        automaticallyAdjustsScrollViewInsets = false
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
        registerCell()
        publishTableView.reloadData()
        
       
        
    }
    
    
    fileprivate func registerCell() {
        publishTableView.register(UINib.init(nibName: pickerViewCell_ID, bundle: nil), forCellReuseIdentifier: pickerViewCell_ID)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? 100 : (getLinesWithThree(info) * choiceInfo_Item_height ) + 230);
    }
   
}



extension PickerVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return   (getLinesWithThree(info) * choiceInfo_Item_height ) + 230 + 10
       
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pick_cell = tableView.dequeueReusableCell(withIdentifier: pickerViewCell_ID, for: indexPath) as? PubPickerViewCell
        pick_cell?.pickerView.components = [""]
        pick_cell?.pickerView.pickerType = PickerViewType(rawValue: type!)
        pick_cell?.pickerView.rows_components = pickerData
        pick_cell?.pickerView.title.text = "请选择 · "+title_Str!
    
        pick_cell?.pickerView.trueBlock = {[weak self] (dateString) in
            self?.result = dateString
            pick_cell?.collectionview.currentIndex = self?.current_Index
           
        }
        pick_cell?.collectionview.selectedItemBlock = { [weak self] (cell, index, type)in
            pick_cell?.pickerView.title.text = "请选择 · "+cell.title.text!
            self?.current_Index = index
            cell.textField.text = ""
            cell.textField.text = self?.result
            cell.textField.textColor = UIColor.orange
            pick_cell?.pickerView.pickerType = PickerViewType(rawValue: type)
            
            print("\(String(describing: cell.textField.text))  \(index.row)  \(type)")
        }
    
    
        pick_cell?.collectionview.data_Source = info
    
    
    
        return pick_cell!
    
    }
    
    
}






