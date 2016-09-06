//
//  JMTool.m
//  ResourcesObject
//
//  Created by zhengxingxia on 16/6/22.
//  Copyright © 2016年 zhengxingxia. All rights reserved.
//

#import "JMTool.h"
#import <CommonCrypto/CommonDigest.h>

static const char base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
};

@implementation JMTool

+ (BOOL)isHttpRequestStatusOK:(NSDictionary *)dict {
    if ([dict[@"status"] integerValue] == 200) {
        return YES;
    }else {
        return NO;
    }
}

// 监测网络
+ (void)checkNetStatus
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];//打开监测
    
    //监测网络状态回调
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown://未知
            {
                
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable://无连接
            {
                //基本上监测到无连接 给出友好提示就够了
                [MBProgressHUD showError:@"当前无网络"];
                [self setObject:@YES ForKey:IS_NETCONNECT_LOST];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN://3G
            {
                if ([self getObjectForKey:IS_NETCONNECT_LOST] && [[self getObjectForKey:IS_NETCONNECT_LOST] boolValue]) {
                    [self setObject:@NO ForKey:IS_NETCONNECT_LOST];
                    [[NSNotificationCenter defaultCenter]postNotificationName:REFRESH_UI object:nil userInfo:nil];
                }
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi
            {
                if ([self getObjectForKey:IS_NETCONNECT_LOST] && [[self getObjectForKey:IS_NETCONNECT_LOST] boolValue]) {
                    [self setObject:@NO ForKey:IS_NETCONNECT_LOST];
                    [[NSNotificationCenter defaultCenter]postNotificationName:REFRESH_UI object:nil userInfo:nil];
                }
            }
                break;
                
            default:
                
                break;
        }
    }];
    
}


// 清除UITableView底部多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)_tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
}

+ (CGFloat)heightOfContent:(NSString *)content Font:(UIFont *)font WithWidth:(CGFloat)width {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:attributes
                                                 context:nil].size;
    return contentSize.height;
}

#pragma mark - NSUserdefault

// 将信息写入本地
+ (void)setObject:(id)object ForKey:(NSString *)key {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
}

+ (id)getObjectForKey:(NSString *)key {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)removeAllNSUserdefaultObject {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

#pragma mark - md5

+ (NSString *)md5String:(NSString *)sourceString {
    if(!sourceString){
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02x",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    //打印最终需要的字符
    NSLog(@"resultString----->%@",resultString);
    return resultString;
}

+ (NSString *)MD5String:(NSString *)sourceString {
    if(!sourceString){
        return nil;//判断sourceString如果为空则直接返回nil。
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = sourceString.UTF8String;
    //创建一个C语言的字符数组，用来接收加密结束之后的字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    //MD5计算（也就是加密）
    //第一个参数：需要加密的字符串
    //第二个参数：需要加密的字符串的长度
    //第三个参数：加密完成之后的字符串存储的地方
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    //将加密完成的字符拼接起来使用（16进制的）。
    //声明一个可变字符串类型，用来拼接转换好的字符
    NSMutableString *resultString = [[NSMutableString alloc]init];
    //遍历所有的result数组，取出所有的字符来拼接
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02X",result[i]];
        //%02x：x 表示以十六进制形式输出，02 表示不足两位，前面补0输出；超出两位，不影响。当x小写的时候，返回的密文中的字母就是小写的，当X大写的时候返回的密文中的字母是大写的。
    }
    //打印最终需要的字符
    NSLog(@"resultString----->%@",resultString);
    return resultString;
}

#pragma mark - base64

// 编码

+ (NSString *)base64EncodedStringWithData:(NSData *)data {
    NSUInteger length = data.length;
    if (length == 0)
        return @"";
    
    NSUInteger out_length = ((length + 2) / 3) * 4;
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL)
        return nil;
    
    const char *input = data.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i += 3) {
        value = 0;
        for (NSInteger j = i; j < i + 3; j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length)
        ? base64EncodingTable[(value >> 6) & 0x3F]
        : '=';
        output[index + 3] = ((i + 2) < length)
        ? base64EncodingTable[(value >> 0) & 0x3F]
        : '=';
    }
    
    NSString *base64 = [[NSString alloc] initWithBytes:output length:out_length encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}

+ (NSString *)base64EncodedStringWithString:(NSString *)str {
    NSData *data = [JMTool getDataFromString:str];
    return [JMTool base64EncodedStringWithData:data];
}

// 解码

+ (NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString {
    NSInteger length = base64EncodedString.length;
    const char *string = [base64EncodedString cStringUsingEncoding:NSASCIIStringEncoding];
    if (string  == NULL)
        return nil;
    
    while (length > 0 && string[length - 1] == '=')
        length--;
    
    NSInteger outputLength = length * 3 / 4;
    NSMutableData *data = [NSMutableData dataWithLength:outputLength];
    if (data == nil)
        return nil;
    if (length == 0)
        return data;
    
    uint8_t *output = data.mutableBytes;
    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < length) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < length ? string[inputPoint++] : 'A';
        char i3 = inputPoint < length ? string[inputPoint++] : 'A';
        
        output[outputPoint++] = (base64DecodingTable[i0] << 2)
        | (base64DecodingTable[i1] >> 4);
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i1] & 0xf) << 4)
            | (base64DecodingTable[i2] >> 2);
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = ((base64DecodingTable[i2] & 0x3) << 6)
            | base64DecodingTable[i3];
        }
    }
    
    return data;
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [JMTool dataWithBase64EncodedString:base64EncodedString];
    return [JMTool getNTF8StringFromData:data];
}

