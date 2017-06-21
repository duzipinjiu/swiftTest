//
//  CommUtils.swift
//  swiftTest
//
//  Created by tt on 2017/6/21.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit

class CommUtils: NSObject {
    
    //mark:获取时间方法1
    static func getTimes() -> [Int] {
        
        var timers: [Int] = [] //  返回的数组
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        
        timers.append(comps.year! % 2000)  // 年 ，后2位数
        timers.append(comps.month!)            // 月
        timers.append(comps.day!)                // 日
        timers.append(comps.hour!)               // 小时
        timers.append(comps.minute!)            // 分钟
        timers.append(comps.second!)            // 秒
        timers.append(comps.weekday! - 1)      //星期
        
        return timers;
    }
    //mark:获取时间方法2
    static func getTimeString() -> String {
        // 时间戳的值
        //let nowDate = NSDate(timeIntervalSinceNow: 0)
        //let timeStamp:CLong  = CLong(nowDate.timeIntervalSince1970)
        
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"yyyy-MM-dd HH:mm:ss.SSS"
        
        let strNowTime = timeFormatter.string(from: date as Date) as String
        return strNowTime;
    }

}
