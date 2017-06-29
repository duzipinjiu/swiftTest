//
//  BaseModel.swift
//  QiuGuo
//
//  Created by tangwei on 2017/2/27.
//  Copyright © 2017年 tangwei. All rights reserved.
//
import UIKit

class BaseModel: NSObject {
    
    
       convenience init(dict : [String : Any]) {
            self.init()
            setValuesForKeys(dict)
        }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
    }
    
        override func setValue(_ value: Any?, forUndefinedKey key: String) {
            if key.isEmpty{
                super.setValue(value, forUndefinedKey: key)
            }
        }
    
    

    

}
