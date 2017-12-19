//
//  Pub_RentingVC.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-14.
//  Copyright © 2017 wjq. All rights reserved.
//租房

import UIKit

class Pub_RentingVC: UIViewController{

    lazy var publishTableView: UITableView = {
      let tableview = UITableView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableview.estimatedRowHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.estimatedSectionFooterHeight = 0
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)

        return tableview
    }()
    
    var titles: NSMutableArray = ["TV","washer","空调","宽带","热水器","冰箱","床","燃气灶","沙发"]
    var info: NSMutableArray = ["户型","面积","租金","楼层","装修","朝向"]
   
    @objc fileprivate func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "租房"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        registerCell()
        publishTableView.reloadData()
    }
    
    fileprivate func registerCell() {
        
        publishTableView.register(UINib.init(nibName: choiceCollectionCell_Id, bundle: nil), forCellReuseIdentifier: choiceCollectionCell_Id)
        
        publishTableView.register(UINib.init(nibName: pubInfoCollCell_ID, bundle: nil), forCellReuseIdentifier: pubInfoCollCell_ID)
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
extension Pub_RentingVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        
        if indexPath.row == 0 {
            return   (getLinesWithThree(info) * choiceInfo_Item_height )
            
        } else if indexPath.row == 1 {
            let total_Space = ((getLinesWithThree(titles)-1)*10)
            return   (getLinesWithThree(titles) * choice_item_Height + total_Space + (15 + 18)+10 )
        }
            return 0
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: pubInfoCollCell_ID, for: indexPath) as? PubInfoCollectionCell
            cell?.collection.data_Source = info
            cell?.collection.selectDelegate = self
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: choiceCollectionCell_Id, for: indexPath) as? PubChoiceCollectionCell
            cell?.multipleSelected = false
            cell?.delegate = self
            cell?.configureCellData(titles)
            return cell!
        }
        
    }
    
   
    
    
}


//MARK: PubChoiceCollectionCellDelegate
extension Pub_RentingVC : PubChoiceCollectionCellDelegate {
    
    func SelectedArrays(_ selectedItems: NSMutableArray) {
        print(" ==== \(selectedItems)")
    }
    
}

//MARK: -- ChoiceInfoSelectItemDelegate
extension Pub_RentingVC : ChoiceInfoSelectItemDelegate {
    func didSelectItem(_ cell: ChoiceInfoCell, _ item_Id: NSInteger, _ edit: Bool) {
        
        let toView = PickerInfoController()
        toView.dataSource = info
        toView.title_Str = cell.title.text!
        toView.collection.cell = cell
        toView.current_Index =  item_Id
        toView.edit = edit
        
//        toView.resultBlock = {[weak self] (result_Str) in
//            cell.textField.text = result_Str
//            print("result --> \(result_Str)")
//        }
        let animator: FromBottomAnimator = FromBottomAnimator(presentedViewController: toView, presenting: self)
        toView.transitioningDelegate = animator
        present(toView, animated: true, completion: nil)
        
    }
    
}













