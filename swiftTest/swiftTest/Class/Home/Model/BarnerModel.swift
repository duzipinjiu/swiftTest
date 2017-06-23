//
//  BarnerModel.swift
//  QiuGuo
//
//  Created by apple on 17/3/6.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit

class BarnerModel: BaseModel {
    
    /*
     "Title": "球迷故事 | 我因为玩FIFA喜欢上AC米兰",
     "ArticleID": 442,
     "Url": "",
     "Cover": "http://p.qiu.com/upload/banner/201702/28/14882666698858.jpg"
     */

   // MARK: - 描述
    var Title:String? = ""
    // MARK: - 调转url
    var Url:String? = ""
    // MARK: - 文章ID
    var ArticleID:Int = 0
    // MARK: - 图片地址
    var Cover:String? = ""

}
