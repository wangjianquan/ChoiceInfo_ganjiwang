//
//  PubChoiceCollectionCell.swift
//  Classified_Information
//
//  Created by ulinix on 2017-12-15.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

protocol PubChoiceCollectionCellDelegate : NSObjectProtocol{
    func SelectedArrays(_ selectedItems: NSMutableArray)
}

let choiceCollectionCell_Id = "PubChoiceCollectionCell"

let choice_item_Height: CGFloat  = 35

class PubChoiceCollectionCell: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
   
    weak var delegate: PubChoiceCollectionCellDelegate?
    
   fileprivate  lazy var dataSource = NSMutableArray()
   
    //选中的 item
   fileprivate lazy var selectedArr = NSMutableArray()
   
    //是否支持多选
    var multipleSelected : Bool = false
   
    // 区别 取消选中和选中调用的方法
    fileprivate  var deselect: Bool = false
    
    func configureCellData(_ titles: NSMutableArray ) {
        //允许多选
        collection.allowsMultipleSelection = multipleSelected
        dataSource = titles
        collection.reloadData()
    }
    

    
    var choiceSelectedArrayBlock: (() -> (NSMutableArray))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.register(UINib.init(nibName: choiceItemCell_Id, bundle: nil), forCellWithReuseIdentifier: choiceItemCell_Id)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PubChoiceCollectionCell : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: choiceItemCell_Id, for: indexPath) as? ChoiceItemCell
        cell?.titleLabel.text = ("\(dataSource[indexPath.row])")
        cell?.titleLabel.tag = indexPath.row
        
        if (cell?.isSelected)! {
            cell?.backgroundColor = UIColor.orange
        }else {
            cell?.backgroundColor = UIColor(white: 0.935, alpha: 1.0)
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.size.width - 4 * 15)/3 , height: choice_item_Height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 15, 0, 15)
    }
   
    //MARK : -- Cell是否可以选中
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK : -- Cell多选时是否支持取消功能
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: -- Cell选中调用该方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? ChoiceItemCell
        cell?.backgroundColor = UIColor.orange
        deselect = false
       
        if let title = cell?.titleLabel.text {
            if delegate != nil {
               delegate?.SelectedArrays(changeSelectStateWithCell(title,  deselect))
            }
        }
       
        
    }
    
    //MARK: -- Cell取消选中调用该方法
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      let cell = collectionView.cellForItem(at: indexPath) as? ChoiceItemCell
      cell?.backgroundColor = UIColor(white: 0.935, alpha: 1.0)
      deselect = true
     
        if let title = cell?.titleLabel.text {
            
            if delegate != nil {
                delegate?.SelectedArrays(changeSelectStateWithCell(title,  deselect))
            }
            
        }
        
    }
    
 fileprivate   func changeSelectStateWithCell(_ title: String, _ deselect: Bool) -> NSMutableArray{
        if deselect == false {
            
            if multipleSelected == false && selectedArr.count > 0 {
                selectedArr.removeAllObjects()
            }
            selectedArr.add(title)
            
        } else {
            
            selectedArr.remove(title)
            
        }
        return selectedArr
    }
    
    
   
}





















