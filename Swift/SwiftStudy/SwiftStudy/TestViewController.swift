//
//  TestViewController.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/3/31.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class TestViewController: UIViewController, NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        startAnimating(message:"Loading...",type:NVActivityIndicatorType.ballGridPulse)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) { 
            self.stopAnimating()
        }
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