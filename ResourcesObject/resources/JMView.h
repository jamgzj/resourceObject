//
//  JMView.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/8/3.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//  按钮选择控件

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JMSwitchViewStyleHorizontal,//横向切换
    JMSwitchViewStyleVertical,  //垂直筛选
} JMSwitchViewStyle;

typedef enum : NSUInteger {
    JMSwitchViewContentStyleCustom,                    //自定义tableview
    JMSwitchViewContentStyleOneTableview,              //单个tableview
    JMSwitchViewContentStyleTwoTableview,              //嵌套tableview
} JMSwitchViewContentStyle;



@class JMView;



@protocol JMSwitchViewDatasource <NSObject>


@required

/**
 *  button的title、数量
 *
 *  @param jmView <#jmView description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)titlesOfButtonsInJMView:(JMView *)jmView;

@optional

/**
 *  每个button的样式
 *
 *  @param jmSwitchView <#jmSwitchView description#>
 *  @param index        <#index description#>
 *
 *  @return <#return value description#>
 */
- (UIButton *)JMSwitchView:(JMView *)jmSwitchView ButtonAtIndex:(NSUInteger)index;

/**
 *  每个button对应view的样式
 *
 *  @param jmSwitchView <#jmSwitchView description#>
 *  @param index        <#index description#>
 *
 *  @return <#return value description#>
 */
- (UIView *)JMSwitchView:(JMView *)jmSwitchView ViewAtIndex:(NSUInteger)index;


#pragma mark - JMSwitchViewStyleVertical下的代理方法

/**
 *  每个btn下的view的样式
 *
 *  @param jmSwitchView <#jmSwitchView description#>
 *  @param index        <#index description#>
 *
 *  @return <#return value description#>
 */
- (JMSwitchViewContentStyle)JMSwitchView:(JMView *)jmSwitchView StyleForViewWithIndexButton:(NSUInteger)index;

/**
 *  第一个tableview的标题
 *
 *  @param jmSwitchView <#jmSwitchView description#>
 *  @param index        <#index description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)JMSwitchView:(JMView *)jmSwitchView TitlesForFirstTableViewWithIndexButton:(NSUInteger)index;

/**
 *  第二个tableview的标题（关联第一个tableview）
 *
 *  @param jmSwitchView <#jmSwitchView description#>
 *  @param index        button位置
 *  @param indexRow     第一个tableview选择的row
 *
 *  @return <#return value description#>
 */
- (NSArray *)JMSwitchView:(JMView *)jmSwitchView TitlesForSecondTableViewWithIndexButton:(NSUInteger)index FirstTableViewCell:(NSUInteger)indexRow;

@end




@protocol JMSwitchViewDelegate <NSObject>

@optional

- (void)JMSwitchView:(JMView *)jmSwitchView didSelectButtonAtIndex:(NSUInteger)index;

/**
 *  点击tableview筛选后的事件
 *
 *  @param jmSwitchView <#jmSwitchView description#>
 *  @param indexPath    <#indexPath description#>
 */
- (void)JMSwitchView:(JMView *)jmSwitchView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end




@interface JMView : UIView

@property (weak, nonatomic)id<JMSwitchViewDatasource>SwitchDatasource;
@property (weak, nonatomic)id<JMSwitchViewDelegate>SwitchDelegate;

/**
 *  初始化选择界面
 *
 *  @param frame        选择界面的大小
 *  @param switchHeight 选择按钮的高度
 *  @param style        选择内容显示样式(水平平移,垂直筛选)
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame SwitchHeight:(float)switchHeight Style:(JMSwitchViewStyle)style;

/**
 *  获取内容视图的高度
 *
 *  @return <#return value description#>
 */
- (float)getViewHeight;

/**
 *  得到在第index个的按钮
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
- (UIButton *)buttonAtIndex:(NSUInteger)index;

/**
 *  垂直筛选收回cover界面
 */
- (void)tapCover;










@end















