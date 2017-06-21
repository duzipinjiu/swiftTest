//
//  UIImage-Extenstion.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/3.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

extension UIImage{




   class  func getImage(_ imageName:String) -> UIImage? {
    if let image = UIImage(contentsOfFile: String.localPath(imageName)){
    
    
        return image
    }else{
        if let image =  UIImage(named: imageName) {
            return image
        }
       
    }
   
    return nil
    
    }


}








