//
//  ChoiceInfoCollectionVC.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-16.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit


fileprivate  let  choiceInfo_Item_width  : CGFloat = (UIScreen.main.bounds.size.width) / 3
let  choiceInfo_Item_height : CGFloat = 60

class ChoiceInfoCollectionVC: UICollectionView ,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    
    lazy var data_Source: NSMutableArray = NSMutableArray()
   
    //选中的 item
    fileprivate lazy var selectedArr = NSMutableArray()
    
    var field_Is_Used:Bool = false

    var isEditFirst: Bool = false
    var currentIndex: IndexPath? {
        didSet{
            collectionView(self, didSelectItemAt: currentIndex!)
        }
    }
    
    var selectedItemBlock: ((_ cell: ChoiceInfoCell , _ index: IndexPath, _ type: String) -> ())?
    
    
    fileprivate func setupUI() {
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator  = false
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
        //允许多选
        self.allowsMultipleSelection = true
        self.isScrollEnabled = false
        self .register(UINib.init(nibName: choiceInfoCell_Id, bundle: nil), forCellWithReuseIdentifier: choiceInfoCell_Id)
        self.reloadData()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupUI()
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return data_Source.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: choiceInfoCell_Id, for: indexPath) as? ChoiceInfoCell
        cell?.choiceModel = data_Source[indexPath.row] as? ChoiceModel
        cell?.index = indexPath.row
        return cell!
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: choiceInfo_Item_width, height: choiceInfo_Item_height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //MARK : -- Cell是否可以选中
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    //MARK : -- Cell多选时是否支持取消功能
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as? ChoiceInfoCell
        let model = data_Source[(indexPath.row)] as? ChoiceModel
        if selectedItemBlock != nil {
            selectedItemBlock!(cell!, (indexPath), (model?.type)!)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ChoiceInfoCell
//        cell?.line.backgroundColor = UIColor.yellow
    }
//
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ChoiceInfoCell
        cell?.backgroundColor = UIColor.groupTableViewBackground
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ChoiceInfoCell
        cell?.backgroundColor = UIColor.white
    }

   
}







