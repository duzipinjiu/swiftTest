//
//  BaseViewModel.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/27.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit

//MARK:- 刷新类型
enum ViewModelRefreshType {
    case PullDownRefresh;//下拉刷新
    case UpDownRefresh;//上啦加载
}

//MARK:- 数据异常类型
enum DataAbnormalType {
    case noAbnormal;//无异常
    case noData;//无数据
    case noNetwork;//无网络
}


//MARK:- 基本viewModel
class BaseViewModel: NSObject {
    
    //MARK:- 刷新的类型
    lazy var refreshType:ViewModelRefreshType? = .PullDownRefresh
    
    //MARK:- 上啦加载的时候是否还有下一页
    lazy var isEnd:String?="0"
    
    //MARK:- 下拉刷新的时候是否还有上一页
    lazy var isHead:String?="0"
    
    //MARK:- 当前页
    lazy var page:Int=1
    
    //MARK:- 一页多少
    lazy var rows:Int=10
    
    //MARK:- 数据异常类型
    lazy var dataAbnormalType:DataAbnormalType = .noAbnormal
    
    
    
    //MARK:- 设置刷新基本数据
    func setupRefresh(isHead:String="",isEnd:String="", preArray:[Any],newArray:[Any]) -> [Any] {
      

        if self.refreshType == .PullDownRefresh{
            if isHead.isEmpty {
                if newArray.count <= self.rows {
                    //1:有 0:无 5:无效
                    self.isHead = "1"
                }else{
                    self.isHead = "0"
                }
            }
            self.isEnd = "5"
           return newArray
        }else{
            if isEnd.isEmpty{
                if newArray.count < self.rows {
                    self.isEnd = "0"
                }else{
                    self.isEnd = "1"
                }
            }
            self.isHead = "5"
            var array = preArray
            array.append(contentsOf: newArray)
            return array
            
        }
    }
    
    //MARK:-  拼接get请求的url
    func jointUrlString(_ urlString:String,paramters:[String:String])->String{
        let urlStr = AppRootUrl + urlString + "?" + query(paramters)
        return urlStr
    }
    
    /// Creates percent-escaped, URL encoded query string components
    /// from the given key-value pair using recursion.
    ///
    /// - parameter key:   The key of the query component.
    /// - parameter value: The value of the query component.
    ///
    /// - returns: The percent-escaped, URL encoded query string components.
    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that
    /// the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore,
    /// all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    ///
    /// - parameter string: The string to be percent-escaped.
    ///
    /// - returns: The percent-escaped string.
    private func escape(_ string: String) -> String {
        // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        let characters = "\(generalDelimitersToEncode)\(subDelimitersToEncode)"
        allowedCharacterSet.remove(charactersIn: characters)
        
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
    
     func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

}
