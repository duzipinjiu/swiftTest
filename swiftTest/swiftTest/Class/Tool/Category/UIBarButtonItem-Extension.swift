//
//  UIBarButtonItem-Extension.swift
//  QiuGuo
//
//  Created by apple on 17/3/5.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName : String, highlightedImage : String? = "" , size : CGSize = CGSize.zero, target:UIViewController? = nil, action:Selector?=nil) {
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highlightedImage != ""{
            btn.setImage(UIImage(named : highlightedImage!), for: .highlighted)
        }
        if size != CGSize.zero{
            btn.frame = CGRect (origin: CGPoint.zero, size: size)
        }else
        {
            btn.sizeToFit()
        }
        if target != nil,action != nil{
          btn.addTarget(target, action: action!, for: .touchUpInside)
        }
      
        self.init(customView: btn)
    }
}
