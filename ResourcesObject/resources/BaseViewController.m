//
//  BaseViewController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@--%@",self.description,_jmNavigationView.title.text]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@--%@",self.description,_jmNavigationView.title.text]];
}

- (UIView *)jmCover {
    if (!_jmCover) {
        _jmCover = [[UIView alloc]initWithFrame:self.view.bounds];
        _jmCover.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        _jmCover.hidden = YES;
        [self.view addSubview:_jmCover];
//        [self.view sendSubviewToBack:_jmCover];
    }
    return _jmCover;
}

- (JMNavView *)jmNavigationView {
    if (!_jmNavigationView) {
        _jmNavigationView = [[JMNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, navHeight)];
        self.jmNavigationView.title.textColor = MainFontColor;
        self.jmNavigationView.title.font = MAIN_BOLD_FONT(13*COEFFICIENT);
        [self.view addSubview:_jmNavigationView];
    }
    return _jmNavigationView;
}

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
        //        [_groupedTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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

- (void)forceToPushLoginVC {
    [MBProgressHUD showError:@"你还没有登录哦~"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LoginViewController *loginVC = [LoginViewController sharedInstance];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    });
}

#pragma mark - 自定义 alertView

- (void)showAlertViewWithTextFieldWithTitle:(NSString *)title {
    UIView *cover = [[UIView alloc]initWithFrame:self.view.bounds];
    cover.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    [self.view addSubview:cover];
    [self.view bringSubviewToFront:cover];
    
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cover.width-60*COEFFICIENT, 5*(cover.width-60*COEFFICIENT)/8.f)];
    alertView.center = cover.center;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5*COEFFICIENT;
    [cover addSubview:alertView];
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = title;
    titleL.font = MAIN_FONT(13*COEFFICIENT);
    titleL.textColor = MainFontColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:titleL];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"remindpopup_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(ClickAlertCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    _closeBtn = closeBtn;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor whiteColor];
    line.layer.cornerRadius = 20*COEFFICIENT;
    line.layer.borderWidth = COEFFICIENT;
    line.layer.borderColor = MainColor.CGColor;
    [alertView addSubview:line];
    
    UITextField *textField = [[UITextField alloc]init];
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.layer.cornerRadius = 20*COEFFICIENT;
//    textField.layer.borderWidth = 0.5*COEFFICIENT;
//    textField.layer.borderColor = MainColor.CGColor;
    NSDictionary *attrsDictionary =@{
                                     NSFontAttributeName:textField.font,
                                     NSKernAttributeName:[NSNumber numberWithFloat:10*COEFFICIENT]//这里修改字符间距
                                     };
    textField.defaultTextAttributes = attrsDictionary;
    textField.secureTextEntry = YES;
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.contentMode = UIViewContentModeCenter;
    [alertView addSubview:textField];
    _payTextField = textField;
    
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.height.mas_equalTo(50*cover.width/SCREEN_WIDTH*COEFFICIENT);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(alertView);
        make.top.mas_equalTo(25*COEFFICIENT);
        make.right.mas_lessThanOrEqualTo(closeBtn.mas_left);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textField.mas_left).with.offset(-20*COEFFICIENT);
        make.right.mas_equalTo(textField).with.offset(20*COEFFICIENT);
        make.top.bottom.mas_equalTo(textField);
    }];
    
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleL.mas_bottom).with.offset(20*COEFFICIENT);
        make.centerX.mas_equalTo(alertView);
        make.width.mas_equalTo(110*COEFFICIENT);
        make.height.mas_equalTo(40*COEFFICIENT);
    }];
    
    
}

