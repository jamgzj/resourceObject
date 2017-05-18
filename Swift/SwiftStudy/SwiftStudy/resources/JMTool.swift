//
//  JMTool.swift
//  SwiftStudy
//
//  Created by zhengxingxia on 2017/1/10.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

import UIKit

let USER_INFO_KEY = "USER_INFO_KEY"

class JMTool: NSObject {
        
    class func isLogin() -> Bool {
        let userInfoDict:Any? = UserDefaults.standard.object(forKey: USER_INFO_KEY)
        return userInfoDict == nil ? false:true
    }
    
    class func getCurrentVC() -> UIViewController {
        var result:UIViewController
        
        var window = UIApplication.shared.keyWindow
        
        if window!.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindowLevelNormal {
                    window = tmpWin
                    break
                }
            }
        }
        
        let frontView = window!.subviews[0]
        let nextResponder = frontView.next
        if nextResponder!.isKind(of: UIViewController.self) {
            result = nextResponder as! UIViewController
        }else {
            result = window!.rootViewController!
        }
        return result
    }
    
    class func setExtraCellLineHidden(_ tableView:UITableView) -> Void {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        tableView.tableFooterView = view
    }
    
    // 设置label首行缩进
    class func resetContentForLabel(_ label:UILabel,withWidth width:CGFloat) -> UILabel? {
        if label.text != nil {
            let attributedString = NSMutableAttributedString.init(string: label.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            paragraphStyle.firstLineHeadIndent = width+5
            attributedString.addAttributes([NSParagraphStyleAttributeName:paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            let label = UILabel()
            label.attributedText = attributedString
            label.sizeToFit()
            return label
        }
        return nil
    }
    
    //MARK: - NSUserdefault 偏好设置
    class func setObject(_ object:Any?,forKey key:String) -> Void {
        UserDefaults.standard.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getObjectforKey(_ key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func removeAllNSUserdefaultObject() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    //MARK: - NSKeyedArchiver 归档
    class func archiveObject(_ object:Any?,forKey key:String) {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let path = docPath?.appendingFormat("%@.archiver", key.description)
        if let path = path, let object = object {
            NSKeyedArchiver.archiveRootObject(object, toFile: path)
        }
    }
    
    class func archiveObjectForKey(_ key:String) -> Any? {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let path = docPath?.appendingFormat("%@.archiver", key.description)
        if let path = path {
            return NSKeyedUnarchiver.unarchiveObject(withFile: path)
        }
        return nil
    }
    
    //MARK: - 清理url cookies
    class func clearCookiesForUrl(_ url:URL) -> Void {
        let cookies = HTTPCookieStorage.shared.cookies(for: url)
        for cookie in cookies! {
            print("cookie------>\(cookie)")
            print("cookieArray  before------>\(cookies)")
            HTTPCookieStorage.shared.deleteCookie(cookie)
            print("cookieArray  later ------>\(cookies)")
        }
    }
    
    class func clearCookieWithName(_ name:String,forUrl url:URL?) -> Void {
        if url != nil {
            let cookieArray = HTTPCookieStorage.shared.cookies(for: url!)
            if cookieArray != nil {
                for cookie in cookieArray! {
                    if cookie.name == name {
                        HTTPCookieStorage.shared.deleteCookie(cookie)
                    }
                }
            }
        }
    }
    
    class func removeCacheForUrl(_ url:URL?) -> Void {
        if let url = url {
            URLCache.shared.removeCachedResponse(for: URLRequest.init(url: url))
        }
    }
    
    class func removeAllCachedResponses() -> Void {
        URLCache.shared.removeAllCachedResponses()
    }
    
    class func transformToJsonWithObject(_ object:AnyObject) -> String? {
        let canTransform = JSONSerialization.isValidJSONObject(object)
        let jsonDataString:String
        if canTransform {
            print("可以转换")
            /* JSON data for obj, or nil if an internal error occurs. The resulting data is a encoded in UTF-8.
             */
            let  jsonData = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            /*
             Writes the bytes in the receiver to the file specified by a given path.
             YES if the operation succeeds, otherwise NO
             */
            // 将JSON数据写成文件
            // 文件添加后缀名: 告诉别人当前文件的类型.
            // 注意: AFN是通过文件类型来确定数据类型的!如果不添加类型,有可能识别不了! 自己最好添加文件类型.
            try? jsonData?.write(to: URL.init(string: "/Users/\(object.description).json")!)
            
            jsonDataString = String.init(data: jsonData!, encoding: .utf8)!
            
            print(jsonDataString)
            
            return jsonDataString
        }else {
            print("JSON数据生成失败，请检查数据格式")
        }
        return nil
    }

    
}

class JMNavView: UIView {
    
    fileprivate var JMTitle = ""
    open var jmLeftButton : UIButton?
    open var jmRightButton : UIButton?
    
    open var titleLabel : UILabel = {
        let label = UILabel()
        label.font = MAIN_BOLD_FONT(15*WIDTH_RATE)
        label.textAlignment = .center
        label.textColor = MAIN_FONT_COLOR
        return label
    }()
    
    open var title :String {
        get {
            return getJMTitle()
        }
        set {
            setJMTitle(newValue)
        }
    }
    
    enum JMNavButtonType {
        case left
        case right
    }
    
    init() {
        super.init(frame: CGRect.zero)
        addSubview(titleLabel)
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    fileprivate func getJMTitle() -> String {
        return JMTitle
    }
    
    fileprivate func setJMTitle(_ newTitle:String) {
        JMTitle = newTitle
        for i in 0 ..< (newTitle as NSString).length {
            if i != (newTitle as NSString).length-1 {
                let start = JMTitle.index(JMTitle.startIndex, offsetBy: 2*i+1)
                let end = JMTitle.index(JMTitle.startIndex, offsetBy: 2*i+1)
                let myRange = start..<end
                JMTitle = JMTitle.replacingCharacters(in: myRange, with: " ")
            }
        }
        titleLabel.text = JMTitle
    }
    
    open func addButton(_ image:UIImage, target:AnyObject?, type:JMNavButtonType = .left) -> UIButton {
        let imageSize = image.size
        let buttonHeight = navHeight - 20
        var imageHeight = 17*WIDTH_RATE
        var imageWidth = imageHeight * imageSize.width / imageSize.height
        let button = UIButton()
        button.setImage(image, for: .normal)
        if imageWidth > buttonHeight {
            imageWidth = buttonHeight;
            imageHeight = imageWidth * imageSize.height / imageSize.width;
        }
        button.imageEdgeInsets = UIEdgeInsets.init(top: (buttonHeight-imageHeight)/2, left: (buttonHeight-imageWidth)/2, bottom: (buttonHeight-imageHeight)/2, right: (buttonHeight-imageWidth)/2)
        addSubview(button)
        switch type {
        case .left:
            button.frame = CGRect.init(x: 5*WIDTH_RATE, y: 20, width: buttonHeight, height: buttonHeight)
            jmLeftButton = button
            break
        case .right:
            button.frame = CGRect.init(x: SCREEN_WIDTH-5*WIDTH_RATE-buttonHeight, y: 20, width: buttonHeight, height: buttonHeight)
            jmRightButton = button
            break
        }
        return button
    }
    
    open func addButton(_ title:String, target:AnyObject?, type:JMNavButtonType = .left) -> UIButton {
        let width = (title as NSString).width(for: MAIN_FONT(15*WIDTH_RATE))
        let buttonHeight = navHeight-20
        let buttonWidth = width > buttonHeight ? width : buttonHeight
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13*WIDTH_RATE)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(target, action: NSSelectorFromString("ClickJmRightBarBtn"), for: .touchUpInside)
        addSubview(button)
        switch type {
        case .left:
            button.frame = CGRect.init(x: 5*WIDTH_RATE, y: 20, width: buttonWidth, height: buttonHeight)
            jmLeftButton = button
            break
        case .right:
            button.frame = CGRect.init(x: SCREEN_WIDTH-5*WIDTH_RATE-buttonWidth, y: 20, width: buttonWidth, height: buttonHeight)
            jmRightButton = button
            break
        }
        return button
    }
    
    open func addButton(_ image:UIImage, originX:CGFloat) -> UIButton {
        let imageSize = image.size
        let buttonHeight = navHeight - 20
        var imageHeight = 17 * WIDTH_RATE
        var imageWidth = imageHeight * imageSize.width / imageSize.height
        let button = UIButton()
        button.frame = CGRect.init(x: originX, y: 20, width: buttonHeight, height: buttonHeight)
        button.setImage(image, for: .normal)
        if imageWidth > buttonHeight {
            imageWidth = buttonHeight;
            imageHeight = imageWidth * imageSize.height / imageSize.width;
        }
        button.imageEdgeInsets = UIEdgeInsetsMake((buttonHeight-imageHeight)/2, (buttonHeight-imageWidth)/2, (buttonHeight-imageHeight)/2, (buttonHeight-imageWidth)/2);
        addSubview(button)
        return button
    }
}






























