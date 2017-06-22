//
//  RefreshFooterView.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/8.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import Foundation
import UIKit

class RefreshFooterView: UIView {
    //MARK:- 刷新动画图片
    fileprivate let imageView = UIImageView()
    
    //MARK:- 正在刷新label
    fileprivate let loadingLabel:UILabel = UILabel(text: "加载中...", font: UIFont.font(psFontSize: 34), textColor: UIColor.init(hexString: "4d4d4d"))
    
    //MARK:- 提示没有可加载更多的数据了
    fileprivate let noMoreDataLabel:UILabel = UILabel(text: "再往上拉,就出界了~", font: UIFont.font(psFontSize: 36), textColor: UIColor.init(hexString: "#999999"))
    
    //MARK:- 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        addSubview(imageView)
        imageView.snp.remakeConstraints { (make) in
            make.right.equalTo(imageView.superview!.snp.centerX).offset(-5)
             make.centerY.equalTo(imageView.superview!)
  
        }
        
        
        
        addSubview(loadingLabel)
        loadingLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(loadingLabel.superview!.snp.centerX)
            make.centerY.equalTo(loadingLabel.superview!)
        }
        
        
        addSubview(noMoreDataLabel)
        noMoreDataLabel.snp.remakeConstraints { (make) in
            make.centerX.centerY.equalTo(noMoreDataLabel.superview!)
        }

        noMoreDataLabel.isHidden = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



// MARK: - RefreshFooterView
extension RefreshFooterView:RefreshableFooter{
    

    /**
     触发动作的距离，对于header/footer来讲，就是视图的高度；对于left/right来讲，就是视图的宽度
     */
    func heightForRefreshingState()->CGFloat{
        return 70
    }
    /**
     不需要下拉加载更多的回调
     */
    func didUpdateToNoMoreData(){
        noMoreDataLabel.isHidden = false
        imageView.isHidden = true
        loadingLabel.isHidden = true    
       
    }

    /**
     重新设置到常态的回调
     */
    func didResetToDefault(){}

    /**
     结束刷新的回调
     */
    func didEndRefreshing(){
        
        imageView.animationImages = nil
        imageView.stopAnimating()
        imageView.isHidden = true
        noMoreDataLabel.isHidden = true
        loadingLabel.isHidden = true
        
    }

    /**
     已经开始执行刷新逻辑，在一次刷新中，只会调用一次
     */
    func didBeginRefreshing(){
        imageView.isHidden = false
        loadingLabel.isHidden = false
        var imageNames = [String]()
        for index in 1...12 {
            imageNames.append("up_move_loading_\(String(format: "%02d", index))")
        }
        let images = imageNames.map { (name) -> UIImage in
            return UIImage(named:name)!
        }
        
        imageView.animationImages = images
        imageView.animationDuration = Double(images.count) * 0.1
        imageView.startAnimating()
    }

    
    /**
     当Scroll触发刷新，这个方法返回是否需要刷新
     */
    func shouldBeginRefreshingWhenScroll()->Bool{
        noMoreDataLabel.isHidden = true
        imageView.image = UIImage(named:"up_move_loading_01")

        return true
    }

    
    
    
    
    
    
    
    


}