- (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message Image:(UIImage *)image {
    
    UIView *cover = [[UIView alloc]initWithFrame:self.view.bounds];
    cover.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    [self.view addSubview:cover];
    [self.view bringSubviewToFront:cover];
    
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cover.width-60*COEFFICIENT, 5*(cover.width-60*COEFFICIENT)/8.f)];
    alertView.center = cover.center;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5*COEFFICIENT;
    [cover addSubview:alertView];
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = title;
    titleL.font = MAIN_FONT(13*COEFFICIENT);
    titleL.textColor = MainFontColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:titleL];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"remindpopup_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(ClickAlertCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    
    UILabel *msgL = [[UILabel alloc]init];
    msgL.text = message;
    msgL.textColor = MainFontColor;
    msgL.font = MAIN_FONT(11*COEFFICIENT);
    msgL.numberOfLines = 0;
    msgL.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:msgL];
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    [alertView addSubview:imageV];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.height.mas_equalTo(50*cover.width/SCREEN_WIDTH*COEFFICIENT);
    }];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(alertView);
        make.top.mas_equalTo(25*COEFFICIENT);
        make.right.mas_lessThanOrEqualTo(closeBtn.mas_left);
    }];
    
    [msgL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleL);
        make.top.mas_equalTo(titleL.mas_bottom).with.offset(5*COEFFICIENT);
        make.right.mas_lessThanOrEqualTo(closeBtn.mas_left);
    }];
    
    if (image) {
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(titleL);
            make.top.mas_lessThanOrEqualTo(msgL.mas_bottom).with.offset(15*COEFFICIENT);
            make.height.mas_equalTo(60*COEFFICIENT);
            make.width.mas_equalTo(imageV.mas_height).multipliedBy(image.size.width/image.size.height);
            make.bottom.mas_lessThanOrEqualTo(-5*COEFFICIENT);
        }];
    }
}

- (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message ActionTitle:(NSString *)actionTitle CancelTitle:(NSString *)cancelTitle Sel:(SEL)action {
    
    UIView *cover = [[UIView alloc]initWithFrame:self.view.bounds];
    cover.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    [self.view addSubview:cover];
    [self.view bringSubviewToFront:cover];
    
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cover.width-60*COEFFICIENT, 5*(cover.width-60*COEFFICIENT)/8.f)];
    alertView.center = cover.center;
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5*COEFFICIENT;
    [cover addSubview:alertView];
    
    UILabel *titleL = [[UILabel alloc]init];
    titleL.text = title;
    titleL.font = MAIN_FONT(13*COEFFICIENT);
    titleL.textColor = MainFontColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:titleL];
    
    UILabel *msgL = [[UILabel alloc]init];
    msgL.text = message;
    msgL.textColor = MainFontColor;
    msgL.font = MAIN_FONT(11*COEFFICIENT);
    msgL.numberOfLines = 0;
    msgL.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:msgL];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:actionTitle forState:UIControlStateNormal];
    sureBtn.titleLabel.font = MAIN_FONT(13*COEFFICIENT);
    [sureBtn setTitleColor:MainColor forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:sureBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = MAIN_FONT(13*COEFFICIENT);
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = MainColor;
    [cancelBtn addTarget:self action:@selector(ClickAlertCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:cancelBtn];
    
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(alertView);
        make.top.mas_equalTo(35*COEFFICIENT);
        make.right.mas_lessThanOrEqualTo(-20*COEFFICIENT);
    }];
    
    [msgL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleL);
        make.top.mas_equalTo(titleL.mas_bottom).with.offset(5*COEFFICIENT);
        make.right.mas_lessThanOrEqualTo(-10*COEFFICIENT);
        make.bottom.mas_lessThanOrEqualTo(sureBtn.mas_top).with.offset(-5*COEFFICIENT);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(alertView.mas_centerX).with.offset(-5*COEFFICIENT);
        make.bottom.mas_equalTo(-30*COEFFICIENT);
        make.height.mas_equalTo(25*COEFFICIENT);
        make.width.mas_equalTo(100*COEFFICIENT);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(alertView.mas_centerX).with.offset(5*COEFFICIENT);
        make.bottom.mas_equalTo(-30*COEFFICIENT);
        make.height.mas_equalTo(25*COEFFICIENT);
        make.width.mas_equalTo(100*COEFFICIENT);
    }];
    
    [alertView layoutIfNeeded];
    sureBtn.layer.cornerRadius = 12.5;
    sureBtn.layer.borderWidth = 1.5*COEFFICIENT;
    sureBtn.layer.borderColor = MainColor.CGColor;
    cancelBtn.layer.cornerRadius = 12.5;
    cancelBtn.layer.borderWidth = 1.5*COEFFICIENT;
    cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)ClickAlertCloseBtn:(id)sender {
    UIButton *button = sender;
    [[[button superview]superview] removeFromSuperview];
}

#pragma mark - 网络请求

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 10.f;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _manager;
}

- (void)getWithThePath:(NSString *)path Params:(NSDictionary *)params Success:(HttpSuccessBlock)success Failure:(HttpFailureBlock)failure {
    [self requestWithThePath:path Params:params Method:@"GET" Success:success Failure:failure];
}

