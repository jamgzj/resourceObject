//
//  JMNavView.m
//  Tou-Time
//
//  Created by zhengxingxia on 16/10/10.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMNavView.h"
#import <Masonry/Masonry.h>
#import "Header.h"
#import "NSString+Extension.h"

@implementation JMNavView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *titleL = [[UILabel alloc]init];
        [self addSubview:titleL];
        self.titleLabel = titleL;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).with.offset(10);
        make.top.mas_greaterThanOrEqualTo(0);
        make.bottom.mas_lessThanOrEqualTo(0);
    }];
}

- (void)setTitle:(NSString *)title {
    if (title) {
        _title = title;
        for (int i = 0; i < title.length; i++) {
            if (i != title.length-1) {
                _title = [_title stringByReplacingCharactersInRange:NSMakeRange(2*i+1, 0) withString:@" "];
            }
        }
        self.titleLabel.text = _title;
    }
}

- (void)addJmLeftBarBtnWithTitle:(NSString *)title Target:(id)target {
    float width = [title SizeWithFont:[UIFont systemFontOfSize:13]].width;
    float btnHeight = navHeight-20;
    float btnWidth = width>btnHeight?width:btnHeight;
    UIButton *JmLeftBarBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*coefficient, 20, btnWidth, btnHeight)];
    JmLeftBarBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [JmLeftBarBtn setTitle:title forState:UIControlStateNormal];
    [JmLeftBarBtn addTarget:target action:@selector(ClickJmLeftBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:JmLeftBarBtn];
    self.jmLeftBarBtn = JmLeftBarBtn;
}

- (void)addJmLeftBarBtnWithImage:(UIImage *)image Target:(id)target {
    CGSize size = image.size;
    float btnHeight = navHeight-20;
    float imgHeight = 17*coefficient;
    float imgWidth = imgHeight*size.width/size.height;
    UIButton *JmLeftBarBtn = [[UIButton alloc]initWithFrame:CGRectMake(5*coefficient, 20, btnHeight, btnHeight)];
    [JmLeftBarBtn setImage:image forState:UIControlStateNormal];
    [JmLeftBarBtn addTarget:target action:@selector(ClickJmLeftBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (imgWidth > btnHeight) {
        imgWidth = btnHeight;
        imgHeight = imgWidth*size.height/size.width;
    }
    JmLeftBarBtn.imageEdgeInsets = UIEdgeInsetsMake((btnHeight-imgHeight)/2.f, (btnHeight-imgWidth)/2.f, (btnHeight-imgHeight)/2.f, (btnHeight-imgWidth)/2.f);
    [self addSubview:JmLeftBarBtn];
    self.jmLeftBarBtn = JmLeftBarBtn;
}

- (void)addJmRightBarBtnWithTitle:(NSString *)title Target:(id)target {
    float width = [title SizeWithFont:[UIFont systemFontOfSize:13]].width;
    float btnHeight = navHeight-20;
    float btnWidth = width>btnHeight?width:btnHeight;
    UIButton *JmRightBarBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-5*coefficient-btnWidth, 20, btnWidth, btnHeight)];
    JmRightBarBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [JmRightBarBtn setTitle:title forState:UIControlStateNormal];
    [JmRightBarBtn addTarget:target action:@selector(ClickJmRightBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:JmRightBarBtn];
    self.jmRightBarBtn = JmRightBarBtn;
}

- (void)addJmRightBarBtnWithImage:(UIImage *)image Target:(id)target {
    CGSize size = image.size;
    float btnHeight = navHeight-20;
    float imgHeight = 17*coefficient;
    float imgWidth = imgHeight*size.width/size.height;
    UIButton *JmRightBarBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-5*coefficient-btnHeight, 20, btnHeight, btnHeight)];
    [JmRightBarBtn setImage:image forState:UIControlStateNormal];
    [JmRightBarBtn addTarget:target action:@selector(ClickJmRightBarBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (imgWidth > btnHeight) {
        imgWidth = btnHeight;
        imgHeight = imgWidth*size.height/size.width;
    }
    JmRightBarBtn.imageEdgeInsets = UIEdgeInsetsMake((btnHeight-imgHeight)/2.f, (btnHeight-imgWidth)/2.f, (btnHeight-imgHeight)/2.f, (btnHeight-imgWidth)/2.f);
    [self addSubview:JmRightBarBtn];
    self.jmRightBarBtn = JmRightBarBtn;
}

- (UIButton *)addButtonWithTitle:(NSString *)title OriginX:(float)originX {
    float width = [title SizeWithFont:[UIFont systemFontOfSize:13]].width;
    float btnHeight = navHeight-20;
    float btnWidth = width>btnHeight?width:btnHeight;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(originX, 20, btnWidth, btnHeight)];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitle:title forState:UIControlStateNormal];
    [self addSubview:button];
    return button;
}

- (UIButton *)addButtonWithImage:(UIImage *)image OriginX:(float)originX {
    CGSize size = image.size;
    float btnHeight = navHeight-20;
    float imgHeight = 17*coefficient;
    float imgWidth = imgHeight*size.width/size.height;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(originX, 20, btnHeight, btnHeight)];
    [button setImage:image forState:UIControlStateNormal];
    if (imgWidth > btnHeight) {
        imgWidth = btnHeight;
        imgHeight = imgWidth*size.height/size.width;
    }
    button.imageEdgeInsets = UIEdgeInsetsMake((btnHeight-imgHeight)/2.f, (btnHeight-imgWidth)/2.f, (btnHeight-imgHeight)/2.f, (btnHeight-imgWidth)/2.f);
    [self addSubview:button];
    return button;
}

- (void)addGrayShadow {
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1.5*coefficient);
    self.layer.shadowRadius = 0;
    self.layer.shadowOpacity = 1.f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
















