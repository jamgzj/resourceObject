//
//  BaseViewController.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/5/30.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - 网络请求

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 20.f;
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
    
    if ([method isEqualToString:@"POST"]) {   //发送post请求
        
        [MBProgressHUD showMessage:@"loading..." toView:self.view];
        
        [self.manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
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
        
    }else if ([method isEqualToString:@"GET"]){   //发送get请求
        
        [MBProgressHUD showMessage:@"loading..." toView:self.view];
        
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
    
    [MBProgressHUD showMessage:@"loading" toView:self.view];
    
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
    
    [MBProgressHUD showMessage:@"loading" toView:self.view];
    
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
        frame = CGRectMake(0, 0, 40, 30);
    }
    
    self.tabBarController.tabBar.hidden = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:imgNormal forState:UIControlStateNormal];
    [button setImage:imgSelected forState:UIControlStateSelected];
    [button addTarget:self action:@selector(ClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
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
    [button addTarget:self action:@selector(ClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)ClickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
    NSArray *vcArray = self.navigationController.viewControllers;
    if ([vcArray indexOfObject:self] == 1) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)resetViewFrame {
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
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
