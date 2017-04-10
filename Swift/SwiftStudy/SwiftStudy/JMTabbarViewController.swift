//
//  JMTabbarViewController.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/1/16.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class JMTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let array = ["1","2","3"]
        JMHttp.get("", params: nil, isHudShow: true, success: { (json) in
            
        }) { (error) in
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
