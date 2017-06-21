//
//  Date-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/8.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

enum CHDateType {
    case unkwon
    case Today
    case tomorrow
    
}


extension Date{
    

    // 获取日期是星期几
    func getDateWeekDay() ->Int {
        
        let dateFmt         = DateFormatter()
        
        dateFmt.dateFormat  = dateFormaterString
        
        let interval        = Int(self.timeIntervalSince1970)
        
        let days            = Int(interval/86400)
        
        let weekday         = ((days + 4)%7+7)%7
        
        return weekday
        
    }
 
 
    //MARK:- 获取时间的一个机构体
    func getDateComponents() -> DateComponents {
      
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: self)
 
        return comps;
    }


    //MARK:- 比较时间
    func comparedDateWithCurrentDate()->CHDateType{
        let calendar = Calendar.current
        let comp1 = calendar.dateComponents([.year,.month,.day], from: self)
        let comp2 = calendar.dateComponents([.year,.month,.day], from: Date())
        
        //开始比较
        if comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day {
            return .Today
        }else{        
           return .unkwon
        
        }
    }


    //MARK:- 时间间隔
    static func dateInterval(date1:Date,date2:Date) -> DateComponents{
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let result = gregorian?.components([NSCalendar.Unit.day,NSCalendar.Unit.hour], from: date1, to: date2)
        guard result == nil else {
            return result!
        }
        return DateComponents.init()
    }



}











