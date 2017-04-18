//
//  JMTabbarViewController.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/1/16.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit

class JMTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // 设置tabbar高度
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if SCREEN_HEIGHT > 568 {
            var tabFrame = tabBar.frame
            tabFrame.size.height = 60
            tabFrame.origin.y = view.frame.size.height - 60;
            tabBar.frame = tabFrame
        }else {
            var tabFrame = tabBar.frame
            tabFrame.size.height = 50
            tabFrame.origin.y = view.frame.size.height - 50;
            tabBar.frame = tabFrame
        }
    }
    
    // 设置选中背景图片
    func setSelectedBackgroundImage(_ image:UIImage) {
        tabBar.selectionIndicatorImage = image
    }
    
    // 设置背景图片
    func setJMBackgroundImage(_ image:UIImage) {
        let backImgView = UIImageView(frame: tabBar.bounds)
        backImgView.image = image
        tabBar.insertSubview(backImgView, at: 0)
    }
    
    // 设置背景颜色
    func setJMBackgroundColor(_ color:UIColor) {
        let bgView = UIView(frame: tabBar.bounds)
        bgView.backgroundColor = color
        tabBar.insertSubview(bgView, at: 0)
    }
    
    // 删除tabbar的分割线
    func deleteTopLine() {
        UITabBar.appearance().shadowImage = UIImage()
    }
    
    // 添加子控制器
    func addChildViewController(_ childVC:UIViewController, title:String, imageName:String, selectImgName:String) {
        // 设置标题
        childVC.title = title
        
        // 设置图标
        var image = UIImage(named: imageName)
        // 声明这张图片用原图(别渲染)
        image = image?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.image = image
        
        var selectedImage = UIImage(named: selectImgName)
        selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage
        
        // 设置tabBarItem的普通文字颜色
        let attrDict = [NSForegroundColorAttributeName:MAIN_FONT_COLOR,NSFontAttributeName:UIFont.systemFont(ofSize: 15)]
        childVC.tabBarItem.setTitleTextAttributes(attrDict, for: .normal)
        
        // 设置tabBarItem的选中文字颜色
        let selectedDict = [NSForegroundColorAttributeName:MAIN_COLOR]
        childVC.tabBarItem.setTitleTextAttributes(selectedDict, for: .selected)
        
        let navVC = JMNavgationController(rootViewController: childVC)
        addChildViewController(navVC)
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
