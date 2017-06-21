//
//  UIImageView-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/3.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView{



    func image(imageName:String) -> UIImageView {
        if let image = UIImage(contentsOfFile: String.localPath(imageName)){
        self.image = image

        }else{
        
            self.image = UIImage(named:imageName)
        }
        return self
   
    }
    
    
    
    
    func kf_setImage(imageUrlStr:String?){
        guard imageUrlStr != nil else {
             return
        }
         let resource = ImageResource(downloadURL:NSURL.init(string:imageUrlStr!) as! URL, cacheKey: imageUrlStr)

        self.kf.setImage(with: resource, placeholder: UIImage(named:"placeholder.png"), options: nil, progressBlock: nil, completionHandler: nil)

    }
    
    
    

}





