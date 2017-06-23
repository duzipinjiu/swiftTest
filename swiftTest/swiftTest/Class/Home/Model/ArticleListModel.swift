//
//  ArticleListModel.swift
//  QiuGuo
//
//  Created by apple on 17/3/6.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit

class ArticleListModel: BaseModel {
    
    //MARK:- 	专题名称
    var Name:String? = ""
    
    //MARK:- 	文章ID
    var ID:Int = 0
    
    //MARK:- 文章标题
    var Title:String? = ""
    
    //MARK:- 封面图片
    var Covers:[String]? = []
    
    //MARK:- 文章描述
    var Description:String? = ""
    
    //MARK:- 是否热门 1 是 0 否
    var IsHot:Int = 0
    
    //MARK:- 评论数量
    var Comments:Int = 0
    
    //MARK:- 标签
    var Tag:String? = ""
    
    //MARK:- 颜色值
    var TagColor:String? = ""

    //MARK:- 是否深度 1 深度 0 否
     var IsProfundity:Int = -1
    
    
    
    //MARK:- 文章的类型
    var articleListType:ArticleListType = .Home
    
}







