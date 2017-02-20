//
//  JMTool.h
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/22.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "JMScrollView.h"
#import "JMAlertView.h"
#import "PopoverView.h"
#import "JMView.h"
#import "JMNavView.h"
#import "Header.h"
#import "MBProgressHUD+NJ.h"
#import "UINavigationBar+CustomHeight.h"
#import "UserInfo.h"
#import "TextLimit.h"
#import "JMHttp.h"
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

@interface JMTool : NSObject

/**
 *  是否登陆
 *
 *  @return <#return value description#>
 */
+ (BOOL)isLogin;

/**
 *  判断网络请求返回值
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isHttpRequestStatusOK:(NSDictionary *)dict;

/**
 *  监测网络状态
 */
+ (void)checkNetStatus;

/**
 *  清除多余cell分割线
 *
 *  @param _tableView
 */
+ (void)setExtraCellLineHidden: (UITableView *)_tableView;

/**
 *  label首行缩进
 *
 *  @param label <#label description#>
 *  @param width <#width description#>
 */
+ (void)resetLabel:(UILabel *)label ContentOffsetX:(float)width;

/**
 *  获取文本size
 *
 *  @param string  <#string description#>
 *  @param font    <#font description#>
 *  @param maxSize <#maxSize description#>
 *
 *  @return <#return value description#>
 */
+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  获取文本高度
 *
 *  @param content 文本内容
 *  @param font    字体（name、size）
 *  @param width   文本宽度
 *
 *  @return 高度
 */
+ (CGFloat)heightOfContent:(NSString *)content Font:(UIFont *)font WithWidth:(CGFloat)width;

#pragma mark - NSUserdefault 存储

/**
 *  写入本地
 *
 *  @param str
 *  @param key
 */
+ (void)setObject:(id)object ForKey:(NSString *)key;

/**
 *  取出信息
 *
 *  @param key
 *
 *  @return 
 */
+ (id)getObjectForKey:(NSString *)key;

/**
 *  清空Userdefault
 */
+ (void)removeAllNSUserdefaultObject;

#pragma mark - NSKeyedArchiver 归档

/**
 *  存储数据
 *
 *  @param object <#object description#>
 *  @param key    <#key description#>
 */
+ (void)archiveObject:(id)object ForKey:(NSString *)key;

/**
 *  取出数据
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
+ (id)archiveObjectForKey:(NSString *)key;

#pragma mark - 清理url cookies

/**
 *  清除某个url的所有cookies
 *
 *  @param url <#url description#>
 */
+ (void)clearCookiesForURL:(NSURL *)url;

/**
 *  清除某个url的某个cookie
 *
 *  @param name <#name description#>
 *  @param url  <#url description#>
 */
+ (void)clearCookieWithCookieName:(NSString *)name ForURL:(NSURL *)url;

/**
 *  清理某个url缓存
 *
 *  @param url <#url description#>
 */
+ (void)removeCacheForURL:(NSURL *)url;

/**
 *  清空所有缓存
 */
+ (void)removeAllCachedResponses;

#pragma mark - MD5加密

/**
 *  MD5加密（小写）
 *
 *  @param sourceString <#sourceString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)md5String:(NSString *)sourceString;

/**
 *  MD5加密（大写）
 *
 *  @param sourceString <#sourceString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)MD5String:(NSString *)sourceString;

#pragma mark - base64 编码

/**
 *  base64编码data
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)base64EncodedStringWithData:(NSData *)data;

/**
 *  base64编码string
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)base64EncodedStringWithString:(NSString *)str;

#pragma mark - base64 解码

/**
 *  base64解码data
 *
 *  @param base64EncodedString <#base64EncodedString description#>
 *
 *  @return <#return value description#>
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 *  base64解码string
 *
 *  @param base64EncodedString <#base64EncodedString description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 *  转换成jsonstring
 *
 *  @param object <#object description#>
 *
 *  @return return value description
 */
+ (NSString *)transformToJsonString:(id)object;

#pragma mark - 汉字转拼音

/**
 *  汉字转拼音
 *
 *  @param chineseString 汉字
 *
 *  @return 拼音
 */
+ (NSString *)transformToPinyin:(NSString *)chineseString;

/**
 *  将字符串数组按照元素首字母顺序进行排序分组
 *
 *  @param array <#array description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array;

#pragma mark - 正则表达式判断

/**
 *  正则表达式判断
 *
 *  @param string      string
 *  @param judgeString 正则表达式
 *
 *  @return BOOL
 */
+ (BOOL)isStringLegal:(NSString *)string
        ByJudgeString:(NSString *)judgeString;