+ (NSString *)getNTF8StringFromData:(NSData *)data {
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)getDataFromString:(NSString *)string {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 汉字转拼音

//+ (NSString *)transformToPinyin:(NSString *)chineseString {
//    NSMutableString *mutableString = [NSMutableString stringWithString:chineseString];
//    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
//    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
//    return mutableString;
//}

+ (NSString *)transformToPinyin:(NSString *)chineseString {
    
    NSMutableString *mutableString = [NSMutableString stringWithString:chineseString];
    
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    
    return mutableString;
}

//获取字符串(或汉字)首字母

+ (NSString *)firstCharacterWithString:(NSString *)string{
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *pingyin = [str capitalizedString];
    
    return [pingyin substringToIndex:1];
    
}


//将字符串数组按照元素首字母顺序进行排序分组

+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array{
    
    if (array.count == 0) {
        
        return nil;
        
    }
    
    for (id obj in array) {
        
        if (![obj isKindOfClass:[NSString class]]) {
            
            return nil;
            
        }
        
    }
    
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    
    //创建27个分组数组
    
    for (int i = 0; i < indexedCollation.sectionTitles.count; i++) {
        
        NSMutableArray *obj = [NSMutableArray array];
        
        [objects addObject:obj];
        
    }
    
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    
    //按字母顺序进行分组
    
    NSInteger lastIndex = -1;
    
    for (int i = 0; i < array.count; i++) {
        
        NSInteger index = [indexedCollation sectionForObject:array[i] collationStringSelector:@selector(uppercaseString)];
        
        [[objects objectAtIndex:index] addObject:array[i]];
        
        lastIndex = index;
        
    }
    
    //去掉空数组
    
    for (int i = 0; i < objects.count; i++) {
        
        NSMutableArray *obj = objects[i];
        
        if (obj.count == 0) {
            
            [objects removeObject:obj];
            
        }
        
    }
    
    //获取索引字母
    
    for (NSMutableArray *obj in objects) {
        
        NSString *str = obj[0];
        
        NSString *key = [self firstCharacterWithString:str];
        
        [keys addObject:key];
        
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:objects forKey:keys];
    
    return dic;
    
}

#pragma mark - 正则判断条件

+ (BOOL)isStringLegal:(NSString *)string ByJudgeString:(NSString *)judgeString {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeString];
    
    if ([predicate evaluateWithObject:string] == YES) {
        //implement
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 设置view背景渐变色

+ (void)setBackhroundColorGradualHorizontallyForView:(UIView *)view
                                              Color1:(UIColor *)color1
                                              Color2:(UIColor *)color2 {
    [self setBackhroundColorGradualForView:view WithFrame:view.bounds Color1:color1 Color2:color2 StartPoint:CGPointMake(0, 0) EndPoint:CGPointMake(1, 0) ChangeLocation:0.1 ChangeLocation2:0.9];
}

+ (void)setBackhroundColorGradualVerticallyForView:(UIView *)view
                                            Color1:(UIColor *)color1
                                            Color2:(UIColor *)color2 {
    [self setBackhroundColorGradualForView:view WithFrame:view.bounds Color1:color1 Color2:color2 StartPoint:CGPointMake(0, 0) EndPoint:CGPointMake(0, 1) ChangeLocation:0.1 ChangeLocation2:0.9];
}

+ (void)setBackhroundColorGradualForView:(UIView *)view
                               WithFrame:(CGRect)frame
                                  Color1:(UIColor *)color1
                                  Color2:(UIColor *)color2
                              StartPoint:(CGPoint)startPoint
                                EndPoint:(CGPoint)endPoint
                          ChangeLocation:(float)float1
                         ChangeLocation2:(float)float2 {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    [view.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)color1.CGColor,(__bridge id)color2.CGColor];
    gradientLayer.locations = @[@(float1),@(float2)];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
}

#pragma mark - 裁剪图片

+ (UIImage *)createImageWithColor:(UIColor *)color
                            Width:(CGFloat)width
                           Height:(CGFloat)height
{
    CGRect rect=CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  截取view生成图片
 */
+ (UIImage *)showWithView:(UIView *)view {
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 *  截取view 中某个区域生成一张图片
 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self showWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.width);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, rect, imageRef);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return image;
}

