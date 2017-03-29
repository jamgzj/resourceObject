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

+ (UIViewController *)getCurrentVC {
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

// 清除UITableView底部多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)_tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
}

+ (void)resetLabel:(UILabel *)label ContentOffsetX:(float)width {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    //    paragraphStyle.lineSpacing = 5;  //行自定义行高度
    [paragraphStyle setFirstLineHeadIndent:width + 5];//首行缩进 根据用户昵称宽度在加5个像素
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    [label sizeToFit];
//    CGSize size = [label sizeThatFits:CGSizeZero];
//    NSLog(@"%f,%f",size.width,size.height);
//    label.size = CGSizeMake(size.width, size.height);
}

+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGFloat)heightOfContent:(NSString *)content Font:(UIFont *)font WithWidth:(CGFloat)width {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [paragraphStyle setFirstLineHeadIndent:width + 5];
    
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:attributes
                                                 context:nil].size;
    return contentSize.height;
}

#pragma mark - 清理url cookies

+ (void)clearCookiesForURL:(NSURL *)url {
    if (url) {
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        for (int i = 0; i < [cookies count]; i++) {
            NSHTTPCookie *cookie = (NSHTTPCookie *)[cookies objectAtIndex:i];
            NSLog(@"cookie---->%@",cookie);
            NSLog(@"cookieArray   before------>%@",cookies);
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            NSLog(@"cookieArray   later ------>%@",[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);
        }
    }
}

+ (void)clearCookieWithCookieName:(NSString *)name ForURL:(NSURL *)url {
    if (url) {
        NSArray * cookArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
        
        for (NSHTTPCookie *cookie in cookArray) {
            if ([cookie.name isEqualToString:name]) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
            }
        }
    }
}

+ (void)removeCacheForURL:(NSURL *)url {
    if (url) {
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:url]];
    }
}

+ (void)removeAllCachedResponses {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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

+ (NSString *)transformToJsonString:(id)object {
    
    BOOL isYes = [NSJSONSerialization isValidJSONObject:object];
    NSString *JsonDataStr;
    
    if (isYes) {
        NSLog(@"可以转换");
        
        /* JSON data for obj, or nil if an internal error occurs. The resulting data is a encoded in UTF-8.
         */
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:NULL];
        
        /*
         Writes the bytes in the receiver to the file specified by a given path.
         YES if the operation succeeds, otherwise NO
         */
        // 将JSON数据写成文件
        // 文件添加后缀名: 告诉别人当前文件的类型.
        // 注意: AFN是通过文件类型来确定数据类型的!如果不添加类型,有可能识别不了! 自己最好添加文件类型.
        [jsonData writeToFile:[NSString stringWithFormat:@"/Users/%@.json",[object description]] atomically:YES];
        
        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        JsonDataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        return JsonDataStr;
        
    } else {
        
        NSLog(@"JSON数据生成失败，请检查数据格式");
        
    }
    return nil;
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

#pragma mark - 16进制颜色转换

// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor*)colorWithHex:(long)hexColor {
    return [self colorWithHex:hexColor alpha:1.];
}

// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
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
 *  截取当前屏幕
 *
 *  @return NSData *
 */
+ (NSData *)dataWithScreenshotInPNGFormat {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
+ (UIImage *)imageWithScreenshot {
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
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

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
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
    imgView.layer.cornerRadius = imgView.height/2;
    imgView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:imgView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addQuadCurveToPoint:point2 controlPoint:CGPointMake(point2.x+20, point1.y-20)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.15f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.15f;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 0.3f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.5f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 0.45f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = delegate;
    [imgView.layer addAnimation:groups forKey:@"group"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.45 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [imgView removeFromSuperview];
        superView.userInteractionEnabled = YES;
    });
}

+ (void)addShakeAnimation:(UIView *)view {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.15f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [view.layer addAnimation:shakeAnimation forKey:nil];
}

#pragma mark - 对价格进行处理

+ (float)getRealPriceWithPrice:(float)price {
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",price];
    if ([priceStr floatValue]<price) {
        return [priceStr floatValue]+0.01;
    }
    return [priceStr floatValue];
}

@end





@implementation NSString (JM)

