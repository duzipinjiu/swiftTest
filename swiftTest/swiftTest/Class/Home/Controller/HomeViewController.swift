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

        // Do any additional setup after loading the view.
        
        printLog(message: "HomeVC")
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 64, width: 80, height: 80))
        lab.backgroundColor = UIColor.black
        
        view.addSubview(lab)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
