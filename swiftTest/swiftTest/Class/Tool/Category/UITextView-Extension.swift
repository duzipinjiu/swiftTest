//
//  UITextView-Extension.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/28.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit
var kPlaceholderLabelPointer:UInt8=0
// MARK: - 扩展textView的placeholder属性
extension UITextView {
    
    
    convenience init(text:String,fontSize:CGFloat,textColor:UIColor) {
        self .init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        
        
    }
    
    
    
    
    
    
    
    var placeHolderTextView:UITextView? {
        
        get{
            
            return objc_getAssociatedObject(self,&kPlaceholderLabelPointer)as?UITextView
            
        }
        
        set{
            
            objc_setAssociatedObject(self, &kPlaceholderLabelPointer, newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    func setPlaceHolder(placeHolderStr:String) {
    
    if placeHolderTextView==nil{
    
    placeHolderTextView=UITextView(frame:self.bounds)
    
    placeHolderTextView?.isUserInteractionEnabled=false
    
    placeHolderTextView?.text = placeHolderStr
    
    placeHolderTextView?.textColor=UIColor.gray
    
    self.insertSubview(placeHolderTextView!, at:0)
    
    }
    
    }
    
    open override func willMove(toSuperview newSuperview:UIView?) {
    
    NotificationCenter.default.addObserver(self,
    
    selector:Selector(("didChange:")),
    
    name:NSNotification.Name.UITextViewTextDidChange,
    
    object:nil)
    
    }
    
    func didChange (notification:NSNotification) {
        guard placeHolderTextView != nil else {
            return
        }
    
    
    if ((notification.object as? UITextView) != nil){
    
    if text.lengthOfBytes(using: String.Encoding.utf8) > 0 {
    
    self.placeHolderTextView!.isHidden=true
    
    }else{
    
    placeHolderTextView!.isHidden=false
    
    }
    
    }
    
    }
 
    
}
    
    
    

