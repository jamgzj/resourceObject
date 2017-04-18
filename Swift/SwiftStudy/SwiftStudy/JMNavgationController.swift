//
//  JMNavgationController.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/4/18.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit

class JMNavgationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 设置标题的垂直方向上的偏移量
    func setTitleVerticalOffset(_ offset:CGFloat) {
        navigationBar.setTitleVerticalPositionAdjustment(offset, for: .default)
    }
    
    // 设置nav背景色
    func setNavigationBarColor(_ color:UIColor) {
        navigationBar.barTintColor = color
    }
    
    // 设置标题颜色
    func setTitleColor(_ color:UIColor) {
        let textAttrs = [NSForegroundColorAttributeName:color]
        navigationBar.titleTextAttributes = textAttrs
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
