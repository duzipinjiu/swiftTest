//
//  UIColor-Extension.swift
//  XMTV
//
//  Created by Mac on 2017/1/3.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK:rgb颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 ,alpha:1.0)
    }
   //MARK:纯色（用于灰色）
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0 ,green: gray/255.0 ,blue: gray/255.0 ,alpha:1.0)
    }
    

    
    
    
    
}


// MARK: - 十六进制转换成颜色
extension UIColor {
    
    convenience init?(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }
    
    convenience init?(hexString: String, alpha: Float) {
        let set = CharacterSet.whitespacesAndNewlines
        var hex = hexString.trimmingCharacters(in: set).uppercased()
        
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        guard let hexVal = Int(hex, radix: 16) else {
            self.init()
            return nil
        }
        
        switch hex.characters.count {
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            self.init()
            return nil
        }
    }
    
    convenience init?(hexNumber: Int) {
        self.init(hexNumber: hexNumber, alpha: 1.0)
    }
    
    convenience init?(hexNumber: Int, alpha: Float) {
        guard (0x000000 ... 0xFFFFFF) ~= hexNumber else {
            self.init()
            return nil
        }
        self.init(hex6: hexNumber, alpha: alpha)
    }
    
    
    
    
    
}


// MARK: - 扩展十六进制转换成颜色
private extension UIColor {
    convenience init?(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
                  alpha: CGFloat(alpha))
    }
    
    convenience init?(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0,
                  alpha: CGFloat(alpha))
    }
}

// MARK: - 扩展十六进制转换成颜色
private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}