- (void)postWithThePath:(NSString *)path Params:(NSDictionary *)params Success:(HttpSuccessBlock)success Failure:(HttpFailureBlock)failure {
    [self requestWithThePath:path Params:params Method:@"POST" Success:success Failure:failure];
}

- (void)requestWithThePath:(NSString *)path Params:(NSDictionary *)params Method:(NSString *)method Success:(HttpSuccessBlock)success Failure:(HttpFailureBlock)failure{
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:@"loading..." toView:self.view];
    });
    
    if ([method isEqualToString:@"POST"]) {   //发送post请求
        
        [self.manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
        //    NSLog(@"JSON------>%@",JSON);
            
            //传递数据
            success(JSON);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
        
            NSLog(@"error:%@",error);
            failure(error);
        }];
        
    }else if ([method isEqualToString:@"GET"]){   //发送get请求
        
        [self.manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"JSON------>%@",JSON);
            
            //传递数据
            success(JSON);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
            
            NSLog(@"error:%@",error);
            failure(error);
        }];
    }
}

- (void)requestWithThePath:(NSString *)path
                      Data:(NSData *)data
                   KeyName:(NSString *)kName
                    Params:(NSDictionary *)params
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:@"loading..." toView:self.view];
    });
    
    [self.manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:kName fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        //传递数据
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"JSON------>%@",JSON);
        
        //传递数据
        success(JSON);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
        
        NSLog(@"error:%@",error);
        
        failure(error);
    }];
}

- (void)requestWithThePath:(NSString *)path
                  imgArray:(NSArray *)imgArray
              KeyNameArray:(NSArray *)kNameArray
                    Params:(NSDictionary *)params
                   Success:(HttpSuccessBlock)success
                   Failure:(HttpFailureBlock)failure {
    
    for (id object in imgArray) {
        NSAssert([object isKindOfClass:[UIImage class]] || [object isKindOfClass:[NSData class]] || [object isKindOfClass:[NSString class]], @"Undefined symbols in imgArray");
    }
    
    for (id object in kNameArray) {
        NSAssert([object isKindOfClass:[NSString class]], @"Undefined symbols in kNameArray");
    }
    
    NSString *urlStr = [JMTool isStringLegal:path ByJudgeString:@"^http://.*"]?path:[NSString stringWithFormat:@"%@",IP_ADRESS_URL(path)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showMessage:@"loading..." toView:self.view];
    });
    
    [self.manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < (imgArray.count > kNameArray.count?kNameArray.count:imgArray.count) ; i++) {
            if ([imgArray[i] isKindOfClass:[NSData class]]) {
                [formData appendPartWithFileData:imgArray[i] name:kNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            }else if ([imgArray[i] isKindOfClass:[UIImage class]]) {
                UIImage *image = imgArray[i];
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil) {
                    
                    data = UIImageJPEGRepresentation(image, 1);
                    
                } else {
                    
                    data = UIImagePNGRepresentation(image);
                }
                [formData appendPartWithFileData:data name:kNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            }else if ([imgArray[i] isKindOfClass:[NSString class]]) {
                UIImage *image = [UIImage imageNamed:imgArray[i]];
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil) {
                    
                    data = UIImageJPEGRepresentation(image, 1);
                    
                } else {
                    
                    data = UIImagePNGRepresentation(image);
                }
                [formData appendPartWithFileData:data name:kNameArray[i] fileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] mimeType:@"image/jpeg"];
            }
            
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        //传递数据
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"JSON------>%@",JSON);
        
        //传递数据
        success(JSON);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [MBProgressHUD showError:@"网络请求失败,请稍后再试哦"];
        
        NSLog(@"error:%@",error);
        
        failure(error);
    }];
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

- (UITableViewCell *)RecommendTitleCellWithTitle:(NSString *)title
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    JMLabel *titleLabel = [JMLabel labelWithText:title Font:18.f textColor:[UIColor blackColor]];
    titleLabel.frame = CGRectMake(20, 2.5, 150, 35);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:titleLabel];
    return cell;
}

-(void)shadowWithView:(UIView *)view Radius:(CGFloat)Radius
{
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = Radius;
    view.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:0.3].CGColor;
    view.layer.shadowRadius = 2;
    view.layer.shadowOpacity = 1.f;
    view.layer.shadowOffset = CGSizeZero;
    
}

