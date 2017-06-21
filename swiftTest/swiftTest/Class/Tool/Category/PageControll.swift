//
//  PageControll.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/3/13.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit


private var dot_Width:CGFloat = 4.5

private var dot_height:CGFloat = 10

private var magrin_lenth:CGFloat = 5


class  PageControl:UIPageControl{
    
    init(dotWidth:CGFloat,dotHeight:CGFloat,margin:CGFloat) {
      super.init(frame:CGRect.zero)
       dot_Width = dotWidth
       dot_height = dotHeight
       magrin_lenth = margin
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



    //重新布局小圆点之间的距离
    open override func layoutSubviews() {
        super.layoutSubviews()
        //计算圆点间距
        let marginX = dot_Width + magrin_lenth
        
        var count:CGFloat = CGFloat(self.subviews.count)
        for view in self.subviews {
            let x = self.bounds.width - ((count - 1) * marginX + dot_Width)
            view.frame = CGRect(x:x, y: view.frame.origin.y, width: dot_Width, height: dot_height)
            count -= 1
        }   
    }








}









