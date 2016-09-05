//
//  TestViewController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "TestViewController.h"
//#import <IQKeyboardManager.h>
#import "Masonry.h"
#import "RCDCustomerServiceViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface TestViewController ()<JMSwitchViewDatasource,JMSwitchViewDelegate,UIWebViewDelegate>
{
    int countNum;
//    UIView *view;
    UIView *view1;
    NSInteger selectedRow;
    UITableView *_tableView;
    UITableView *_tableView1;
    JMView *switchView;
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    [self getLeftBarButtonItemWithImageNormal:[UIImage imageNamed:@"登录2_03"] ImageSelected:[UIImage imageNamed:@"登录2_03"] Frame:CGRectMake(0, 0, 20, 23)];
//    
//    [self requestWithThePath:@"http://182.254.135.211:8099/duanxinInterface/message/findLabelList.htm?createUserId=1" Params:nil Method:@"GET" Success:^(id JSON) {
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"jsonDict:%@",jsonDict);
//    } Failure:^(id Error) {
//        NSLog(@"Error:%@",Error);
//    }];
    
//    JMButton *btn = [JMButton JMButtonWithImage:@"引导页1" SelectedImage:nil JMButtonType:JMButtonRect];
//    btn.backgroundColor = [UIColor redColor];
//    btn.frame = CGRectMake(100, 100, 100, 100);
//    [self.view addSubview:btn];
////    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//    self.scrollView.frame = self.view.bounds;
//    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 400, 100, 100)];
//    textField.placeholder = @"填写";
//    textField.borderStyle = UITextBorderStyleRoundedRect;
//    textField.delegate = self;
//    [self.view addSubview:textField];
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*2);
//    [self.scrollView addSubview:textField];
//    [self.view addSubview:self.scrollView];
//    UIImage *img = [UIImage imageNamed:@"引导页1"];
//    NSMutableArray *imgArray = [NSMutableArray arrayWithArray:@[img,img,img,img,img]];
//    JMScrollView *scrView = [JMScrollView scrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) Images:imgArray];
//    
//    [self.view addSubview:scrView];
    
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    
//    [self.view addSubview:imgView];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *urlStr = @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1390800033,3298177266&fm=206&gp=0.jpg";
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
//        UIImage *image = [UIImage imageWithData:data];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            imgView.image = image;
//        });
//    });
    
//    JMButton *countDownBtn = [JMButton getJMButtonWithTitle:@"点我倒计时" SelectedTitle:@"倒计时" Font:15 TitleColor:[UIColor blackColor] JMButtonType:JMButtonRect];
//    [countDownBtn addTarget:self action:@selector(createTimer:) forControlEvents:UIControlEventTouchUpInside];
//    countDownBtn.frame = CGRectMake(100, 100, 100, 100);
//    countNum = 60;
//    [self.view addSubview:countDownBtn];
    
//    int i = 4;
//    JMAlertView *alertview = [[JMAlertView alloc]initWithTitle:@"" message:@"" cancelButtonTitle:@"" otherButtonTitles:@[@""] block:^(NSInteger index) {
//        
//    }];
//    [alertview show];
//    [self.view addSubview:self.tableView];
    
//    JMButton *button = [JMButton getJMButtonWithTitle:@"点击" SelectedTitle:@"动画" Font:15 TitleColor:[UIColor redColor] JMButtonType:JMButtonNormal];
//    [button addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:button];
//    
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).with.offset(70);
//        make.right.mas_equalTo(self.view).with.offset(-20);
//        make.width.height.mas_equalTo(30);
//    }];
//    
//    UIScrollView *scrView = [[UIScrollView alloc]init];
//    scrView.contentSize = CGSizeMake(320, 1000);
//    [self.view addSubview:scrView];
//    [scrView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(button.mas_bottom).with.offset(15);
//        make.left.mas_equalTo(self.view).with.offset(15);
//        make.right.bottom.mas_equalTo(self.view).with.offset(-15);
//    }];
//    
//    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1000)];
//    [scrView addSubview:containerView];
//    
//    view = [[UIView alloc]init];
//    view.backgroundColor = [UIColor greenColor];
//    [containerView addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(containerView).with.offset(20);
//        make.bottom.mas_equalTo(containerView).with.offset(-100);
//        make.width.height.mas_equalTo(30);
//    }];
    
//    switchView = [[JMView alloc]initWithFrame:self.view.bounds SwitchHeight:50 Style:JMSwitchViewStyleVertical];
//    switchView.SwitchDatasource = self;
//    switchView.SwitchDelegate = self;
//    [self.view addSubview:switchView];
//    
//    self.tableView.frame = CGRectMake(0, 50, switchView.bounds.size.width, switchView.bounds.size.height-50);
//    self.tableView.tag = 2;
//    [switchView addSubview:self.tableView];
    
