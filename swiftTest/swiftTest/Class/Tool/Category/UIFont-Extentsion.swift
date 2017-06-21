//
//  UIFont-Extentsion.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/3.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit


extension UIFont{



     //MARK:- ps字体转换为实际字体
    class func font(psFontSize:CGFloat)->UIFont{
        var size = psFontSize/2
        size = size / 96 * 72
        let font = UIFont.systemFont(ofSize: size)
        return font

    }







}







