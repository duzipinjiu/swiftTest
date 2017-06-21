//
//  Common.swift
//  QiuGuo
//
//  Created by cuirhong on 2017/2/27.
//  Copyright © 2017年 qiuyoukeji. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Kingfisher


typealias SucceedBlock = (_ result: JSON) -> ()
typealias FailureBlock = (_ error: Any?) -> ()

//http://api-test.qiu.com
let AppRootUrl:String = "http://api.qiu.com"

/**
 *  项目主题颜色
 */
let THEMECOLOR:UIColor = UIColor.init(hexString: "#2fce81")!

/**
 *  项目整体背景颜色
 */
let BGCOLOR:UIColor = UIColor.init(hexString: "#fafafa")!
/**
 *  项目默认字体颜色
 */
let DEFAUlTFONTCOLOR:UIColor = UIColor.init(hexString: "#000000")!
/**
 *  placeholder字体的颜色
 */
let PLACEHOLDERCOLOR:UIColor = UIColor.init(hexString: "#b7b8bc")!





/**
 *  项目默认字体大小
 */
let DEFAULTFONTSIZE:CGFloat = 17


/**
 *  布局宽的比例
 */
let LayoutWidthScale = UIScreen.main.bounds.size.width / 1080

/**
 *  布局高的比例
 */
let LayoutHeightScale = UIScreen.main.bounds.size.height / 1920
/**
 *  屏幕的宽
 */
let ScreenWidth = UIScreen.main.bounds.width
/**
 *  屏幕的高
 */
let ScreenHeight = UIScreen.main.bounds.height
/**
 *  状态栏的高
 */
let kStatusBarH: CGFloat = 20
/**
 *  导航栏的高
 */
let kNavigationBarH: CGFloat = 44
/**
 *  tabbar的高
 */
let kTabBarH: CGFloat = 49






/**
 *  用户登录信息持久化路径
 */
let KuserLoginPath = "userLoginInfo.archiver".docStr()

/**
 *  设置消息推送
 */
let KisPushMessage = "isPushMessage"
/**
 *  设置仅仅在wifi下下载图片
 */

let KonlyWIFILoadImage = "onlyWIFILoadImage"

/**
 *  微信登录state
 */
let weChatLoginState = "weChatLoginState"
/**
 *  微信appid
 */
let weChatAppId = "xxxxxxx"
/**
 *  微信Secret
 */
let weChatSecret = "xxxxxxx"

/**
 *  保存信息
 */
let userDefault = UserDefaults.standard

/**
 *  保存信息
 */
let dateFormaterString = "yyyy-MM-dd HH:mm:ss"












