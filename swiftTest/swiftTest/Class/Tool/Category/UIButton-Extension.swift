//
//  UIButton-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/28.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

extension UIButton
{
    convenience init(title: String?,backgroundColor:UIColor?=nil, imageName: String?=nil,backImageName:String?=nil, highlightedImageName:String?=nil,selBackImageName:String?=nil, target: Any?=nil ,selector: Selector?=nil, font: UIFont?=nil, titleColor: UIColor?=nil,selTitleColor:UIColor?=nil) {
        self.init()
        if let imageN = imageName {
            setImage(UIImage(named:imageN), for: UIControlState())
        }
        if let backColor = backgroundColor{
           self.backgroundColor = backColor
        
        }
        if let newBackImageName = backImageName{
            setBackgroundImage(UIImage(named:newBackImageName), for: .normal)
        
        }
        if let hImage = highlightedImageName{
      
            let image = UIImage(contentsOfFile: String.localPath(hImage))
            setImage(image, for: .highlighted)
        
        }
        if let selImage = selBackImageName{
          
             setBackgroundImage(UIImage(named:selImage), for: .selected)
        }
        if let newFont = font {
         titleLabel?.font = newFont
        
        }
        if let newColor = titleColor {
            
            setTitleColor(newColor, for: .normal)
        }
       
        if let newTitle = title {
            setTitle(newTitle, for: UIControlState()) 
        }
       
       
        if let sel = selector {
            addTarget(target, action: sel, for: .touchUpInside)
        }
        
        if let selColor = selTitleColor{
            
           setTitleColor(selColor, for: .selected)
        }
        
    }
}
