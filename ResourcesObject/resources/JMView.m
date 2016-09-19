//
//  JMView.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/8/3.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMView.h"

#define slideColor [UIColor redColor]               //平移栏的颜色

static const int tableView1Tag = 0;
static const int tableView2Tag = 1;
static const int buttonTag = 800;

@interface JMView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_btnArray;                      //按钮数组
    NSArray *_buttonTitles;                         //按钮标题数组
    NSMutableArray *_coverArray;                    //覆盖层数组
    UIView *_switchView;                            //按钮所在的视图
    UIScrollView *_scrollView;                      //水平横移的下方视图
    UIView *_slideAnimationView;                    //选中平移栏(水平横移时有)
    JMSwitchViewStyle _style;
    float _switchHeight;                            //按钮视图高度
    float _viewHeight;
    NSInteger _selextedIndex;                       //选中的按钮的位置
    NSMutableDictionary *_selectedRow;              //选中的row的位置信息
}

/**
 *  内容视图的高度
 */
@property (assign,nonatomic)float viewHeight;

@end

@implementation JMView

- (instancetype)initWithFrame:(CGRect)frame SwitchHeight:(float)switchHeight Style:(JMSwitchViewStyle)style{
    if (self = [super initWithFrame:frame]) {
        _switchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, switchHeight)];
        [self addSubview:_switchView];
        _switchHeight = switchHeight;
        _viewHeight = frame.size.height - _switchHeight;
        _style = style;
        _btnArray = [NSMutableArray arrayWithCapacity:5];
        if (_style == JMSwitchViewStyleHorizontal) {
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, switchHeight, frame.size.width, frame.size.height-switchHeight)];
            _scrollView.pagingEnabled = YES;
            _scrollView.delegate = self;
            _scrollView.bounces = NO;
            _scrollView.userInteractionEnabled = YES;
            _scrollView.autoresizesSubviews = NO;
            [self addSubview:_scrollView];
        }else {
            _coverArray = [NSMutableArray arrayWithCapacity:5];
            _selextedIndex = -1;
            _selectedRow = [NSMutableDictionary dictionaryWithCapacity:5];
        }
    }
    return self;
}

