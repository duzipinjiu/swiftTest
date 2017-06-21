//
//  HUDTool.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/6.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit
import SVProgressHUD

enum HudShowType {
    case Load;
    case Success;
    case Failure;
    case Info;
    
}

class HUDTool: NSObject {
    
    class func show(showType:HudShowType, text:String?="",detialText:String?="",imageName:String?="",viewController:UIViewController?=nil){
        DispatchQueue.main.async {
            switch showType{
            case .Load:
                 SVProgressHUD.show()
            case .Success:
                SVProgressHUD.showSuccess(withStatus: text)
            case .Failure:
                SVProgressHUD.showError(withStatus: text)
            case .Info:
                SVProgressHUD.showInfo(withStatus: text)

            }
           
 
        }
        
    
    }
    

    class func dismiss(){
    
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            
            
        }
    
    }
    
    
    






}