#pragma mark - 分享

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType WithType:(int)type WithActivity:(BOOL)isActivity
{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    
    //    NSString* thumbURL = _type == InviteFriendViewControllerTypeInvite?[NSString stringWithFormat:@"%@?userId=%@",IP_ADRESS_URL(CODE_IMAGE_URL),[UserInfo getUserInfo].userId]:APP_DOWNLOAD_URL;
    UIImage *shareImg = [UIImage imageNamed:@"downLoad_share.png"];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = type == 0?
    [UMShareWebpageObject shareObjectWithTitle:@"来偷时，偷小时换咖啡" descr:@"来偷时，一起体验“偷一把”的快感，偷得小时换商品，秒优惠！" thumImage:shareImg]
    :
    [UMShareWebpageObject shareObjectWithTitle:@"来偷时，享一杯好咖啡" descr:@"来偷时，在浓郁的咖啡文化里，随时随地点一杯、学一杯或看大咖秀一杯" thumImage:shareImg];
    
    //    if (!thumbURL) {
    //        shareObject.thumbImage = [UIImage imageNamed:@"main_tou"];
    //    }
//    //设置网页地址
//    shareObject.webpageUrl = type == 0?[NSString stringWithFormat:@"%@?userId=%@",IP_ADRESS_URL(SHARE_INVITE_URL),[UserInfo getUserInfo].userId]:APP_DOWNLOAD_URL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    if (type==0) {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo getUserInfo].userId,@"userId", nil];
        [self postWithThePath:SHARE_INVITE_URL Params:params Success:^(id JSON) {
            if ([JMTool isHttpRequestStatusOK:JSON]) {
                shareObject.webpageUrl = JSON[@"rows"];
                [self shareToPlatform:platformType messageObject:messageObject WithType:type IsActivity:isActivity];
            }else {
                [MBProgressHUD showError:JSON[@"msg"]];
            }
        } Failure:^(id Error) {
            
        }];
    }else {
        shareObject.webpageUrl = APP_DOWNLOAD_URL;
        [self shareToPlatform:platformType messageObject:messageObject WithType:type IsActivity:isActivity];
    }
    
}

- (void)shareToPlatform:(UMSocialPlatformType)platformType messageObject:(UMSocialMessageObject *)messageObject WithType:(int)type IsActivity:(BOOL)isActivity {
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        //        if (error) {
        //            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        //        }else{
        //            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
        //                UMSocialShareResponse *resp = data;
        //                //分享结果消息
        //                UMSocialLogInfo(@"response message is %@",resp.message);
        //                //第三方原始返回的数据
        //                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
        //
        //            }else{
        //                UMSocialLogInfo(@"response data is %@",data);
        //            }
        //        }
        //        [self alertWithError:error];
        if (error) {
            if ((int)error.code == 2009) {
                [MBProgressHUD showError:@"分享已取消"];
            }else {
                [MBProgressHUD showError:@"分享失败"];
            }
        }else {
//            [MBProgressHUD showSuccess:@"分享成功"];
            
            if (isActivity) {
                NSDate *now = [NSDate date];
                long time = [now timeIntervalSince1970];
                NSString *scoreSign = [NSString stringWithFormat:@"timestamp=%ld&type=%@&userId=%@&key=e49ea0cc83b7e0526555e4482b704904",time,type == 0?@"1":@"2",[UserInfo getUserInfo].userId];
                NSString *scoreSignMD5 = [JMTool MD5String:scoreSign];
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[UserInfo getUserInfo].userId,@"userId",@(time),@"timestamp",type == 0?@"1":@"2",@"type",scoreSignMD5,@"scoreSign", nil];
                [self postWithThePath:SHARE_SUCCESS_URL Params:params Success:^(id JSON) {
                    if ([JMTool isHttpRequestStatusOK:JSON]) {
                        [MobClick event:type == 0?@"shareFriendNum":@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@YES,@"isGetPoints",[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
                        [MBProgressHUD showSuccess:@"分享成功，恭喜你已获得积分好礼"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else {
                        [MobClick event:type == 0?@"shareFriendNum":@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@NO,@"isGetPoints",[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
                        [MBProgressHUD showError:JSON[@"msg"]];
                    }
                } Failure:^(id Error) {
                    [MobClick event:type == 0?@"shareFriendNum":@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:@NO,@"isGetPoints",[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
                }];
            }else {
                [MobClick event:@"shareDownLoadNum" attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UserInfo getUserInfo].userId,@"userId",platformType==UMSocialPlatformType_WechatSession?@"微信":@"朋友圈",@"platformType", nil]];
            }
        }
    }];
}

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