- (void)setSwitchDatasource:(id<JMSwitchViewDatasource>)SwitchDatasource {
    _SwitchDatasource = SwitchDatasource;
    _buttonTitles = [_SwitchDatasource titlesOfButtonsInJMView:self];
    
    float buttonWidth = self.frame.size.width/_buttonTitles.count;
    
    for (int i = 0; i < _buttonTitles.count; i++) {
        UIButton *button;
        if ([_SwitchDatasource JMSwitchView:self ButtonAtIndex:i]) {
            button = [_SwitchDatasource JMSwitchView:self ButtonAtIndex:i];
        }else {
            button = [[UIButton alloc]init];
        }
        
        [button setTitle:[NSString stringWithFormat:@"%@",_buttonTitles[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, _switchHeight);
        button.tag = i + buttonTag;
        [button addTarget:self action:@selector(ClickSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_btnArray addObject:button];
    }
    
    if (_style == JMSwitchViewStyleHorizontal) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*_buttonTitles.count, _scrollView.frame.size.height);
        _slideAnimationView = [[UIView alloc]initWithFrame:CGRectMake(5, _switchHeight-6, buttonWidth-10, 5)];
        _slideAnimationView.backgroundColor = slideColor;
        [_switchView addSubview:_slideAnimationView];
        for (int i = 0; i < 3; i++) {
            if ([_SwitchDatasource respondsToSelector:@selector(JMSwitchView:ViewAtIndex:)]) {
                UIView *view = [_SwitchDatasource JMSwitchView:self ViewAtIndex:i];
                view.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
                [_scrollView addSubview:view];
            }
        }
    }else {
        for (int i = 0; i < _buttonTitles.count; i++) {
            UIView *cover = [[UIView alloc]initWithFrame:CGRectMake(0, _switchHeight, self.frame.size.width, 0)];
            cover.backgroundColor = [UIColor colorWithWhite:0.298 alpha:0.500];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            tap.delegate = self;
            [cover addGestureRecognizer:tap];
            
            [_coverArray addObject:cover];
            [self addSubview:cover];
            [self sendSubviewToBack:cover];
        }
        for (int i = 0; i < _coverArray.count; i++) {
            [self addCoverViewInCover:i];
        }
    }
}

- (void)ClickSwitchBtn:(id)sender {
    
    UIButton *button = sender;
    
    if (_style == JMSwitchViewStyleHorizontal) {
        [_scrollView setContentOffset:CGPointMake((button.tag-buttonTag) * self.frame.size.width, 0) animated:YES];
        
    }else {
        if (_selextedIndex == -1) {
            
            _selextedIndex = button.tag-buttonTag;
            
            UIView *cover = [self coverAtIndex:_selextedIndex];
            [self bringSubviewToFront:cover];
            
            [UIView animateWithDuration:0.2 animations:^{
                cover.frame = CGRectMake(0, _switchHeight, self.frame.size.width, _viewHeight);
            } completion:^(BOOL finished) {
                
            }];
        }else if (_selextedIndex == button.tag-buttonTag) {
            [self tapCover];
            
        }else {
            
            UIView *cover1 = [self coverAtIndex:_selextedIndex];
            
            _selextedIndex = button.tag-buttonTag;
            
            UIView *cover2 = [self coverAtIndex:_selextedIndex];
            
            [self bringSubviewToFront:cover2];
            
            [UIView animateWithDuration:0.2 animations:^{
                cover1.frame = CGRectMake(0, _switchHeight, self.frame.size.width, 0);
            } completion:^(BOOL finished) {
                [self sendSubviewToBack:cover1];
                [UIView animateWithDuration:0.2 animations:^{
                    cover2.frame = CGRectMake(0, _switchHeight, self.frame.size.width, _viewHeight);
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }
        
        if (self.SwitchDelegate && [self.SwitchDelegate respondsToSelector:@selector(JMSwitchView:didSelectButtonAtIndex:)]) {
            [self.SwitchDelegate JMSwitchView:self didSelectButtonAtIndex:button.tag-buttonTag];
        }
    }
    
}

- (void)addCoverViewInCover:(NSUInteger)index {
    
    UIView *coverView;
    
    // 判断代理是否存在
    if ([_SwitchDatasource respondsToSelector:@selector(JMSwitchView:StyleForViewWithIndexButton:)]) {
        
        // 判断内容视图的类型
        if ([_SwitchDatasource JMSwitchView:self StyleForViewWithIndexButton:index]==JMSwitchViewContentStyleOneTableview) {
            
            coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height-_switchHeight)/2.f)];
            UITableView *tableView = [self createTableView];
            tableView.tag = tableView1Tag+1000*(index+1);
            tableView.frame = coverView.bounds;
            [coverView addSubview:tableView];
            
        }else if ([_SwitchDatasource JMSwitchView:self StyleForViewWithIndexButton:index]==JMSwitchViewContentStyleTwoTableview) {
            
            coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height-_switchHeight)/2.f)];
            
            UITableView *tableView1 = [self createTableView];
            tableView1.tag = tableView1Tag+1000*(index+1);
            tableView1.frame = CGRectMake(0, 0, self.frame.size.width/2.f-0.5, (self.frame.size.height-_switchHeight)/2.f);
            [coverView addSubview:tableView1];
            
            // 添加分割线
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2.f, 0, 0, (self.frame.size.height-_switchHeight)/2.f)];
            lineView.layer.borderColor = [UIColor blackColor].CGColor;
            lineView.layer.borderWidth = 0.5f;
            [coverView addSubview:lineView];
            
//            _tableView2Titles = [_SwitchDatasource JMSwitchView:self TitlesForSecondTableViewWithIndexButton:index FirstTableViewCell:0];
            UITableView *tableView2 = [self createTableView];
            tableView2.tag = tableView2Tag+1000*(index+1);
            tableView2.frame = CGRectMake(self.frame.size.width/2.f+0.5, 0, self.frame.size.width/2.f-0.5, (self.frame.size.height-_switchHeight)/2.f);
            [coverView addSubview:tableView2];
            
            [_selectedRow setObject:@"0" forKey:[NSString stringWithFormat:@"%d",index]];
            
        }else {
            
            if ([_SwitchDatasource respondsToSelector:@selector(JMSwitchView:ViewAtIndex:)]) {
                coverView = [_SwitchDatasource JMSwitchView:self ViewAtIndex:index];
            }else {
                coverView = [[UIView alloc]init];
            }
        }
    }else {
        if ([_SwitchDatasource respondsToSelector:@selector(JMSwitchView:ViewAtIndex:)]) {
            coverView = [_SwitchDatasource JMSwitchView:self ViewAtIndex:index];
        }else {
            coverView = [[UIView alloc]init];
        }
    }
    
    if (index <_coverArray.count) {
        [_coverArray[index] addSubview:coverView];
    }

}

