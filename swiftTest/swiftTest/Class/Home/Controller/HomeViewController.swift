//
//  HomeViewController.swift
//  swiftTest
//
//  Created by tt on 2017/6/22.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: BaseViewController {
    var titleArrM = NSMutableArray.init()
    var matchArrM = NSMutableArray.init()
    //MARK:- 当前页
    lazy var page:Int=1
    //MARK:- 一页多少
    lazy var rows:Int=10
    //MARK:- 刷新的类型
    lazy var refreshType:ViewModelRefreshType? = .PullDownRefresh
    //MARK:- 上啦加载的时候是否还有下一页
    lazy var isEnd:String?="0"
    //MARK:- 下拉刷新的时候是否还有上一页
    lazy var isHead:String?="0"
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        let titles = ["推荐", "游戏", "娱乐", "体育"]//self?.titleArrM//
        let titleView = PageTitleView(frame: titleFrame, titles: titles as! [String])
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView: PageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentFrame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for a in 0..<4 {
            let controller = ArticleListViewController()
            let vc = ArticleListViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
            
            let lable = UILabel.init(frame: CGRect.init(x: 30, y: 40, width: 50, height: 60))
            var stringA = "第 \(a) 页 "
            lable.text = stringA
            lable.textColor = UIColor.black
            vc.view.addSubview(lable)
            childVcs.append(vc)
        }
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        
        return pageContentView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        printLog(message: "HomeVC")
        // 设置UI界面
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let homeDetailVC = HomeDetailViewController()
//        navigationController?.pushViewController(homeDetailVC, animated: true)
    }

    override func loadData() {
        super.loadData()
        let model1 = SpecialModel.init()
        model1.SpecialID = 1
        model1.Name = "米兰"
        model1.Weight = 200
        self.matchArrM.add(model1)
        self.setupUI()
//        let url = AppRootUrl + "/article/Article/getSpecials"
//        NetworkTool.request(type: .POST, urlString: url, paramters: nil, finishedCallback: {[weak self] (result) in
//
//            let dataArr:Array<NSDictionary> = result["data"].arrayObject as! Array<NSDictionary>
//            for (_,dict) in (dataArr.enumerated()){
//                let aaa = dict["Name"]
//                self?.titleArrM .add(aaa)
//                let model = SpecialModel.init(dict: (dict as? Dictionary)!)
//                self?.matchArrM.add(model)
//            }
//            if dataArr.count > 0{
//                self?.requestBySpecialID(index: 0)
//            }
////            success(result)
//
//            self?.setupUI()
//            printLog(message: result)
//        }) { (error) in
//
//        }

    }
 
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
            printLog(message: result)
        }) { (error) in
            failureCallBack!(error)
        }
    }

    //MARK:- 设置刷新基本数据
    func setupRefresh(isHead:String="",isEnd:String="", preArray:[Any],newArray:[Any]) -> [Any] {
        
        
        if self.refreshType == .PullDownRefresh{
            if isHead.isEmpty {
                if newArray.count <= self.rows {
                    //1:有 0:无 5:无效
                    self.isHead = "1"
                }else{
                    self.isHead = "0"
                }
            }
            self.isEnd = "5"
            return newArray
        }else{
            if isEnd.isEmpty{
                if newArray.count < self.rows {
                    self.isEnd = "0"
                }else{
                    self.isEnd = "1"
                }
            }
            self.isHead = "5"
            var array = preArray
            array.append(contentsOf: newArray)
            return array
            
        }
    }
    
    //热门、原创等头标题
    func requestBySpecialID(index:NSInteger) {
        let model = self.matchArrM[index] as! SpecialModel
        self.SpecialID = model.SpecialID
        self.articleListType = .Home
//        self.loadArticleListData(successCallBack: { (result) in
//            self.setupChildVcs()
//        }) { (error) in
//
//        }
        self.setupChildVcs()
    }
    // MARK: -  设置界面
    func setupChildVcs(){
        if self.matchArrM.count > 0 {
            var childVcs:[ArticleListViewController] = []
            for model in self.matchArrM {
                let controller = ArticleListViewController()
                let tempM = model as! SpecialModel
                controller.articleViewModel.SpecialID = tempM.SpecialID
                childVcs.append(controller)
            }
            
            let pageMenuHeight = 120*LayoutHeightScale
            let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + pageMenuHeight, width: ScreenWidth, height: ScreenHeight - kStatusBarH - kNavigationBarH-pageMenuHeight-kTabBarH)
            
            pageContentView = PageContentView.init(frame: contentFrame, childVcs: childVcs, parentViewController: self)
            view.addSubview(pageContentView)
            pageContentView.delegate = self
            
            pageContentView.snp.remakeConstraints({ (make) in
                make.top.equalTo((pageTitleView.snp.bottom))
                make.left.right.bottom.equalTo((pageContentView.superview)!)
            })
        }
    }
}



// MARK:- 设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI() {
        
        // 1.添加TitltView
        view.addSubview(pageTitleView)
        
        // 2.添加contentView
        view.addSubview(pageContentView)
        
    }
    
}

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitltView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
        self.requestBySpecialID(index: index)
    }
}

// MARK:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
