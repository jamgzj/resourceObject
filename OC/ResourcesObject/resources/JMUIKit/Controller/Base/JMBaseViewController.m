//
//  JMBaseViewController.m
//  ResourcesObject
//
//  Created by 顾泽俊 on 2019/7/2.
//  Copyright © 2019 zhengxingxia. All rights reserved.
//

#import "JMBaseViewController.h"
#import "UINavigationController+JMFullScreenSwipe.h"

@interface JMBaseViewController ()

@end

@implementation JMBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _enableSwipeToDismiss = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        self.navigationController.enableSwipeToDismiss = _enableSwipeToDismiss;
    }
}

- (void)setEnableSwipeToDismiss:(BOOL)enableSwipeToDismiss
{
    _enableSwipeToDismiss = enableSwipeToDismiss;
    if (self.navigationController) {
        self.navigationController.enableSwipeToDismiss = enableSwipeToDismiss;
    }
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
