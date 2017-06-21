//
//  UILable-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/28.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

extension UILabel
{
    convenience init(text: String?,font: UIFont?, textColor: UIColor?,textAlignment:NSTextAlignment?=nil ) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = textColor
        
        if let alignment = textAlignment {
             self.textAlignment = alignment
        }
       

    }
    
    
    //MARK:- 设置不同的文本
    func setDiffirentText(needText:String,fontSize:CGFloat,fontColor:UIColor?){
        let string = self.text ?? ""
        let attributedString = NSMutableAttributedString.init(string: string)
        if let range = (string as? NSString)?.range(of: needText){
         attributedString.addAttribute(NSFontAttributeName, value: UIFont.font(psFontSize: fontSize), range: range)
            if let color = fontColor{
            attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
            }
            self.attributedText = attributedString
        }
    }
    
    
    /**
     计算label的宽度和高度
     
     :param: text       label的text的值
     :param: attributes label设置的字体
     
     :returns: 返回计算后label的CGRece
     */
    func labelSize(text:String,size:CGSize?=nil, font:UIFont?) -> CGRect{
        var rect = CGRect();
         var newSize:CGSize = CGSize.init(width: 100000, height: 100000)
        if size != nil {
           newSize = size!
        }
        
 
    
        let attributes = [NSFontAttributeName: font]//计算label的字体
        rect = text.boundingRect(with: newSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes , context: nil);
        return rect
    }
    
    
    
    //MARK:- 创建下划线
    class func unline(hexString:String?="#cccccc")->UILabel{
        let label = UILabel()
        label.backgroundColor = UIColor.init(hexString: hexString!)
        return label
    }
    
    
    
    
    
    
}
