//
//  FDFeedViewController.swift
//  swiftTest
//
//  Created by TW on 2018/4/17.
//  Copyright © 2018年 tangwei. All rights reserved.
//

import UIKit

class FDFeedViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let tableview = UITableView()
    //MARK:- 内容数组
    var contentArrM = NSMutableArray.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.frame = CGRect(x: 0, y: 0, width: width, height: height-64-49)
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = UIView()
        self.view.addSubview(tableview)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let jsonPath = Bundle.main.path(forResource: "data", ofType: "json")
        let data = NSData.init(contentsOfFile: jsonPath!)
        let jsonDic:NSDictionary = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
        let jsonTemp:NSDictionary = jsonDic.object(forKey: "feed") as! NSDictionary
        
        let tempArr1:Array<NSDictionary> = jsonTemp.object(forKey: "data")as! Array<NSDictionary>
        for (_,dict) in (tempArr1.enumerated()){
            let model = FDFeedEntity.init(dict: (dict as? Dictionary)!)
            self.contentArrM.add(model)
        }
        self.tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArrM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let str = "section"
        var cell:HomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: str) as? HomeTableViewCell
        if cell == nil {
            //            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: str)
            cell = UINib.init(nibName: "HomeTableViewCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? HomeTableViewCell
        }
        let model = self.contentArrM[indexPath.row] as? FDFeedEntity
        cell?.titleLabel?.text = model?.title//"这是第\(indexPath.section+1)个字段,第\(indexPath.row)个cell"
        //  使用SDWebImage会崩溃，目前具体原因尚不清楚
        //        cell?.imageView?.sd_setImage(with: URL.init(string: (model!.Covers[0] as! String)))
        cell?.iconImgV?.kf_setImage(imageUrlStr: model?.imageName)
        cell?.iconImgV?.contentMode = UIViewContentMode.scaleAspectFit
        return cell!
    }

}
