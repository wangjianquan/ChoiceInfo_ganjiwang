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

protocol ChoiceInfoSelectItemDelegate: NSObjectProtocol {
    //edit : bool 是否可编辑
    func didSelectItem(_ item_Id: NSInteger, _ edit: Bool)
}

class ChoiceInfoCollectionVC: UICollectionView ,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    weak var selectDelegate: ChoiceInfoSelectItemDelegate?
    lazy var data_Source: NSMutableArray = NSMutableArray()
    
    
    fileprivate func setupUI() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator  = false
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
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
        
        //cell?.title.text = "\(data_Source[indexPath.row])"
        cell?.textField.placeholder = "选择"
        cell?.isUseEnabled = indexPath.row%2 == 0 ? true : false
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if selectDelegate != nil {
            selectDelegate?.didSelectItem(indexPath.row, indexPath.row%2 == 0 ? true : false)
        }
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





