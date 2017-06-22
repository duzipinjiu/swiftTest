//
//  NavigationController.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/27.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit
class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupUI()
        
    }
    
    //MARK:- 初步设置导航栏
    func setupNavi(){
    
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage.init(), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage.init()
        
        navigationBar.barTintColor = THEMECOLOR
 
        navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.font(psFontSize: 46),NSForegroundColorAttributeName:UIColor.init(hexString: "#ffffff")!]
    }
    

    
    //MARK:- 监听push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count < 1{

        }else{
            viewController.hidesBottomBarWhenPushed = true
     
        
        }
        
        super.pushViewController(viewController, animated: animated)
        
    }
    

    
    func setupUI(){
        
    
    }
    
    
    
    
    
    
}