/*
   1.验证用户名和密码：                                         ”^[a-zA-Z]\w{5,15}$”

　　2.验证电话号码：                                            ”^(\\d{3,4}-)\\d{7,8}$”     //eg：021-68686868  0511-6868686；

　　3.验证手机号码：                                            ”^1[3|4|5|7|8][0-9]\\d{8}$”；

　　4.验证身份证号（15位或18位数字）：                             ”\\d{14}[[0-9],0-9xX]”；

　　5.验证Email地址：                                           “^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$”

　　6.只能输入由数字和26个英文字母组成的字符串：
                                      
                                                              “^[A-Za-z0-9]+$”

　　7.整数或者小数：                                             “^[0-9]+([.]{0,1}[0-9]+){0,1}$”

　　8.只能输入数字：                                             ”^[0-9]*$”。

　　9.只能输入n位的数字：                                        ”^\\d{n}$”。

　　10.只能输入至少n位的数字：                                    ”^\\d{n,}$”。

　　11.只能输入m~n位的数字：                                     ”^\\d{m,n}$”。

　　12.只能输入零和非零开头的数字：                                ”^(0|[1-9][0-9]*)$”。

　　13.只能输入有两位小数的正实数：                                ”^[0-9]+(.[0-9]{2})?$”。

　　14.只能输入有1~3位小数的正实数：                               ”^[0-9]+(\.[0-9]{1,3})?$”。

　　15.只能输入非零的正整数：                                     ”^\+?[1-9][0-9]*$”。

　　16.只能输入非零的负整数：                                     ”^\-[1-9][]0-9″*$。

　　17.只能输入长度为3的字符：                                    ”^.{3}$”。

　　18.只能输入由26个英文字母组成的字符串：                         ”^[A-Za-z]+$”。

　　19.只能输入由26个大写英文字母组成的字符串：                      ”^[A-Z]+$”。

　　20.只能输入由26个小写英文字母组成的字符串：                      ”^[a-z]+$”。

　　21.验证是否含有^%&’,;=?$\”等字符：                            ”[^%&',;=?$\x22]+”。
    
　　22.只能输入汉字：                                            ”^[\u4e00-\u9fa5]{0,}$”。

　　23.验证URL：                                               ”^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$”。

　　24.验证一年的12个月：                                        ”^(0?[1-9]|1[0-2])$”正确格式为：”01″～”09″和”10″～”12″。

　　25.验证一个月的31天：                                        ”^((0?[1-9])|((1|2)[0-9])|30|31)$”    
                
                                                                //正确格式为；”01″～”09″、”10″～”29″和“30”~“31”。

　　26.获取日期正则表达式：                                       \\d{4}[年|\-|\.]\\d{\1-\12}[月|\-|\.]\\d{\1-\31}日?

　　                                              评注：可用来匹配大多数年月日信息。

　　27.匹配双字节字符(包括汉字在内)：                               [^\x00-\xff]

　　                                              评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）

　　28.匹配空白行的正则表达式：                                    \n\s*\r

　　                                              评注：可以用来删除空白行

　　29.匹配HTML标记的正则表达式：                                  <(\S*?)[^>]*>.*?</>|<.*? />

　　                                              评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力

　　30.匹配首尾空白字符的正则表达式：                                ^\s*|\s*$

　　                                              评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式

　　31.匹配网址URL的正则表达式：                                   [a-zA-z]+://[^\s]*

　　                                              评注：网上流传的版本功能很有限，上面这个基本可以满足需求

　　32.匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：    ^[a-zA-Z][a-zA-Z0-9_]{4,15}$

　　                                              评注：表单验证时很实用

　　33.匹配腾讯QQ号：                                             [1-9][0-9]\{4,\}

　　                                              评注：腾讯QQ号从10 000 开始

　　34.匹配中国邮政编码：                                          [1-9]\\d{5}(?!\d)

　　                                              评注：中国邮政编码为6位数字

　　35.匹配ip地址：                                ((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)。

    36.匹配空格:                                                ^(\\s|\\n|\\r)*$
 
                                                 评注：可以监测当前字符串是否为纯空格或为空

*/

#pragma mark - 16进制颜色转换

/**
 *  透明度固定为1，以0x开头的十六进制转换成的颜色
 *
 *  @param hexColor 以0x开头的十六进制
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHex:(long)hexColor;

/**
 *  0x开头的十六进制转换成的颜色,透明度可调整
 *
 *  @param hexColor 以0x开头的十六进制
 *  @param opacity  <#opacity description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

/**
 *  iOS中十六进制的颜色（以#开头）转换为UIColor
 *
 *  @param color 十六进制的颜色（以#开头）
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

#pragma mark - 设置view背景渐变色

/**
 *  设置view背景渐变色(水平方向变色)
 *
 *  @param view   view
 *  @param color1 第一个颜色
 *  @param color2 第二个颜色
 */
+ (void)setBackhroundColorGradualHorizontallyForView:(UIView *)view
                                              Color1:(UIColor *)color1
                                              Color2:(UIColor *)color2;

/**
 *  设置view背景渐变色(垂直方向变色)
 *
 *  @param view   view
 *  @param color1 第一个颜色
 *  @param color2 第二个颜色
 */
+ (void)setBackhroundColorGradualVerticallyForView:(UIView *)view
                                            Color1:(UIColor *)color1
                                            Color2:(UIColor *)color2;