- (UITableView *)createTableView {
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableview setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    tableview.scrollEnabled = YES;
    tableview.userInteractionEnabled = YES;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.bounces = NO;
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableview setTableFooterView:view];
    return tableview;
}

// 获取内容视图的高度
- (float)getViewHeight {
    return _viewHeight;
}

// 收回cover
- (void)tapCover {
    UIView *cover = [self coverAtIndex:_selextedIndex];
    _selextedIndex = -1;
    [UIView animateWithDuration:0.2 animations:^{
        cover.frame = CGRectMake(0, _switchHeight, self.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self sendSubviewToBack:cover];
    }];
}

// 获取cover
- (UIView *)coverAtIndex:(NSUInteger)index {
    if (index < _coverArray.count) {
        return _coverArray[index];
    }
    return nil;
}

// 获取button
- (UIButton *)buttonAtIndex:(NSUInteger)index {
    if (index < _btnArray.count) {
        return _btnArray[index];
    }
    return nil;
}

#pragma mark - gseture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    return NO;
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (int)((scrollView.contentOffset.x+self.frame.size.width/2.f)/self.frame.size.width);
    float slideX = CGRectGetMinX(_slideAnimationView.frame)-5;
    float buttonWidth = self.frame.size.width/_buttonTitles.count;
    if (index != (int)slideX/buttonWidth) {
        [UIView animateWithDuration:0.2 animations:^{
            _slideAnimationView.frame = CGRectMake(index*buttonWidth+5, _switchHeight-6, buttonWidth-10, 5);
        } completion:nil];
    }
}

#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag%10 == tableView1Tag) {
        return [self.SwitchDatasource JMSwitchView:self TitlesForFirstTableViewWithIndexButton:(int)(tableView.tag/1000)-1].count;
    }else if (tableView.tag%10 == tableView2Tag) {
        NSString *string = [_selectedRow valueForKey:[NSString stringWithFormat:@"%d",(int)(tableView.tag/1000)-1]];
        return [self.SwitchDatasource JMSwitchView:self TitlesForSecondTableViewWithIndexButton:(int)(tableView.tag/1000)-1 FirstTableViewCell:string.intValue].count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag%10 == tableView1Tag) {
        
        static NSString *SwitchTableView1ID = @"SwitchTableView1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchTableView1ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SwitchTableView1ID];
        }
        cell.textLabel.text = [self.SwitchDatasource JMSwitchView:self TitlesForFirstTableViewWithIndexButton:(int)(tableView.tag/1000)-1][indexPath.row];
        
        return cell;
        
    }else if (tableView.tag%10 == tableView2Tag){
        static NSString *SwitchTableView2ID = @"SwitchTableView2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchTableView2ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SwitchTableView2ID];
        }
        NSString *string = [_selectedRow valueForKey:[NSString stringWithFormat:@"%d",(int)(tableView.tag/1000)-1]];
        NSArray *titles = [self.SwitchDatasource JMSwitchView:self TitlesForSecondTableViewWithIndexButton:(int)(tableView.tag/1000)-1 FirstTableViewCell:string.intValue];
        cell.textLabel.text = titles[indexPath.row];
        
        return cell;
    }
    
    return nil;
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag%10 == tableView1Tag) {
        
        if ([self.SwitchDatasource JMSwitchView:self StyleForViewWithIndexButton:_selextedIndex]==JMSwitchViewContentStyleOneTableview) {
            
            UIButton *button = [self buttonAtIndex:_selextedIndex];
            [button setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forState:UIControlStateNormal];
            [self tapCover];
            if (self.SwitchDelegate && [self.SwitchDelegate respondsToSelector:@selector(JMSwitchView:didSelectRowAtIndexPath:)]) {
                [self.SwitchDelegate JMSwitchView:self didSelectRowAtIndexPath:indexPath];
            }
        }else {
            [_selectedRow setObject:[NSString stringWithFormat:@"%d",indexPath.row] forKey:[NSString stringWithFormat:@"%d",(int)(tableView.tag/1000)-1]];
            UITableView *tableview2 = (UITableView *)[tableView.superview viewWithTag:tableView.tag+1];
            [tableview2 reloadData];
        }
        
    }else if (tableView.tag%10 == tableView2Tag){
        
        UIButton *button = [self buttonAtIndex:_selextedIndex];
        [button setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text forState:UIControlStateNormal];
        [self tapCover];
        if (self.SwitchDelegate && [self.SwitchDelegate respondsToSelector:@selector(JMSwitchView:didSelectRowAtIndexPath:)]) {
            [self.SwitchDelegate JMSwitchView:self didSelectRowAtIndexPath:indexPath];
        }
    }
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



















