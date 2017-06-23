//
//  HomeViewController.swift
//  swiftTest
//
//  Created by tt on 2017/6/22.
//  Copyright © 2017年 tangwei. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        printLog(message: "HomeVC")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let homeDetailVC = HomeDetailViewController()
        navigationController?.pushViewController(homeDetailVC, animated: true)
    }

    override func loadData() {
        super.loadData()
        
        let url = AppRootUrl + "/article/Article/getSpecials"
        NetworkTool.request(type: .POST, urlString: url, paramters: nil, finishedCallback: {[weak self] (result) in
            let dataArr = result["data"]
            
//            if let arr = dataArr.arrayObject{
//                self?.spericalModels = []
//                for dict in arr  {
//                    let model = SpecialModel.init(dict: (dict as? Dictionary)!)
//                    
//                    self?.spericalModels.append(model)
//                }
//            }
//            success(result)
            printLog(message: result)
        }) { (error) in
            
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