/**
 *  设置view背景渐变色
 *
 *  @param view       view
 *  @param frame      设置渐变色背景区域
 *  @param color1     color1
 *  @param color2     color2
 *  @param startPoint 起始点(决定渐变方向)
 *  @param endPoint   终止点(决定渐变方向)
 *  @param float1     color1开始渐变处
 *  @param float2     color2开始渐变处
 */
+ (void)setBackhroundColorGradualForView:(UIView *)view
                               WithFrame:(CGRect)frame
                                  Color1:(UIColor *)color1
                                  Color2:(UIColor *)color2
                              StartPoint:(CGPoint)startPoint
                                EndPoint:(CGPoint)endPoint
                          ChangeLocation:(float)float1
                         ChangeLocation2:(float)float2;

#pragma mark - 裁剪图片

/**
 *  生成一张纯色图片
 *
 *  @param color  颜色
 *  @param width  宽度
 *  @param height 高度
 *
 *  @return 返回图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color
                            Width:(CGFloat)width
                           Height:(CGFloat)height;

/**
 *  截取view生成图片
 */
+ (UIImage *)showWithView:(UIView *)view;

/**
 *  截取view 中某个区域生成一张图片
 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

/**
 *  裁剪图片
 *
 *  @param originalImage 原生图片
 *  @param size          裁剪后的size
 *
 *  @return 裁剪后的图片
 */
+ (UIImage *)handleImage:(UIImage *)originalImage
                withSize:(CGSize)size;

/**
 *  获取网络图片的尺寸(调用此方法请建立线程，不然可能会阻塞主线程)
 *
 *  @param imageURL 网络图片(URL/URL string)
 *
 *  @return 尺寸大小
 */
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

#pragma mark - 对图片进行滤镜处理

// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono

// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade

// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess

// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome

// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField

+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name;

#pragma mark - 对图片进行模糊处理

// CIGaussianBlur ---> 高斯模糊

// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)

// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)

// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)

// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)

+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius;

/**
 
 *  调整图片饱和度, 亮度, 对比度
 
 *
 
 *  @param image      目标图片
 
 *  @param saturation 饱和度
 
 *  @param brightness 亮度: -1.0 ~ 1.0
 
 *  @param contrast   对比度
 
 *
 
 */

+ (UIImage *)colorControlsWithOriginalImage:(UIImage *)image

                                 saturation:(CGFloat)saturation

                                 brightness:(CGFloat)brightness

                                   contrast:(CGFloat)contrast;

#pragma mark - 动画

/**
 *  加入购物车动画
 *
 *  @param view1     <#view1 description#>
 *  @param view2     <#view2 description#>
 *  @param superView <#superView description#>
 *  @param image     <#image description#>
 *  @param delegate  <#delegate description#>
 *  @param block     <#block description#>
 */
+ (void)addShoppingAnimationFromView:(UIView *)view1
                              ToView:(UIView *)view2
                       WithSuperView:(UIView *)superView
                            AndImage:(UIImage *)image
                            delagate:(id)delegate;

/**
 *  晃动动画
 *
 *  @param view <#view description#>
 */
+ (void)addShakeAnimation:(UIView *)view;

/**
 *  对价格进行处理获得真实价格
 *
 *  @param price <#price description#>
 *
 *  @return <#return value description#>
 */
+ (float)getRealPriceWithPrice:(float)price;

@end

@interface UIButton (JM)

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

+ (UIButton *)buttonWithTitle:(NSString *)title
                        Image:(UIImage *)image
                         Font:(UIFont *)font
                   TitleColor:(UIColor *)color
                     Delegate:(id)delegate
                       Action:(SEL)action;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

@interface UILabel (JM)

/**
 *  自定义Label初始化
 *
 *  @param text
 *  @param font
 *  @param color
 *
 *  @return Label
 */
+ (UILabel *)labelWithText:(NSString *)text
                      Font:(UIFont *)font
                 textColor:(UIColor *)color;

/**
 *  计算纯文字label高度(注意设置lineBreakMode属性)
 *
 *  @param width 当前label宽度
 *
 *  @return <#return value description#>
 */
- (CGFloat)heightOfContentWithWidth:(CGFloat)width;

@end

@interface UITextField (JM)

/**
 *  textfield初始化
 *
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param isSecure     <#isSecure description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                          SecureTextEntry:(BOOL)isSecure
                                 Delegate:(id)delegate;

/**
 *  textfield初始化
 *
 *  @param frame        <#frame description#>
 *  @param placeholder  <#placeholder description#>
 *  @param keyboardType <#keyboardType description#>
 *  @param isSecure     <#isSecure description#>
 *  @param delegate     <#delegate description#>
 *
 *  @return <#return value description#>
 */
+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                    SecureTextEntry:(BOOL)isSecure
                           Delegate:(id)delegate;


@end

@interface UIView (ExtensionUIView)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;

@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat bottom;

@property (nonatomic, copy) NSString *badgeValue;
@property (strong,nonatomic)UILabel *badgeView;

/**
 *  添加view四周的阴影
 *
 *  @param cornerRadius <#cornerRadius description#>
 */
- (void)addShadowAroundWithCornerRadius:(float)cornerRadius;

- (void)removeBadge;

@end