//    [MBProgressHUD showLoadingWithImages:@[[UIImage imageNamed:@"引导页1"],[UIImage imageNamed:@"引导页2"],[UIImage imageNamed:@"引导页3"]] ToView:self.view];
//    [MBProgressHUD showMessage:@"1"];
////    [MBProgressHUD hideHUD];
//    [self.manager POST:@"http://182.254.135.211:8099/lvtaocrmmanager/userTake/findRepairInfo.action" parameters:@{@"repairId":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////        dispatch_sync(dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUD];
////        });
////        [hud hide:YES];
////        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////        dispatch_async(dispatch_get_main_queue(), ^{
////            [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
////        });
////        [hud hide:YES];
//    }];
//////    [MBProgressHUD hideHUD];
//    [self postWithThePath:@"http://182.254.135.211:8099/lvtaocrmmanager/userTake/findRepairInfo.action" Params:@{@"repairId":@"1"}  Success:^(id JSON) {
//        
//    } Failure:^(id Error) {
//        
//    }];
    
//#pragma mark - 融云
//    [[RCIM sharedRCIM] initWithAppKey:@"n19jmcy5995s9"];
//    [[RCIM sharedRCIM] connectWithToken:@"YourTestUserToken" success:^(NSString *userId) {
//        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//    } error:^(RCConnectErrorCode status) {
//        NSLog(@"登陆的错误码为:%d", status);
//    } tokenIncorrect:^{
//        //token过期或者不正确。
//        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//        NSLog(@"token错误");
//    }];
//    JMButton *rongClould = [JMButton JMButtonWithTitle:@"启动客服" SelectedTitle:@"融云" Font:15 TitleColor:[UIColor blackColor] JMButtonType:JMButtonNormal];
//    rongClould.frame = CGRectMake(100, 100, 100, 50);
//    [rongClould addTarget:self action:@selector(ClickRongClould) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:rongClould];
    
    NSString *string = @"http://isishajbs";
    if ([JMTool isStringLegal:string ByJudgeString:@"^http://.*"]) {
        NSLog(@"yes");
    }else {
        NSLog(@"no");
    }
    
}

- (void)ClickRongClould {
    RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc]init];
//    chatService.userName = @"客服";
    
    chatService.defaultInputType = RCChatSessionInputBarInputText;
    chatService.conversationType = ConversationType_CUSTOMERSERVICE;
    chatService.targetId = @"KEFU147185697618931";
    chatService.title = @"客服";
    //上传用户信息，nickname是必须要填写的
    RCCustomerServiceInfo *csInfo = [[RCCustomerServiceInfo alloc] init];
    csInfo.userId = [RCIMClient sharedRCIMClient].currentUserInfo.userId;
    csInfo.nickName = @"昵称";
    csInfo.loginName = @"登录名称";
    csInfo.name = @"用户名称";
    csInfo.grade = @"11级";
    csInfo.gender = @"男";
    csInfo.birthday = @"2016.5.1";
    csInfo.age = @"36";
    csInfo.profession = @"software engineer";
    csInfo.portraitUrl =
    [RCIMClient sharedRCIMClient].currentUserInfo.portraitUri;
    csInfo.province = @"beijing";
    csInfo.city = @"beijing";
    csInfo.memo = @"这是一个好顾客!";
    
    csInfo.mobileNo = @"13800000000";
    csInfo.email = @"test@example.com";
    csInfo.address = @"北京市北苑路北泰岳大厦";
    csInfo.QQ = @"88888888";
    csInfo.weibo = @"my weibo account";
    csInfo.weixin = @"myweixin";
    
    csInfo.page = @"卖化妆品的页面来的";
    csInfo.referrer = @"客户端";
    csInfo.enterUrl = @"testurl";
    csInfo.skillId = @"技能组";
    csInfo.listUrl = @[@"用户浏览的第一个商品Url",
                       @"用户浏览的第二个商品Url"];
    csInfo.define = @"自定义信息";
    
    chatService.csInfo = csInfo;
//    chatService.title = chatService.userName;
    
//    [self.navigationController pushViewController:chatService animated:YES];
    [self.navigationController pushViewController :chatService animated:YES];
}


