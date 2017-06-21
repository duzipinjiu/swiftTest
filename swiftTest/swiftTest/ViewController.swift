//
//  ViewController.swift
//  swiftTest
//
//  Created by 汤为 on 2017/4/22.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nowDate = NSDate(timeIntervalSinceNow: 0)
        // 时间戳的值
        let timeStamp:CLong  = CLong(nowDate.timeIntervalSince1970)
        
        
        let date = NSDate()
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"yyyy-MM-dd HH:mm:ss.SSS"
        
        let strNowTime = timeFormatter.string(from: date as Date) as String
        print(strNowTime)
    }
    func getTimes() -> [Int] {
        
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
}

