//
//  NSString-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/28.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

extension String{
    
   
    
  
    static func localPath(_ localFileName:String) -> String {
      
        if  let path = Bundle.main.path(forResource: localFileName, ofType: nil)  {
            return path;
        }
            return ""
        
    }
    
    
    func md5String(str:String) -> String{
        let cStr = str.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
    
    
    func cacheStr()->String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath = (path as NSString).appendingPathComponent(self)
        return filePath
    }
    func docStr()->String{
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                FileManager.SearchPathDomainMask.userDomainMask, true)
       
        let filePath = (documentPaths[0] as NSString).appendingPathComponent(self)
        return filePath
    }
    func tmpStr()->String{
        let path = NSTemporaryDirectory()
        let filePath = (path as NSString).appendingPathComponent(self)
        return filePath
    }
    
    
    
   
    //MARK:- 字符串得到Date
    static func getDateFromString(dateStr:String?="",formatter:String?=dateFormaterString)->Date?{
        let f = DateFormatter()
        f.dateFormat = formatter
        let date = f.date(from: dateStr!)
        return date
    }
    
    //MARK:- 从Int获取星期
   static func weekStringFromInt(date:Int)->String{
        switch date {
        case 2:
            return  "一"
        case 3:
            return "二"
        case 4:
            return "三"
        case 5:
            return "四"
        case 6:
            return "五"
        case 7:
            return "六"
        case 1:
            return "日"
            
        default:
            return "--"
        }
    
    }
    
    
    

    //MARK:- 从int转换成string
    static func getString(intData:Int?) -> String{
      let string = String(format: "%d", intData ?? 0)
        return string
    }
    
  
    
    

}












