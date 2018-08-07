//
//  BaseTableViewCell.h
//  TouTimeMerchants
//
//  Created by zhengxingxia on 16/11/22.
//  Copyright © 2016年 上海绿桃软件科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "JMTool.h"
#import "UIImageView+WebCache.h"
#import <IQKeyboardManager/IQTextView.h>


@interface BaseTableViewCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak,nonatomic)UIView *bgView1;
@property (weak,nonatomic)UIView *bgView2;

@property (weak,nonatomic)UIView *line1;
@property (weak,nonatomic)UIView *line2;
@property (weak,nonatomic)UIView *line3;

@property (weak,nonatomic)UIView *view1;
@property (weak,nonatomic)UIView *view2;
@property (weak,nonatomic)UIView *view3;
@property (weak,nonatomic)UIView *view4;

@property (weak,nonatomic)UILabel *label1;
@property (weak,nonatomic)UILabel *label2;
@property (weak,nonatomic)UILabel *label3;
@property (weak,nonatomic)UILabel *label4;
@property (weak,nonatomic)UILabel *label5;
@property (weak,nonatomic)UILabel *label6;

@property (weak,nonatomic)UIButton *button1;
@property (weak,nonatomic)UIButton *button2;
@property (weak,nonatomic)UIButton *button3;
@property (weak,nonatomic)UIButton *button4;
@property (weak,nonatomic)UIButton *button5;
@property (weak,nonatomic)UIButton *button6;

@property (weak,nonatomic)UIImageView *imageView1;
@property (weak,nonatomic)UIImageView *imageView2;
@property (weak,nonatomic)UIImageView *imageView3;
@property (weak,nonatomic)UIImageView *imageView4;

@property (weak,nonatomic)UITextField *textfield;
@property (weak,nonatomic)IQTextView *textView;

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)UIScrollView *scrollView;

@end
