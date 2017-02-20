//
//  BaseViewController.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "JMTool.h"
//#import <UMSocialCore/UMSocialCore.h>
//#import <UMMobClick/MobClick.h>

typedef void(^HttpSuccessBlock)(id JSON);
typedef void(^HttpFailureBlock)(id Error);

@interface BaseViewController : UIViewController<UINavigationControllerDelegate ,UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UITableView *groupedTableView;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)JMNavView *jmNavigationView;
@property (strong,nonatomic)UIView *jmCover;

///**
// *  `AFHTTPSessionManager` is a subclass of `AFURLSessionManager` with convenience methods for making HTTP requests. When a `baseURL` is provided, requests made with the `GET` / `POST` / et al. convenience methods can be made with relative paths.
// ## Subclassing Notes
// Developers targeting iOS 7 or Mac OS X 10.9 or later that deal extensively with a web service are encouraged to subclass `AFHTTPSessionManager`, providing a class method that returns a shared singleton object on which authentication and other configuration can be shared across the application.
// For developers targeting iOS 6 or Mac OS X 10.8 or earlier, `AFHTTPRequestOperationManager` may be used to similar effect.
// ## Methods to Override
// To change the behavior of all data task operation construction, which is also used in the `GET` / `POST` / et al. convenience methods, override `dataTaskWithRequest:completionHandler:`.
// ## Serialization
// Requests created by an HTTP client will contain default headers and encode parameters according to the `requestSerializer` property, which is an object conforming to `<AFURLRequestSerialization>`.
// Responses received from the server are automatically validated and serialized by the `responseSerializers` property, which is an object conforming to `<AFURLResponseSerialization>`
// ## URL Construction Using Relative Paths
// For HTTP convenience methods, the request serializer constructs URLs from the path relative to the `-baseURL`, using `NSURL +URLWithString:relativeToURL:`, when provided. If `baseURL` is `nil`, `path` needs to resolve to a valid `NSURL` object using `NSURL +URLWithString:`.
// Below are a few examples of how `baseURL` and relative paths interact:
// NSURL *baseURL = [NSURL URLWithString:"http://example.com/v1/"]; [NSURL URLWithString:"foo" relativeToURL:baseURL]; // http://example.com/v1/foo [NSURL URLWithString:"foo?bar=baz" relativeToURL:baseURL]; // http://example.com/v1/foo?bar=baz [NSURL URLWithString:"/foo" relativeToURL:baseURL]; // http://example.com/foo [NSURL URLWithString:"foo/" relativeToURL:baseURL]; // http://example.com/v1/foo [NSURL URLWithString:"/foo/" relativeToURL:baseURL]; // http://example.com/foo/ [NSURL URLWithString:"http://example2.com/" relativeToURL:baseURL]; // http://example2.com/
// Also important to note is that a trailing slash will be added to any `baseURL` without one. This would otherwise cause unexpected behavior when constructing URLs using paths without a leading slash.
// Warning: Managers for background sessions must be owned for the duration of their use. This can be accomplished by creating an application-wide or shared singleton instance.
// */
//@property (strong,nonatomic)AFHTTPSessionManager *manager;
//
///**
// *  强制跳转登录界面
// */
//- (void)forceToPushLoginVC;

//#pragma mark - 网络请求
//
///**
// *  get请求
// *
// *  @param path    url
// *  @param params  参数
// *  @param success <#success description#>
// *  @param failure <#failure description#>
// */
//- (void)getWithThePath:(NSString *)path Params:(NSDictionary *)params Success:(HttpSuccessBlock)success Failure:(HttpFailureBlock)failure;
//
///**
// *  post请求
// *
// *  @param path    url
// *  @param params  参数
// *  @param success <#success description#>
// *  @param failure <#failure description#>
// */
//- (void)postWithThePath:(NSString *)path Params:(NSDictionary *)params Success:(HttpSuccessBlock)success Failure:(HttpFailureBlock)failure;
//
///**
// *  网络请求数据(GET/POST)
// *
// *  @param path    url
// *  @param params  参数
// *  @param method  方法
// *  @param success success description
// *  @param failure failure description
// */
//- (void)requestWithThePath:(NSString *)path
//                    Params:(NSDictionary *)params
//                    Method:(NSString *)method
//                   Success:(HttpSuccessBlock)success
//                   Failure:(HttpFailureBlock)failure;
//
///**
// *  上传图片
// *
// *  @param path    urlString
// *  @param data    图片data
// *  @param kName   图片对应的key值
// *  @param params  参数
// *  @param success success description
// *  @param failure failure description
// */
//- (void)requestWithThePath:(NSString *)path
//                      Data:(NSData *)data
//                   KeyName:(NSString *)kName
//                    Params:(NSDictionary *)params
//                   Success:(HttpSuccessBlock)success
//                   Failure:(HttpFailureBlock)failure;
//
///**
// *  上传多张图片
// *
// *  @param path       urlString
// *  @param imgArray   图片数组(数组存放的可以是NSData,NSString,UIImage三种类型之一)
// *  @param kNameArray 对应上传图片的key值(字符串数组)
// *  @param params     参数列表
// *  @param success    success description
// *  @param failure    failure description
// */
//- (void)requestWithThePath:(NSString *)path
//                  imgArray:(NSArray *)imgArray
//              KeyNameArray:(NSArray *)kNameArray
//                    Params:(NSDictionary *)params
//                   Success:(HttpSuccessBlock)success
//                   Failure:(HttpFailureBlock)failure;

/**
 *  创建navigationbar上的右按钮
 *
 *  @param button <#button description#>
 */
- (void)getRightBarButtonItemWithButton:(UIButton *)button;

/**
 *  创建navigationbar上的左按钮
 *
 *  @param button <#button description#>
 */
- (void)getLeftBarButtonItemWithButton:(UIButton *)button;

/**
 *  快速创建一个自定义返回按钮（纯图片）,并设置当前控制器的tabbar隐藏
 *
 *  @param imgNormal      按钮图片
 *  @param imgSelected    选中图片
 *  @param frame          按钮frame
 */
- (void)getLeftBarButtonItemWithImageNormal:(UIImage *)imgNormal
                              ImageSelected:(UIImage *)imgSelected
                                      Frame:(CGRect)frame;

/**
 *  快速创建一个自定义返回按钮（纯文字）,并设置当前控制器的tabbar隐藏
 *
 *  @param title          标题
 *  @param frame          按钮frame
 */
- (void)getLeftBarButtonItemWithTitle:(NSString *)title
                                Frame:(CGRect)frame;

/**
 *  自定义navView左侧按钮点击事件
 *
 *  @param sender <#sender description#>
 */
- (void)ClickJmLeftBarBtn:(id)sender;

/**
 *  自定义navView右侧按钮点击事件
 *
 *  @param sender <#sender description#>
 */
- (void)ClickJmRightBarBtn:(id)sender;

/**
 *  重设self.view的frame(当frame不在nav下方时使用,不是很好用)
 */
- (void)resetViewFrame;

//#pragma mark - 分享
//
///**
// *  网页分享
// *
// *  @param platformType 平台类型
// *  @param type         0 邀请好友 1下载
// *  @param isActivity   有无积分获取
// */
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithType:(int)type WithActivity:(BOOL)isActivity;







@end















