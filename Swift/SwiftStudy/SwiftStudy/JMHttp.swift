//
//  JMHttp.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/3/30.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

final class JMHttp: NSObject {
    
    open static let sharedManager : SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let manager = Alamofire.SessionManager(configuration: configuration)
        return manager
    }()
    
    class func isHttpRequestStatusOK(dict:JSON) -> Bool {
        let status = dict["status"].intValue
        
        return status == 200 ? true : false
    }
    
    class func checkNetStatus() {
        let reachabilityManager = NetworkReachabilityManager.init(host: "www.baidu.com")
        reachabilityManager!.listener = { status in
            switch status {
            case .notReachable:
                print("网络未连接")
            case .unknown:
                print("未知网络")
            case .reachable(.ethernetOrWiFi):
                print("wifi")
            case .reachable(.wwan):
                print("3G")
            }
        }
        reachabilityManager!.startListening()
    }
    
    final class func get(_ path:String, params:AnyObject?, isHudShow:Bool, success:@escaping ((_ dict:JSON)->Void), failure:@escaping ((_ error:Error)->Void)) {
        request(path, method: "get", params: params, isHudShow: isHudShow, success: success, failure: failure)
    }
    
    final class func post(_ path:String, params:AnyObject?, isHudShow:Bool, success:@escaping ((_ dict:JSON)->Void),failure:@escaping ((_ error:Error)->Void)) {
        request(path, method: "post", params: params, isHudShow: isHudShow, success: success, failure: failure)
    }
    
    class func request(_ path:String, method:String, params:AnyObject?, isHudShow:Bool, success:@escaping ((_ dict:JSON)->Void), failure:@escaping ((_ error:Error)->Void)) {
        
        let urlString = path.isLegal("^http://.*") ? path : (IP_ADDRESS_URL + path)
        let bgView = UIApplication.shared.windows.last
        
        if let url = URL(string: urlString) {
            if isHudShow {
                DispatchQueue.main.async {
                    let hud = MBProgressHUD.showMessage("loading...",toView:bgView)
                    hud.hide(animated: true, afterDelay: URLSessionConfiguration.default.timeoutIntervalForRequest)
                }
            }
            if method == "get" {
                sharedManager.request(url, method: .get, parameters: params as? [String : AnyObject]).responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        let dict = JSON(data)
                        if let bgView = bgView {
                            MBProgressHUD.hideHudForView(bgView)
                        }
                        success(dict)
                        break
                    case .failure(let error):
                        if let bgView = bgView {
                            MBProgressHUD.hideHudForView(bgView)
                        }
                        failure(error)
                        break
                    }
                }
            }
            else if method == "post" {
                sharedManager.request(url, method: .post, parameters: params as? [String : AnyObject]).responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        let dict = JSON(data)
                        if let bgView = bgView {
                            MBProgressHUD.hideHudForView(bgView)
                        }
                        success(dict)
                        break
                    case .failure(let error):
                        if let bgView = bgView {
                            MBProgressHUD.hideHudForView(bgView)
                        }
                        failure(error)
                        break
                    }
                }
            }
        }
    }
    
    // 上传单张图片
    class func request(_ path:String, data:Data, keyName:String, params:AnyObject?, isHudShow:Bool, success:@escaping ((_ dict:JSON)->Void), failure:@escaping ((_ error:Error)->Void)) {
        let urlString = path.isLegal("^http://.*") ? path : (IP_ADDRESS_URL + path)
        let bgView = UIApplication.shared.windows.last
        
        if let url = URL(string: urlString) {
            if isHudShow {
                DispatchQueue.main.async {
                    let hud = MBProgressHUD.showMessage("loading...",toView:bgView)
                    hud.hide(animated: true, afterDelay: URLSessionConfiguration.default.timeoutIntervalForRequest)
                }
            }
            sharedManager.upload(multipartFormData: { (formData) in
                formData.append(data, withName: keyName, fileName: String(describing: NSDate()) + ".png", mimeType: "image/jpeg")
            }, to: url, method: .post, headers: params as? [String : String], encodingCompletion: { (result) in
                switch result {
                case .success(let data):
                    let dict = JSON(data)
                    if let bgView = bgView {
                        MBProgressHUD.hideHudForView(bgView)
                    }
                    success(dict)
                    break
                case .failure(let error):
                    if let bgView = bgView {
                        MBProgressHUD.hideHudForView(bgView)
                    }
                    failure(error)
                    break
                }
            })
        }
    }
    
    // 上传多张图片
    class func request<T>(_ path:String, imgArray:[T], keyNames:[String], params:AnyObject?, isHudShow:Bool, success:@escaping ((_ dict:JSON)->Void), failure:@escaping ((_ error:Error)->Void)) {
        let urlString = path.isLegal("^http://.*") ? path : (IP_ADDRESS_URL + path)
        let bgView = UIApplication.shared.windows.last
        
        if let url = URL(string: urlString) {
            if isHudShow {
                DispatchQueue.main.async {
                    let hud = MBProgressHUD.showMessage("loading...",toView:bgView)
                    hud.hide(animated: true, afterDelay: URLSessionConfiguration.default.timeoutIntervalForRequest)
                }
            }
            sharedManager.upload(multipartFormData: { (formData) in
                let count = imgArray.count<keyNames.count ? imgArray.count : keyNames.count
                for index in 0...count {
                    let object = imgArray[index]
                    if object is String {
                        let image = UIImage.init(named: object as! String)
                        let data = UIImageJPEGRepresentation(image!, 1)
                        formData.append(data!, withName: keyNames[index], fileName: String(describing: NSDate()) + ".png", mimeType: "image/jpeg")
                    }
                    if object is UIImage {
                        let data = UIImageJPEGRepresentation(object as! UIImage, 1)
                        formData.append(data!, withName: keyNames[index], fileName: String(describing: NSDate()) + ".png", mimeType: "image/jpeg")
                    }
                    if object is Data {
                        formData.append(object as! Data, withName: keyNames[index], fileName: String(describing: NSDate()) + ".png", mimeType: "image/jpeg")
                    }
                }
            }, to: url, method: .post, headers: params as? [String:String], encodingCompletion: { (result) in
                switch result {
                case .success(let data):
                    let dict = JSON(data)
                    if let bgView = bgView {
                        MBProgressHUD.hideHudForView(bgView)
                    }
                    success(dict)
                    break
                case .failure(let error):
                    if let bgView = bgView {
                        MBProgressHUD.hideHudForView(bgView)
                    }
                    failure(error)
                    break
                }
            })
        }
    }
}