+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size {
    
    CGSize originalsize = [originalImage size];
    NSLog(@"改变前图片的宽度为%f,图片的高度为%f",originalsize.width,originalsize.height);
    
    //原图长宽均小于标准长宽的，不作处理返回原图
    if (originalsize.width<size.width && originalsize.height<size.height)
    {
        return originalImage;
    }
    
    //原图长宽均大于标准长宽的，按比例缩小至最大适应值
    else if(originalsize.width>size.width && originalsize.height>size.height)
    {
        CGFloat rate = 1.0;
        CGFloat widthRate = originalsize.width/size.width;
        CGFloat heightRate = originalsize.height/size.height;
        
        rate = widthRate>heightRate?heightRate:widthRate;
        
        CGImageRef imageRef = nil;
        
        if (heightRate>widthRate)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height*rate/2, originalsize.width, size.height*rate));//获取图片整体部分
        }
        else
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width*rate/2, 0, size.width*rate, originalsize.height));//获取图片整体部分
        }
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图长宽有一项大于标准长宽的，对大于标准的那一项进行裁剪，另一项保持不变
    else if(originalsize.height>size.height || originalsize.width>size.width)
    {
        CGImageRef imageRef = nil;
        
        if(originalsize.height>size.height)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(0, originalsize.height/2-size.height/2, originalsize.width, size.height));//获取图片整体部分
        }
        else if (originalsize.width>size.width)
        {
            imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectMake(originalsize.width/2-size.width/2, 0, size.width, originalsize.height));//获取图片整体部分
        }
        
        UIGraphicsBeginImageContext(size);//指定要绘画图片的大小
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(con, 0.0, size.height);
        CGContextScaleCTM(con, 1.0, -1.0);
        
        CGContextDrawImage(con, CGRectMake(0, 0, size.width, size.height), imageRef);
        
        UIImage *standardImage = UIGraphicsGetImageFromCurrentImageContext();
        NSLog(@"改变后图片的宽度为%f,图片的高度为%f",[standardImage size].width,[standardImage size].height);
        
        UIGraphicsEndImageContext();
        CGImageRelease(imageRef);
        
        return standardImage;
    }
    
    //原图为标准长宽的，不做处理
    else
    {
        return originalImage;
    }
}