//- (NSArray *)titlesOfButtonsInJMView:(JMView *)jmView {
//    return @[@"1",@"2",@"3"];
//}
//
//- (UIButton *)JMSwitchView:(JMView *)jmSwitchView ButtonAtIndex:(NSUInteger)index {
//    JMButton *button = [JMButton JMButtonWithTitle:[NSString stringWithFormat:@"button%d",index] SelectedTitle:[NSString stringWithFormat:@"button%d",index] Font:15 TitleColor:[UIColor blackColor] JMButtonType:JMButtonNormal];
//    button.layer.borderWidth = 1;
//    button.layer.masksToBounds = YES;
//    return button;
//}
//
//- (JMSwitchViewContentStyle)JMSwitchView:(JMView *)jmSwitchView StyleForViewWithIndexButton:(NSUInteger)index {
//    switch (index) {
//        case 0:
//            return JMSwitchViewContentStyleTwoTableview;
//        case 1:
//            return JMSwitchViewContentStyleOneTableview;
//        default:
//            break;
//    }
//    return JMSwitchViewContentStyleCustom;
//}
//
//- (NSArray *)JMSwitchView:(JMView *)jmSwitchView TitlesForFirstTableViewWithIndexButton:(NSUInteger)index {
//    switch (index) {
//        case 0:
//            return @[@"1",@"2",@"3",@"4"];
//        case 1:
//            return @[@"1",@"2",@"3",@"4",@"7",@"啃屎"];
//        default:
//            break;
//    }
//    return @[@"1"];
//}
//
//- (NSArray *)JMSwitchView:(JMView *)jmSwitchView TitlesForSecondTableViewWithIndexButton:(NSUInteger)index FirstTableViewCell:(NSUInteger)indexRow {
//    switch (index) {
//        case 0:
//        {
//            switch (indexRow) {
//                case 0:
//                    return @[@"1",@"2",@"3",@"4",@"5",@"6"];
//                case 1:
//                    return @[@"1",@"2",@"3",@"4"];
//                default:
//                    break;
//            }
//        }
//            return @[@"1",@"2",@"3"];
//        case 1:
//            return @[@"1",@"2",@"3",@"4"];
//        default:
//            break;
//    }
//    return @[@"222"];
//}
//
//- (UIView *)JMSwitchView:(JMView *)jmSwitchView ViewAtIndex:(NSUInteger)index {
//    view1 = [[UIView alloc]init];
//    if (index == 0) {
////        view1.backgroundColor = [UIColor blueColor];
//    }else if (index == 1){
////        view1.backgroundColor = [UIColor grayColor];
//        _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.f, jmSwitchView.viewHeight-250) style:UITableViewStylePlain];
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.tag = 0;
//        view1.frame = CGRectMake(0, 0, SCREEN_WIDTH, jmSwitchView.viewHeight-250);
//        [view1 addSubview:_tableView];
//        
//        _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.f, 0, SCREEN_WIDTH/2.f, jmSwitchView.viewHeight-250) style:UITableViewStylePlain];
//        _tableView1.dataSource = self;
//        _tableView1.delegate = self;
//        _tableView1.bounces = NO;
//        _tableView1.tag = 1;
//        [view1 addSubview:_tableView1];
//    }else if (index == 2){
////        view1.backgroundColor = [UIColor yellowColor];
//    }
//    
//    return view1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView.tag == 0) {
//        return 5;
//    }else if (tableView.tag == 1){
//        return 6+selectedRow;
//    }else {
//        return 15;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView.tag == 0) {
//        static NSString *identifier = @"id";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }
//        cell.textLabel.text = [NSString stringWithFormat:@"第%d个",indexPath.row];
//        return cell;
//    }else if (tableView.tag == 1) {
//        static NSString *identifier1 = @"id1";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
//        }
//        cell.textLabel.text = [NSString stringWithFormat:@"第%d行第%d个",selectedRow,indexPath.row];
//        return cell;
//    }else {
//        static NSString *identifier1 = @"id2";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
//        }
//        cell.textLabel.text = [NSString stringWithFormat:@"第%d个",indexPath.row];
//        return cell;
//    }
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (tableView.tag == 0) {
//        if (indexPath.row == selectedRow) {
//            return;
//        }
//        selectedRow = indexPath.row;
//        [_tableView1 reloadData];
//    }else if (tableView.tag == 1){
//        [[switchView buttonAtIndex:1] setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forState:UIControlStateNormal];
//        [switchView tapCover];
//    }
//}

//- (void)ClickBtn:(id)sender {
//    [JMTool addShoppingAnimationFromView:sender ToView:view WithSuperView:self.view AndImage:[UIImage imageNamed:@"引导页1"] delagate:self];
//}
//
////- (void)animationDidStart:(CAAnimation *)anim {
////    NSLog(@"1");
////}
//
//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    self.view.userInteractionEnabled = YES;
//    
//    [JMTool addShakeAnimation:view];
//}

//- (void)createTimer:(JMButton *)sender {
//    sender.userInteractionEnabled = NO;
//    [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timerRepeat:) userInfo:sender repeats:YES];
//}
//
//- (void)timerRepeat:(NSTimer *)sender {
//    JMButton *button = sender.userInfo;
//    [button setTitle:[NSString stringWithFormat:@"%d",countNum] forState:UIControlStateNormal];
//    countNum--;
//    if (countNum<0) {
//        button.userInteractionEnabled = YES;
//        [button setTitle:@"点我倒计时" forState:UIControlStateNormal];
//        countNum = 60;
//        [sender invalidate];
//    }
//}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField.text.length == 11 && ![string isEqualToString:@""]) {
//        return NO;
//    }
//    
//    return YES;
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
