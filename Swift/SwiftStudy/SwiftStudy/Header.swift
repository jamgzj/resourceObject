//
//  Header.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/1/16.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

private let base64EncodingTable = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
private let base64DecodingTable = [
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
]

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let WIDTH_RATE = SCREEN_WIDTH/375
let HEIGHT_RATE = SCREEN_HEIGHT/667

let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0
let IS_IOS9 = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
let IS_IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0

let MAIN_FONT = UIFont.systemFont(ofSize: 15*WIDTH_RATE)

let IP_ADDRESS_URL = ""

extension String {
    var md5 : String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
    var MD5 : String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02X", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
    
    var pinyin : String {
        let string = NSMutableString(string: self)
        CFStringTransform(string, nil, kCFStringTransformToLatin, false)
        
        let new = string.folding(options: NSString.CompareOptions.diacriticInsensitive, locale: Locale.current)
        
        return new
    }
    
    var firstCharacter : String {
        return (pinyin as NSString).substring(to: 1)
    }
    
    func isLegal(_ judgeString:String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@",judgeString)
        if predicate.evaluate(with: self) {
            return true
        }
        return false
    }
}

extension MBProgressHUD {
    class func showText(_ text:String?,toView view:UIView?) -> MBProgressHUD {
        var bgView : UIView
        
        if view == nil {
            bgView = UIApplication.shared.windows.last!
        }else {
            bgView = view!
        }
        
        let hud = MBProgressHUD.showAdded(to: bgView, animated: true)
        hud.bezelView.backgroundColor = .black
        hud.contentColor = .white
        hud.detailsLabel.text = text
        hud.detailsLabel.textColor = .white
        hud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15*WIDTH_RATE)
        hud.mode = .customView
        hud.removeFromSuperViewOnHide = true;
        
        hud.hide(animated: true, afterDelay: 2)
        
        return hud
    }
    
    class func showMessage(_ message:String?,toView view:UIView?) -> MBProgressHUD {
        var bgView : UIView
        if view == nil {
            bgView = UIApplication.shared.windows.last!
        }else {
            bgView = view!
        }
        let hud = MBProgressHUD.showAdded(to: bgView, animated: true)
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true
        hud.dimBackground = true
        return hud
    }
    
    class func showSuccess(_ message:String?) -> MBProgressHUD {
        let hud = showText(message, toView: nil)
        return hud
    }
    
    class func showError(_ message:String?) -> MBProgressHUD {
        let hud = showText(message, toView: nil)
        return hud
    }
    
    class func hideHudForView(_ view:UIView?) {
        var bgView = view
        guard (bgView != nil) else {
            bgView = UIApplication.shared.windows.last!
            return
        }
        hide(for: bgView!, animated: true)
    }
}











