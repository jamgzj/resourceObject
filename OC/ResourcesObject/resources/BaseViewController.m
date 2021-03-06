//
//  BaseViewController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "BaseViewController.h"
//#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusDidChange) name:NetworkStatusDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:NetworkStatusDidChangeNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@--%@",NSStringFromClass(self.class),_jmTitle?:_jmNavigationView.title]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@--%@",NSStringFromClass(self.class),_jmTitle?:_jmNavigationView.title]];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIView *)jmCover {
    if (!_jmCover) {
        _jmCover = [[UIView alloc]initWithFrame:self.view.bounds];
        _jmCover.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        _jmCover.hidden = YES;
        [self.view addSubview:_jmCover];
    }
    return _jmCover;
}

- (JMNavView *)jmNavigationView {
    if (!_jmNavigationView) {
        _jmNavigationView = [[JMNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight)];
        _jmNavigationView.backgroundColor = [UIColor whiteColor];
        _jmNavigationView.titleLabel.textColor = MainFontColor;
        _jmNavigationView.titleLabel.font = [UIFont systemFontOfSize:17*coefficient];
        [self.view addSubview:_jmNavigationView];
    }
    return _jmNavigationView;
}

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _tableView.scrollEnabled = YES;
        _tableView.userInteractionEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [JMTool setExtraCellLineHidden:_tableView];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableView *)groupedTableView {
    if(!_groupedTableView)
    {
        _groupedTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_groupedTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_groupedTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
        _groupedTableView.scrollEnabled = YES;
        _groupedTableView.userInteractionEnabled = YES;
        _groupedTableView.delegate = self;
        _groupedTableView.dataSource = self;
        [JMTool setExtraCellLineHidden:_groupedTableView];
        [self.view addSubview:_groupedTableView];
    }
    return _groupedTableView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizesSubviews = NO;
        _scrollView.userInteractionEnabled = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)creatStatusBackgroudView {
    UIView *statusBackgroundV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, statusbarHeight())];
    statusBackgroundV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusBackgroundV];
    return statusBackgroundV;
}

- (void)networkStatusDidChange {
    
}

#pragma mark - 创建navigationbar上的按钮

