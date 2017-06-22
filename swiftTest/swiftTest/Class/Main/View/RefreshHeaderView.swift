//
//  RefreshHeaderView.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/8.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import Foundation

import UIKit

class RefreshHeaderView: UIView {
    //MARK:- 刷新动画图片
    fileprivate let imageView = UIImageView()
    
    //MARK:- 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = CGRect(x: 0, y: 0, width: 27, height: 25)
        imageView.center = CGPoint(x: self.bounds.width/2.0, y: self.bounds.height/2.0)
        addSubview(imageView)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}

// MARK: - 遵守RefreshableHeader协议
extension RefreshHeaderView:RefreshableHeader{
    
    //MARK:- 刷新时的高度
    func heightForRefreshingState() -> CGFloat {
        return 70
    }
    
    //MARK:- 监听下拉百分比变化
    func percentUpdateDuringScrolling(_ percent: CGFloat) {
        imageView.isHidden = (percent == 0)
        let adjustPercent = max(min(1.0, percent), 0.0)
        let scale = 0.2+(1.0-0.2)*adjustPercent
        imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        //22:图片总的张数
        let mappedIndex = Int(adjustPercent * 22)
        let imageName = "pull_down_-loading_\(String(format: "%02d", mappedIndex))"
        imageView.image = UIImage(named:imageName)
         
    }
    
    //MARK:- 松手即将刷新的状态
    func didBeginRefreshingState() {
        var imageNames = [String]()
        for index in 1...22 {
             imageNames.append("pull_down_-loading_\(String(format: "%02d", index))")
        }
        let images = imageNames.map { (name) -> UIImage in
            return UIImage(named:name)!
        }
        
        imageView.animationImages = images
        imageView.animationDuration = Double(images.count) * 0.08
        imageView.startAnimating()
        
    }
    
    //MARK:- 将要隐藏header
    func didBeginEndRefershingAnimation(_ result: RefreshResult) {
        
    }

    //MARK:- 完全隐藏header
    func didCompleteEndRefershingAnimation(_ result: RefreshResult) {
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.isHidden = true
        
    }


}
























