//
//  ArticleListViewModel.swift
//  QiuGuo
//
//  Created by apple on 17/3/6.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit
//文章列表的类型
enum ArticleListType {
    case Home;//主页
    case MatchDetail;//赛事详情
}

class ArticleListViewModel: BaseViewModel {

     var articleListArr:[ArticleListModel] = []
    //MARK:- 文章ID
    lazy var SpecialID:Int = -1
    
    
    //MARK:- 赛事ID
    lazy var matchID:Int = -1
    //MARK:- 联赛ID（赛事详情界面的资讯才用到）
    lazy var leagueID:Int = -1
    //MARK:- 文章列表的类型
    lazy var articleListType:ArticleListType = .Home

    // MARK: - 加载咨询列表数据
    func loadArticleListData(successCallBack: SucceedBlock?,failureCallBack: FailureBlock?){
        let url = AppRootUrl + "/article/Article/getArticleList"
        var dict = ["page":self.page,"rows":self.rows]
        if self.articleListType == .MatchDetail{
           dict["MatchID"] = self.matchID
             dict["LeagueID"] = self.leagueID
        }else{
        
          dict["SpecialID"] = self.SpecialID
        }
        NetworkTool.request(type: .POST, urlString: url, paramters: dict, finishedCallback: {[weak self] (result) in
            let dataArr = result["data"]["data"]
            var newModelArr = [ArticleListModel]()
            if let arr = dataArr.arrayObject{
                
                for dict in arr  {
                    let model = ArticleListModel.init(dict: (dict as? Dictionary)!)
                    model.articleListType = (self?.articleListType)!
                    newModelArr.append(model)
                }                
            }

            self?.articleListArr = (self?.setupRefresh( preArray: (self?.articleListArr)!, newArray: newModelArr) as? [ArticleListModel])!
            successCallBack!(result)
        }) { (error) in
            failureCallBack!(error)
        }
    }
}