- (void)getRightBarButtonItemWithButton:(UIButton *)button {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)getLeftBarButtonItemWithButton:(UIButton *)button {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)getLeftBarButtonItemWithImageNormal:(UIImage *)imgNormal
                              ImageSelected:(UIImage *)imgSelected
                                      Frame:(CGRect)frame {
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(-5, 0, 10, 17);
    }
    
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:imgNormal forState:UIControlStateNormal];
    [button setImage:imgSelected forState:UIControlStateSelected];
    [button addTarget:self action:@selector(ClickDefaultLeftBarBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)getLeftBarButtonItemWithTitle:(NSString *)title
                                Frame:(CGRect)frame {
    
    if (CGRectEqualToRect(frame, CGRectZero)) {
        frame = CGRectMake(0, 0, 40, 30);
    }
    
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(ClickDefaultLeftBarBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)ClickJmLeftBarBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ClickJmRightBarBtn:(id)sender {
    
}

- (void)ClickDefaultLeftBarBtn {
    NSArray *vcArray = self.navigationController.viewControllers;
    
    if ([vcArray indexOfObject:self] == 1) {
        self.tabBarController.tabBar.hidden = NO;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resetViewFrame {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

//#pragma mark - 分享
//
////网页分享
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithType:(int)type WithActivity:(BOOL)isActivity
//{
//    
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    
//    //    NSString* thumbURL = _type == InviteFriendViewControllerTypeInvite?[NSString stringWithFormat:@"%@?userId=%@",IP_ADRESS_URL(CODE_IMAGE_URL),[UserInfo getUserInfo].userId]:APP_DOWNLOAD_URL;
//    UIImage *shareImg = [UIImage imageNamed:@"downLoad_share.png"];
//    //创建网页内容对象
//    UMShareWebpageObject *shareObject = type == 0?
//    [UMShareWebpageObject shareObjectWithTitle:@"来偷时，偷小时换咖啡" descr:@"来偷时，一起体验“偷一把”的快感，偷得小时换商品，秒优惠！" thumImage:shareImg]
//    :
//    [UMShareWebpageObject shareObjectWithTitle:@"来偷时，享一杯好咖啡" descr:@"来偷时，在浓郁的咖啡文化里，随时随地点一杯、学一杯或看大咖秀一杯" thumImage:shareImg];
//    
//    //    if (!thumbURL) {
//    //        shareObject.thumbImage = [UIImage imageNamed:@"main_tou"];
//    //    }
////    //设置网页地址
////    shareObject.webpageUrl = type == 0?[NSString stringWithFormat:@"%@?userId=%@",IP_ADRESS_URL(SHARE_INVITE_URL),[UserInfo getUserInfo].userId]:APP_DOWNLOAD_URL;
//    
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//    if (type==0) {
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo getUserInfo].userId,@"userId", nil];
//        [self postWithThePath:SHARE_INVITE_URL Params:params Success:^(id JSON) {
//            if ([JMTool isHttpRequestStatusOK:JSON]) {
//                shareObject.webpageUrl = JSON[@"rows"];
//                [self shareToPlatform:platformType messageObject:messageObject WithType:type IsActivity:isActivity];
//            }else {
//                [MBProgressHUD showError:JSON[@"msg"]];
//            }
//        } Failure:^(id Error) {
//            
//        }];
//    }else {
//        shareObject.webpageUrl = APP_DOWNLOAD_URL;
//        [self shareToPlatform:platformType messageObject:messageObject WithType:type IsActivity:isActivity];
//    }
//    
//}
//
//- (void)shareToPlatform:(UMSocialPlatformType)platformType messageObject:(UMSocialMessageObject *)messageObject WithType:(int)type IsActivity:(BOOL)isActivity {
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        //        if (error) {
//        //            UMSocialLogInfo(@"************Share fail with error %@*********",error);
//        //        }else{
//        //            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//        //                UMSocialShareResponse *resp = data;
//        //                //分享结果消息
//        //                UMSocialLogInfo(@"response message is %@",resp.message);
//        //                //第三方原始返回的数据
//        //                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
//        //
//        //            }else{
//        //                UMSocialLogInfo(@"response data is %@",data);
//        //            }
//        //        }
//        //        [self alertWithError:error];
//        if (error) {
//            if ((int)error.code == 2009) {
//                [MBProgressHUD showError:@"分享已取消"];
//            }else {
//                [MBProgressHUD showError:@"分享失败"];
//            }
//        }else {
////            [MBProgressHUD showSuccess:@"分享成功"];
//            
//            if (isActivity) {
//                NSDate *now = [NSDate date];
//                long time = [now timeIntervalSince1970];
//                NSString *scoreSign = [NSString stringWithFormat:@"timestamp=%ld&type=%@&userId=%@&key=e49ea0cc83b7e0526555e4482b704904",time,type == 0?@"1":@"2",[UserInfo getUserInfo].userId];
//                NSString *scoreSignMD5 = [JMTool MD5String:scoreSign];
//                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo getUserInfo].userId,@"userId",@(time),@"timestamp",type == 0?@"1":@"2",@"type",scoreSignMD5,@"scoreSign", nil];
//                [self postWithThePath:SHARE_SUCCESS_URL Params:params Success:^(id JSON) {
//                    if ([JMTool isHttpRequestStatusOK:JSON]) {
//                        [MobClick event:type == 0?@"shareFriendNum":@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@YES,@"isGetPoints",[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
//                        [MBProgressHUD showSuccess:@"分享成功，恭喜你已获得积分好礼"];
//                        [self.navigationController popViewControllerAnimated:YES];
//                    }else {
//                        [MobClick event:type == 0?@"shareFriendNum":@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@NO,@"isGetPoints",[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
//                        [MBProgressHUD showError:JSON[@"msg"]];
//                    }
//                } Failure:^(id Error) {
//                    [MobClick event:type == 0?@"shareFriendNum":@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@NO,@"isGetPoints",[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
//                }];
//            }else {
//                [MobClick event:@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
//            }
//        }
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
