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















