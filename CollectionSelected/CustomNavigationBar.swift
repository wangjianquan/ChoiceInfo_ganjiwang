//
//  CustomNavigationBar.swift
//  CollectionSelected
//
//  Created by ulinix on 2017-12-19.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let rectStatus = UIApplication.shared.statusBarFrame
//        if (rectStatus.size.height == 44) {
//
//        }else{
//            if #available(iOS 11.0, *) {
//
//                for subview in self.subviews {
//                    let stringFromClass = NSStringFromClass(subview.classForCoder)
//                    print("--------- \(stringFromClass)")
//                    if stringFromClass.contains("BarBackground") {
//                        subview.frame = CGRect(x: 0, y: 20, width: subview.frame.size.width, height: 80)
//                    } else if stringFromClass.contains("UINavigationBarContentView") {
////                        subview.frame = self.bounds
//                        subview.frame = CGRect(x: 0,y:20,width:subview.frame.size.width,height:100)
//
//                    }
//                }
//            }
//        }
//    }
    //set NavigationBar's height
    var customHeight : CGFloat = 56
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        frame = CGRect(x: frame.origin.x, y:  0, width: frame.size.width, height: customHeight)
        
        // title position (statusbar height / 2)
        setTitleVerticalPositionAdjustment(-10, for: UIBarMetrics.default)
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = .yellow
                
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                
                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight)
                
                subview.backgroundColor = .red
                
            }
        }
    }

}