// 获取网络图片尺寸
+ (CGSize)downloadImageSizeWithURL:(id)imageURL {
    
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
#ifdef dispatch_main_sync_safe
    if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString]) {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if (!image) {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if (image) {
            return image.size;
        }
    }
#endif
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if ([pathExtendsion isEqualToString:@"png"]) {
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"]) {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else {
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if (image) {
            
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}

// 当网络图片是PNG格式时
+ (CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if (data.length == 8) {
        
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

// 当网络图片是GIF格式时
+ (CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data.length == 4) {
        
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

// 当网络图片是JPG格式时
+ (CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

#pragma mark - 对图片进行滤镜处理

// 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono

// 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade

// 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess

// 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome

// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField

+ (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *filter = [CIFilter filterWithName:name];
    
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return resultImage;
    
}

#pragma mark - 对图片进行模糊处理

// CIGaussianBlur ---> 高斯模糊

// CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)

// CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)

// CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)

// CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)

+ (UIImage *)blurWithOriginalImage:(UIImage *)image blurName:(NSString *)name radius:(NSInteger)radius{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *filter;
    
    if (name.length != 0) {
        
        filter = [CIFilter filterWithName:name];
        
        [filter setValue:inputImage forKey:kCIInputImageKey];
        
        if (![name isEqualToString:@"CIMedianFilter"]) {
            
            [filter setValue:@(radius) forKey:@"inputRadius"];
            
        }
        
        CIImage *result = [filter valueForKey:kCIOutputImageKey];
        
        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
        
        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
        
        CGImageRelease(cgImage);
        
        return resultImage;
        
    }else{
        
        return nil;
        
    }
    
}


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

                                   contrast:(CGFloat)contrast{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    
    
    [filter setValue:@(saturation) forKey:@"inputSaturation"];
    
    [filter setValue:@(brightness) forKey:@"inputBrightness"];// 0.0 ~ 1.0
    
    [filter setValue:@(contrast) forKey:@"inputContrast"];
    
    
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    
    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    
    return resultImage;
    
}


//Avilable in iOS 8.0 and later

+ (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame{
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    effectView.frame = frame;
    
    return effectView;
    
}

#pragma mark - 动画

+ (void)addShoppingAnimationFromView:(UIView *)view1
                              ToView:(UIView *)view2
                       WithSuperView:(UIView *)superView
                            AndImage:(UIImage *)image
                            delagate:(id)delegate {
    
    superView.userInteractionEnabled = NO;
    
    CGRect frame1 = [superView convertRect:view1.frame fromView:view1.superview];
    CGRect frame2 = [superView convertRect:view2.frame fromView:view2.superview];
    
    CGPoint point1 = CGPointMake(CGRectGetMidX(frame1), CGRectGetMidY(frame1));
    CGPoint point2 = CGPointMake(CGRectGetMidX(frame2), CGRectGetMidY(frame2));
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:view1.frame];
    imgView.image = image;
    [[UIApplication sharedApplication].keyWindow addSubview:imgView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addQuadCurveToPoint:point2 controlPoint:CGPointMake(point2.x+20, point1.y-20)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.25f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.25f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 0.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.75f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = delegate;
    [imgView.layer addAnimation:groups forKey:@"group"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imgView removeFromSuperview];
        superView.userInteractionEnabled = YES;
    });
}

+ (void)addShakeAnimation:(UIView *)view {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [view.layer addAnimation:shakeAnimation forKey:nil];
}






















@end

















