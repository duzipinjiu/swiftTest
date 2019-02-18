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
            if a == 1   {
                let vc1 = FDFeedViewController()
                childVcs.append(vc1)
                continue
            }
//            let controller = ArticleListViewController()
            let vc = ArticleListViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
            
            let lable = UILabel.init(frame: CGRect.init(x: 30, y: 40, width: 50, height: 60))
            var stringA = "第 \(a) 页 "
            lable.text = stringA
            lable.textColor = UIColor.black
//            vc.view.addSubview(lable)
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
    
    override func loadData() {
        super.loadData()
        let model1 = SpecialModel.init()
        model1.SpecialID = 1
        model1.Name = "米兰"
        model1.Weight = 200
        self.matchArrM.add(model1)
        self.setupUI()

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
    
    // MARK: - 加载列表数据
    //MARK:- 设置刷新基本数据
    
    // MARK: -  设置界面
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
//        self.requestBySpecialID(index: index)
    }
}

// MARK:- 遵守PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
