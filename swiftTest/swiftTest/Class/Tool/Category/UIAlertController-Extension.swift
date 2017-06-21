//
//  UIAlertController-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/2.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

extension UIAlertController{
    


   class func alert(title:String,message:String,style:UIAlertControllerStyle,doneTitle:String, doneAction:((UIAlertAction) -> Swift.Void)? = nil,cancelTitle:String, cancelAction: ((UIAlertAction) -> Swift.Void)? = nil,destruectiveTitle:String, destructiveAction:((UIAlertAction) -> Swift.Void)? = nil)->UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        if doneTitle.characters.count != 0{
            let done = UIAlertAction(title: doneTitle, style: .default, handler: nil)
            alertController.addAction(done)
        }
        
        if cancelTitle.characters.count != 0{
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            
            alertController.addAction(cancel)
        }
       
        if destruectiveTitle.characters.count != 0{
        
            let destruective = UIAlertAction(title: destruectiveTitle, style: .destructive , handler: nil)
            alertController.addAction(destruective)
        }
       
        
        return alertController
   
    }
    
    class func alert(title:String?,message:String?,style:UIAlertControllerStyle,actions:[UIAlertAction]?)->UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
       
        for action in actions! {
             alertController.addAction(action)
        }
        
        return alertController
        
    }
    

    
    











}
