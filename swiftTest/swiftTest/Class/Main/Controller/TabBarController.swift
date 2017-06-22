//
//  TabBarController.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/27.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

class TabBarController : UITabBarController{
   
   //MARK:类初始化的时候调用，只调用一次
    override class func initialize() {
        var attrs = [String:NSObject]()
        attrs[NSForegroundColorAttributeName] = THEMECOLOR
        // 设置tabBar字体颜色
        UITabBarItem.appearance().setTitleTextAttributes(attrs, for:.selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addchildViewControllers();
        
        
        setupUI()
        
      
        
    }
    
    //MARK:- 设置界面
    func setupUI() {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 49))
        backView.backgroundColor = UIColor.white
        tabBar.insertSubview(backView, at: 0)
        tabBar.isOpaque = true
    }
    
   

    /**
     添加子控制器
     */
    func addchildViewControllers(){

        /*
         {
         "vcName": "GuessViewController",
         "title": "竞猜",
         "imageName": "tabbar_quiz"
         },
         */
    
        let jsonPath = Bundle.main.path(forResource: "MainJson.json", ofType: nil)
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonPath!))
        let jsonArr = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:String]]
        for dict in jsonArr {
            setupOneChildViewController(childControllerName: dict["vcName"]!, imageName: dict["imageName"]!, title: dict["title"]!)
            
        }
    }
    
    
    /**
     添加一个子控制器
     
     - parameter childControllerName: 控制器的类名
     - parameter imageName:           tabbar的图片
     - parameter title:               tabbar的text
     */
    func setupOneChildViewController( childControllerName: String,imageName:String,title:String) {
        
        let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"]

        let className = (spaceName as! String) + "." + childControllerName
        let vcClass:AnyClass = NSClassFromString(className)!
        //告诉编译器实际的类型
        let trueClass = vcClass as! UIViewController.Type
        let childController = trueClass.init()
        childController.tabBarItem.title = title
        childController.view.backgroundColor = UIColor.white
        
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_h")?.withRenderingMode(.alwaysOriginal)
        
        let navi = NavigationController(rootViewController: childController)
        addChildViewController(navi)
        
        
    }
    
    




}











