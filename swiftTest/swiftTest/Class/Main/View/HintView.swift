//
//  HintView.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/14.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit


/// 项目整体提示view
class HintView: BaseView {
    
    
    //MARK:- 初始化
    init(_ imageName:String="no_data.png",textArr:[String]=["抱歉，暂无数据"]){
        super.init(frame: CGRect.zero)
        
         //提示图片
        let imageView = UIImageView.init(image: UIImage.getImage(imageName))
        addSubview(imageView)
        
        imageView.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(imageView.superview!)
           
        })
        
        //占位空格，便于布局
        let label = UILabel()
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalTo(imageView)
            make.height.equalTo(40*LayoutHeightScale)
            
        }
        
        
        //提示文字
        var preView:UIView = label
        for string in textArr {
            let label = createHintLabel(text: string)
            addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.centerX.equalTo(label.superview!)
                make.top.equalTo(preView.snp.bottom).offset(5*LayoutHeightScale)
            })
            preView = label
        }

        
    }
    
    
    
    //MARK:- 创建提示label
    func createHintLabel(text:String) -> UILabel {
        let label = UILabel.init(text: text, font: UIFont.font(psFontSize: 36), textColor: UIColor.gray)
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    
    
}




