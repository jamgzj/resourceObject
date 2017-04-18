//
//  BaseViewController.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/4/11.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    fileprivate lazy var tableView : UITableView = { () -> UITableView in
        var tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.indicatorStyle = .white
        tableView.isScrollEnabled = true
        tableView.isUserInteractionEnabled = true
        JMTool.setExtraCellLineHidden(tableView)
        self.view.addSubview(tableView)
        return tableView
    }()
    
    fileprivate lazy var groupedTableView : UITableView = { () -> UITableView in
        var groupedTableView = UITableView(frame: CGRect.zero, style: .grouped)
        groupedTableView.dataSource = self
        groupedTableView.delegate = self
        groupedTableView.separatorStyle = .none
        groupedTableView.indicatorStyle = .white
        groupedTableView.isScrollEnabled = true
        groupedTableView.isUserInteractionEnabled = true
        JMTool.setExtraCellLineHidden(groupedTableView)
        self.view.addSubview(groupedTableView)
        return groupedTableView
    }()
    
    fileprivate lazy var scrollView : UIScrollView = { () -> UIScrollView in
        var scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.autoresizesSubviews = true
        scrollView.isUserInteractionEnabled = true
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    fileprivate lazy var jmNavigationView : JMNavView = { () -> JMNavView in
        var jmNavView = JMNavView(frame:CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: navHeight))
        return jmNavView
    }()
    
    // MARK: - 系统原生navigationbar封装
    
    fileprivate func getRightBarButtonItem(_ button:UIButton) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    fileprivate func getLeftBarButtonItem(_ button:UIButton) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    fileprivate func getLeftBarButtonItem(_ frame:CGRect = .zero, image:UIImage) {
        var buttonFrame = frame
        if buttonFrame == CGRect.zero {
            buttonFrame = CGRect(x: -5, y: 0, width: 10, height: 17)
        }
        let button = UIButton(frame: buttonFrame)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(ClickDefaultLeftBarBtn(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    fileprivate func getLeftBarButtonItem(_ frame:CGRect = .zero, title:String) {
        var buttonFrame = frame
        if buttonFrame == CGRect.zero {
            buttonFrame = CGRect(x: 0, y: 0, width: 40, height: 30)
        }
        let button = UIButton(frame: buttonFrame)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(ClickDefaultLeftBarBtn(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc fileprivate func ClickDefaultLeftBarBtn(_ button:UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

extension BaseViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "baseDefaultCell")
        return cell
    }
}

extension BaseViewController : UITableViewDelegate {
    
}

extension BaseViewController : UIScrollViewDelegate {
    
}













