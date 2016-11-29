//
//  BaseTableViewCell.m
//  TouTimeMerchants
//
//  Created by zhengxingxia on 16/11/22.
//  Copyright © 2016年 上海绿桃软件科技有限公司. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *bgView1 = [[UIView alloc]init];
        [self addSubview:bgView1];
        _bgView1 = bgView1;
        
        UIView *bgView2 = [[UIView alloc]init];
        [self addSubview:bgView2];
        _bgView2 = bgView2;
        
        UIView *line1 = [[UIView alloc]init];
        [self addSubview:line1];
        _line1 = line1;
        
        UIView *line2 = [[UIView alloc]init];
        [self addSubview:line2];
        _line2 = line2;
        
        UIView *line3 = [[UIView alloc]init];
        [self addSubview:line3];
        _line3 = line3;
        
        UIView *view1 = [[UIView alloc]init];
        [self addSubview:view1];
        _view1 = view1;
        
        UIView *view2 = [[UIView alloc]init];
        [self addSubview:view2];
        _view2 = view2;
        
        UIView *view3 = [[UIView alloc]init];
        [self addSubview:view3];
        _view3 = view3;
        
        UIView *view4 = [[UIView alloc]init];
        [self addSubview:view4];
        _view4 = view4;
        
        UILabel *label1 = [[UILabel alloc]init];
        [self addSubview:label1];
        _label1 = label1;
        
        UILabel *label2 = [[UILabel alloc]init];
        [self addSubview:label2];
        _label2 = label2;
        
        UILabel *label3 = [[UILabel alloc]init];
        [self addSubview:label3];
        _label3 = label3;
        
        UILabel *label4 = [[UILabel alloc]init];
        [self addSubview:label4];
        _label4 = label4;
        
        UILabel *label5 = [[UILabel alloc]init];
        [self addSubview:label5];
        _label5 = label5;
        
        UILabel *label6 = [[UILabel alloc]init];
        [self addSubview:label6];
        _label6 = label6;
        
        UIButton *button1 = [[UIButton alloc]init];
        [self addSubview:button1];
        _button1 = button1;
        
        UIButton *button2 = [[UIButton alloc]init];
        [self addSubview:button2];
        _button2 = button2;
        
        UIButton *button3 = [[UIButton alloc]init];
        [self addSubview:button3];
        _button3 = button3;
        
        UIButton *button4 = [[UIButton alloc]init];
        [self addSubview:button4];
        _button4 = button4;
        
        UIButton *button5 = [[UIButton alloc]init];
        [self addSubview:button5];
        _button5 = button5;
        
        UIButton *button6 = [[UIButton alloc]init];
        [self addSubview:button6];
        _button6 = button6;
        
        UIImageView *imageView1 = [[UIImageView alloc]init];
        [self addSubview:imageView1];
        _imageView1 = imageView1;
        
        UIImageView *imageView2 = [[UIImageView alloc]init];
        [self addSubview:imageView2];
        _imageView2 = imageView2;
        
        UIImageView *imageView3 = [[UIImageView alloc]init];
        [self addSubview:imageView3];
        _imageView3 = imageView3;
        
        UIImageView *imageView4 = [[UIImageView alloc]init];
        [self addSubview:imageView4];
        _imageView4 = imageView4;
        
    }
    return self;
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
        [self addSubview:_tableView];
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
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
