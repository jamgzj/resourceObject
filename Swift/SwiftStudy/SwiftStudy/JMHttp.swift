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




class JMHttp: NSObject {
    
    
    class func isHttpRequestStatusOK(dict:JSON) -> Bool {
        let status = dict["status"].intValue
        
        return status == 200 ? true : false
    }
    
    class func get(path:String,params:[String:AnyObject]?,isHudShow:Bool,success:@escaping ((_ dict:JSON)->Void),failure:@escaping ((_ error:Error)->Void)) {
        request(path: path, method: "get", params: params, isHudShow: isHudShow, success: success, failure: failure)
    }
    
    class func post(path:String,params:[String:AnyObject]?,isHudShow:Bool,success:@escaping ((_ dict:JSON)->Void),failure:@escaping ((_ error:Error)->Void)) {
        request(path: path, method: "post", params: params, isHudShow: isHudShow, success: success, failure: failure)
    }
    
    class func request(path:String,method:String,params:[String:AnyObject]?,isHudShow:Bool,success:@escaping ((_ dict:JSON)->Void),failure:@escaping ((_ error:Error)->Void)) {
        if let url = URL(string: path) {
            if method == "get" {
                Alamofire.request(url, method: .get, parameters: params).responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        let dict = JSON(data)
                        success(dict)
                        break
                    case .failure(let error):
                        failure(error)
                        break
                    }
                }
            }
            else if method == "post" {
                Alamofire.request(url, method: .post, parameters: params).responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        let dict = JSON(data)
                        success(dict)
                        break
                    case .failure(let error):
                        failure(error)
                        break
                    }
                }
            }
        }
    }
}












