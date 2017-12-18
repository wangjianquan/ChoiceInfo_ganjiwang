//
//  ViewController.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-15.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
  
   

    @IBOutlet weak var collection: UICollectionView!
    var dataSource = NSMutableArray(array: ["AA","BB","CC","DD","EE","OO","GG",])
    var selectedArr = NSMutableArray()
    var Deselect: Bool = false
    
    //是否支持多选
    var multipleSelected : Bool = true
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //允许多选
        collection.allowsMultipleSelection = multipleSelected
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell
        cell?.title.text = dataSource[indexPath.row] as? String
        if (cell?.isSelected)! {
            cell?.backgroundColor = UIColor.blue
        }else {
            cell?.backgroundColor = UIColor.orange
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 88, height: 40)
    }
    

    
    // MARK: --Cell是否可以选中
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: -- Cell多选时是否支持取消功能
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: -- Cell选中调用该方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.backgroundColor = UIColor.blue
        Deselect = false
        if let title = cell?.title.text {
            changeSelectStateWithCell(title, deselect: Deselect)
        }

    }
    
    // MARK: -- Cell取消选中调用该方法
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
        cell?.backgroundColor = UIColor.orange
        Deselect = true
        if let title = cell?.title.text {
             changeSelectStateWithCell(title, deselect: Deselect)
        }

       
        
    }
    
    func changeSelectStateWithCell(_ title: String, deselect: Bool){
        if deselect == false {
            
            if multipleSelected == false && selectedArr.count > 0 {
                selectedArr.removeAllObjects()
            }
            selectedArr.add(title)
            
        } else {
            
            selectedArr.remove(title)

        }
        print(" selectedArr = \(selectedArr)")
    }
    

}

