//
//  InformationViewController.swift
//  swiftTest
//
//  Created by apple on 17/3/6.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit


private let normalInformationCell = "informationCell"
 let shuffingFigureCell = "shuffingFigureCell"
private let horizontalArticleCell = "horizontalArticleCell"



class ArticleListViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
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
    let dataArrM = NSMutableArray.init()
    
    //MARK:- 请求文章列表数据viewModel
    lazy var articleViewModel:ArticleListViewModel = ArticleListViewModel()
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let tableview = UITableView()
    var clickNum: Int?
    var getClickNum: Int?
    
    //MARK:- 内容数组
    var contentArrM = NSMutableArray.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.frame = CGRect(x: 0, y: 0, width: width, height: height-64-49)
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = UIView()
        clickNum = 180;
        self.view.addSubview(tableview)
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SpecialID = self.articleViewModel.SpecialID
        self.loadArticleListData(successCallBack: { (result) in
            let jsonPath = Bundle.main.path(forResource: "ArticleList", ofType: "json")
            let data = NSData.init(contentsOfFile: jsonPath!)
            let jsonDic:NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            let jsonTemp:NSDictionary = jsonDic.object(forKey: "data") as! NSDictionary
            
            let tempArr1:Array<NSDictionary> = jsonTemp.object(forKey: "data")as! Array<NSDictionary>
            for (_,dict) in (tempArr1.enumerated()){
                let model = ArticleDetailModel.init(dict: (dict as? Dictionary)!)
                self.contentArrM.add(model)
            }
            self.tableview.reloadData()
            if result["data"].isEmpty{
                return
            }
//            let tempArr:Array<NSDictionary> = result["data"]["data"].arrayObject as! Array<NSDictionary>
//            for (_,dict) in (tempArr.enumerated()){
//                let model = ArticleDetailModel.init(dict: (dict as? Dictionary)!)
//                self.contentArrM.add(model)
//            }
//            self.tableview.reloadData()
//            printLog(message: result)
        }) { (error) in
            
        }
    }
    func prepareFileManger(fileName: String,text: String) -> (String,URL){
        //get userDirectory path
        let manager = FileManager.default
        let document = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = document.first!
        
        //read return file content or create blank file
        let fileURL = docURL.appendingPathComponent(fileName)
        
        if manager.fileExists(atPath: fileURL.path) {
            if let content = manager.contents(atPath: fileURL.path),let text = String(data: content, encoding: .utf8){
                
                return (text,fileURL)
            }else {
                manager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            }
        }
        return ("",fileURL)
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

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 10, y: 0, width: width-20, height: 50))
        view.backgroundColor = UIColor.lightGray
        let title = UILabel()
        title.frame = CGRect(x: 10, y: 10, width: width-20, height: 30)
        title.tag = section
        title.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(tap:)))
//        title.addGestureRecognizer(tap)
//        let model = ArticleDetailModel.init(dict: (self.contentArrM[section] as? Dictionary)!)
//        title.text = "这是第\(section)分组"
//        view.addSubview(title)
        return view
        
    }
    func tap(tap:UITapGestureRecognizer) {
        clickNum = tap.view?.tag
        if getClickNum == clickNum {
            
            clickNum = 180
        }
        tableview.reloadData()
        getClickNum = clickNum
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArrM.count
        
        let arr = [2,4,6,8,10]
        if clickNum == 180 {
            
            return 0
            
        }else{
            if section == clickNum {
                
                return arr[section]
                
            }else{
                
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str = "section"
        var cell = tableView.dequeueReusableCell(withIdentifier: str)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: str)
        }
        let model = self.contentArrM[indexPath.row] as? ArticleDetailModel
        
        cell?.textLabel?.text = model?.title//"这是第\(indexPath.section+1)个字段,第\(indexPath.row)个cell"
        return cell!
    }

    
    // MARK: - 请求数据
    override func loadData() {
        super.loadData()
    }
    
    
    
    


}

