- (NSString *)md5String {
    if(!self){
        return nil;//判断self如果为空则直接返回nil。
    }
    //MD5加密都是通过C级别的函数来计算，所以需要将加密的字符串转换为C语言的字符串
    const char *cString = self.UTF8String;
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

- (NSString *)MD5String {
    if(!self){
        return nil;//判断self如果为空则直接返回nil。
    }
    const char *cString = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    NSMutableString *resultString = [[NSMutableString alloc]init];
    for (int i = 0;i < CC_MD5_DIGEST_LENGTH; i++) {
        [resultString  appendFormat:@"%02X",result[i]];
    }
    NSLog(@"resultString----->%@",resultString);
    return resultString;
}

@end







@implementation UIButton (JM)

+ (UIButton *)buttonWithTitle:(NSString *)title
                        Image:(UIImage *)image
                         Font:(UIFont *)font
                   TitleColor:(UIColor *)color
                     Delegate:(id)delegate
                       Action:(SEL)action {
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = [UIDevice currentDevice].systemVersion.floatValue >= 8.0?self.imageView.intrinsicContentSize.width:self.imageView.frame.size.width;
    CGFloat imageHeight = [UIDevice currentDevice].systemVersion.floatValue >= 8.0?self.imageView.intrinsicContentSize.height:self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


@end





@implementation UILabel (JM)

+ (UILabel *)labelWithText:(NSString *)text
                      Font:(UIFont *)font
                 textColor:(UIColor *)color {
    
    UILabel *label      = [[UILabel alloc]init];
    label.text          = text;
    label.font          = font;
    label.textColor     = color;
    
    return label;
}

- (CGFloat)heightOfContentWithWidth:(CGFloat)width {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize.height;
}

@end





@implementation UITextField (JM)

+ (UITextField *)textfieldWithPlaceholder:(NSString *)placeholder
                             KeyboardType:(UIKeyboardType)keyboardType
                          SecureTextEntry:(BOOL)isSecure
                                 Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.placeholder = placeholder;
    textfield.keyboardType = keyboardType;
    if (isSecure) {
        textfield.secureTextEntry = YES;
        textfield.clearsOnBeginEditing = YES;
    }
    textfield.delegate = delegate;
    return textfield;
}

+ (UITextField *)textfieldWithFrame:(CGRect)frame
                        Placeholder:(NSString *)placeholder
                       KeyboardType:(UIKeyboardType)keyboardType
                    SecureTextEntry:(BOOL)isSecure
                           Delegate:(id)delegate  {
    UITextField *textfield = [[UITextField alloc]initWithFrame:frame];
    textfield.placeholder = placeholder;
    textfield.keyboardType = keyboardType;
    if (isSecure) {
        textfield.secureTextEntry = YES;
        textfield.clearsOnBeginEditing = YES;
    }
    textfield.delegate = delegate;
    return textfield;
}


@end





static const void *badgeViewKey = &badgeViewKey;
static const void *badgeValueKey = &badgeValueKey;

@implementation UIView (ExtensionUIView)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x =x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y =y;
    self.frame = frame;
    
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height =height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size =size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin =origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)left {
    return self.origin.x;
}

- (CGFloat)top {
    return self.origin.y;
}

- (CGFloat)right {
    return self.origin.x + self.width;
}

- (CGFloat)bottom {
    return self.origin.y + self.height;
}

- (NSString *)badgeValue {
    return objc_getAssociatedObject(self, badgeValueKey);
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if (badgeValue) {
        self.badgeView.hidden = NO;
        if ([badgeValue isEqualToString:@"0"]) {
            self.badgeView.hidden = YES;
        }else {
            if (self.badgeView) {
                self.badgeView.text = badgeValue;
            }else {
                self.badgeView = [[UILabel alloc]init];
                self.badgeView.text = badgeValue;
                self.badgeView.font = [UIFont systemFontOfSize:11];
                self.badgeView.textColor = [UIColor whiteColor];
                self.badgeView.textAlignment = NSTextAlignmentCenter;
                self.badgeView.backgroundColor = [UIColor redColor];
                [self addSubview:self.badgeView];
                [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self.mas_right);
                    make.top.mas_equalTo(self.mas_top);
                    if (self.width>self.height) {
                        make.width.height.mas_equalTo(self.mas_height).multipliedBy(0.3);
                    }else {
                        make.width.height.mas_equalTo(self.mas_width).multipliedBy(0.3);
                    }
                }];
                [self setNeedsLayout];
                [self layoutIfNeeded];
                self.badgeView.layer.cornerRadius = self.badgeView.width/2.f;
                self.badgeView.layer.masksToBounds = YES;
            }
        }
    }
    objc_setAssociatedObject(self, badgeValueKey, badgeValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UILabel *)badgeView {
    return objc_getAssociatedObject(self, badgeViewKey);
}

- (void)setBadgeView:(UILabel *)badgeView {
    if (!self.badgeView) {
        objc_setAssociatedObject(self, badgeViewKey, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)removeBadge {
    self.badgeView.hidden = YES;
}

@end









