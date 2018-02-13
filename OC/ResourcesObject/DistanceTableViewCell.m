//
//  DistanceTableViewCell.m
//  ResourcesObject
//
//  Created by CMVIOS1 on 2017/11/16.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import "DistanceTableViewCell.h"
#import "JMTool.h"

@interface DistanceTableViewCell ()<CAAnimationDelegate>

@property (weak,nonatomic)CALayer *animationLayer;
@property (weak,nonatomic)CAShapeLayer *pathLayer;
@property (weak,nonatomic)CAShapeLayer *lineLayer1;
@property (weak,nonatomic)CAShapeLayer *lineLayer2;
@property (weak,nonatomic)CALayer *carLayer;
@property (assign,nonatomic)CGFloat carWidth;

@property (weak,nonatomic)CAShapeLayer *animationLayer1;

@end

@implementation DistanceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImage *carImage = [UIImage imageNamed:@"car"];
        _carWidth = carImage.size.width;
        
        CAShapeLayer *animationLayer1 = [CAShapeLayer layer];
        animationLayer1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40*coefficient);
        animationLayer1.strokeColor = [[UIColor blackColor] CGColor];
        animationLayer1.fillColor = nil;
        animationLayer1.lineWidth = 1.5f*coefficient;
        animationLayer1.lineJoin = kCALineJoinBevel;
        [self.layer addSublayer:animationLayer1];
        self.animationLayer1 = animationLayer1;
        
        CALayer * animationLayer = [CALayer layer];
        animationLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40*coefficient);
        [self.layer addSublayer:animationLayer];
        self.animationLayer = animationLayer;
        
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.frame = CGRectMake(_carWidth+3*coefficient, 0, SCREEN_WIDTH-_carWidth-3*coefficient, 40*coefficient);
        pathLayer.lineWidth = 1.0f;
        pathLayer.lineJoin = kCALineJoinBevel;
        [animationLayer addSublayer:pathLayer];
        self.pathLayer = pathLayer;
        
        CAShapeLayer *lineLayer1 = [CAShapeLayer layer];
        lineLayer1.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40*coefficient);
        lineLayer1.strokeColor = [[UIColor blackColor] CGColor];
        lineLayer1.fillColor = nil;
        lineLayer1.lineWidth = 1.5f*coefficient;
        lineLayer1.lineJoin = kCALineJoinBevel;
        [animationLayer addSublayer:lineLayer1];
        self.lineLayer1 = lineLayer1;
        
        CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
        lineLayer2.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40*coefficient);
        lineLayer2.strokeColor = [[UIColor blackColor] CGColor];
        lineLayer2.fillColor = nil;
        lineLayer2.lineWidth = 1.5f*coefficient;
        lineLayer2.lineJoin = kCALineJoinBevel;
        [animationLayer addSublayer:lineLayer2];
        self.lineLayer2 = lineLayer2;
        
        CALayer *carLayer = [CALayer layer];
        carLayer.contents = (id)carImage.CGImage;
        carLayer.frame = CGRectMake(0.0f, 0.0f, carImage.size.width, carImage.size.height);
        [animationLayer addSublayer:carLayer];
        self.carLayer = carLayer;
    }
    return self;
}

// 从左到右 有文字
- (void)getAnimationLayerToRightWithString:(NSString *)string {
    self.animationLayer.hidden = NO;
    self.animationLayer1.hidden = YES;
    
    self.pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.pathLayer.fillColor = nil;
    
    UIFont *textFont = [UIFont systemFontOfSize:14*coefficient];
    CTFontRef font =CTFontCreateWithName((CFStringRef)textFont.fontName,
                                         textFont.pointSize,
                                         NULL);
    CGMutablePathRef letters = CGPathCreateMutable();

    //这里设置画线的字体和大小
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    // for each RUN
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

        // for each GLYPH in run
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);

            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];

    CGPathRelease(letters);
    CFRelease(font);
    
    
    _pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    CGFloat fontWidth = _pathLayer.bounds.size.width;
    CGFloat pointX = (SCREEN_WIDTH-20*coefficient-fontWidth-_carWidth-6*coefficient)/2.f;
    _pathLayer.geometryFlipped = YES;
    _pathLayer.path = path.CGPath;
    
    // 根据字长度 设置车图片的位置
    self.carLayer.anchorPoint = CGPointMake(0, 0.5);
    self.carLayer.center = CGPointMake(pointX+10*coefficient+_carWidth/2.f, 20*coefficient);
    
    // Line1
    
    UIBezierPath *linePath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(47*coefficient, 0, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [linePath1 addArcWithCenter:CGPointMake(50*coefficient, 3*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [linePath1 addArcWithCenter:CGPointMake(50*coefficient, 3*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [linePath1 moveToPoint:CGPointMake(50*coefficient, 6*coefficient)];
    
    [linePath1 addQuadCurveToPoint:CGPointMake(70*coefficient, 20*coefficient) controlPoint:CGPointMake(50*coefficient, 20*coefficient)];
    [linePath1 addLineToPoint:CGPointMake(pointX, 20*coefficient)];
    
    _lineLayer1.path = linePath1.CGPath;
    
    // Line2
    
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [linePath2 moveToPoint:CGPointMake(SCREEN_WIDTH - pointX, 20*coefficient)];
    [linePath2 addLineToPoint:CGPointMake(SCREEN_WIDTH-70*coefficient, 20*coefficient)];
    [linePath2 addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 34*coefficient) controlPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 20*coefficient)];
    
    UIBezierPath *round2Path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH-53*coefficient, 34*coefficient, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [round2Path addArcWithCenter:CGPointMake(SCREEN_WIDTH-50*coefficient, 37*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [round2Path addArcWithCenter:CGPointMake(SCREEN_WIDTH-50*coefficient, 37*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [linePath2 appendPath:round2Path];
    
    _lineLayer2.path = linePath2.CGPath;
    
    [self addAnimationWithCar];
}

// 从右到左 有文字
- (void)getAnimationLayerToLeftWithString:(NSString *)string {
    self.animationLayer.hidden = NO;
    self.animationLayer1.hidden = YES;
    
    self.pathLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.pathLayer.fillColor = nil;
    
    UIFont *textFont = [UIFont systemFontOfSize:14*coefficient];
    CTFontRef font =CTFontCreateWithName((CFStringRef)textFont.fontName,
                                         textFont.pointSize,
                                         NULL);
    CGMutablePathRef letters = CGPathCreateMutable();
    
    //这里设置画线的字体和大小
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)font, kCTFontAttributeName,
                           nil];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:attrs];
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    
    // for each RUN
    for (CFIndex runIndex = CFArrayGetCount(runArray) - 1; runIndex >= 0; runIndex--)
    {
        // Get FONT for this run
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        
        // for each GLYPH in run
        for (CFIndex runGlyphIndex = CTRunGetGlyphCount(run) - 1; runGlyphIndex >= 0; runGlyphIndex--)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    CFRelease(line);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:letters]];
    
    CGPathRelease(letters);
    CFRelease(font);
    
    
    _pathLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    CGFloat fontWidth = _pathLayer.bounds.size.width;
    CGFloat pointX = (SCREEN_WIDTH-20*coefficient-fontWidth-_carWidth-6*coefficient)/2.f;
    _pathLayer.geometryFlipped = YES;
    _pathLayer.path = path.CGPath;
    
    // 根据字长度 设置车图片的位置
    self.carLayer.anchorPoint = CGPointMake(1, 0.5);
    self.carLayer.center = CGPointMake(pointX+10*coefficient+_carWidth/2.f, 20*coefficient);
    
    // Line1
    
    UIBezierPath *linePath1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH - 53*coefficient, 0, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [linePath1 addArcWithCenter:CGPointMake(SCREEN_WIDTH - 50*coefficient, 3*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [linePath1 addArcWithCenter:CGPointMake(SCREEN_WIDTH - 50*coefficient, 3*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [linePath1 moveToPoint:CGPointMake(SCREEN_WIDTH - 50*coefficient, 6*coefficient)];
    
    [linePath1 addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH - 70*coefficient, 20*coefficient) controlPoint:CGPointMake(SCREEN_WIDTH - 50*coefficient, 20*coefficient)];
    [linePath1 addLineToPoint:CGPointMake(SCREEN_WIDTH - pointX, 20*coefficient)];
    
    _lineLayer1.path = linePath1.CGPath;
    
    // Line2
    
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [linePath2 moveToPoint:CGPointMake(pointX, 20*coefficient)];
    [linePath2 addLineToPoint:CGPointMake(70*coefficient, 20*coefficient)];
    [linePath2 addQuadCurveToPoint:CGPointMake(50*coefficient, 34*coefficient) controlPoint:CGPointMake(50*coefficient, 20*coefficient)];
    
    UIBezierPath *round2Path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(47*coefficient, 34*coefficient, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [round2Path addArcWithCenter:CGPointMake(50*coefficient, 37*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [round2Path addArcWithCenter:CGPointMake(50*coefficient, 37*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [linePath2 appendPath:round2Path];
    
    _lineLayer2.path = linePath2.CGPath;
    
    [self addAnimationWithCar];
}

- (void)addAnimationWithCar {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.beginTime = CACurrentMediaTime()+1;
    pathAnimation.fillMode = kCAFillModeBackwards;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.delegate = self;
    [pathAnimation setValue:@"fontAnim" forKey:@"animName"];
    [_pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation1.duration = 1.0;
    pathAnimation1.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation1.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation1.removedOnCompletion = YES;
    [_lineLayer1 addAnimation:pathAnimation1 forKey:@"strokeEnd"];
    
    CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation2.beginTime = CACurrentMediaTime()+2;
    pathAnimation2.fillMode = kCAFillModeBackwards;
    pathAnimation2.duration = 1.0;
    pathAnimation2.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation2.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation2.removedOnCompletion = YES;
    [_lineLayer2 addAnimation:pathAnimation2 forKey:@"strokeEnd"];
    
    CAKeyframeAnimation *carAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    carAnimation.duration = 1.0;
    carAnimation.path = self.lineLayer1.path;
    carAnimation.calculationMode = kCAAnimationPaced;
    [carAnimation setValue:@"carAnimation" forKey:@"animName"];
    [self.carLayer addAnimation:carAnimation forKey:@"position"];
}



- (void)getAnimationLayerToRight {
    self.animationLayer.hidden = YES;
    self.animationLayer1.hidden = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(47*coefficient, 0, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [path addArcWithCenter:CGPointMake(50*coefficient, 3*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(50*coefficient, 3*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    [path moveToPoint:CGPointMake(50*coefficient, 6*coefficient)];
    
    [path addQuadCurveToPoint:CGPointMake(70*coefficient, 20*coefficient) controlPoint:CGPointMake(50*coefficient, 20*coefficient)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH-70*coefficient, 20*coefficient)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 34*coefficient) controlPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 20*coefficient)];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH-53*coefficient, 34*coefficient, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [roundPath addArcWithCenter:CGPointMake(SCREEN_WIDTH-50*coefficient, 37*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [roundPath addArcWithCenter:CGPointMake(SCREEN_WIDTH-50*coefficient, 37*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path appendPath:roundPath];
    
    self.animationLayer1.path = path.CGPath;
    
    [self addPathAnimation];
}

- (void)getAnimationLayerToLeft {
    self.animationLayer.hidden = YES;
    self.animationLayer1.hidden = NO;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH-53*coefficient, 0, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [path addArcWithCenter:CGPointMake(SCREEN_WIDTH-50*coefficient, 3*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path addArcWithCenter:CGPointMake(SCREEN_WIDTH-50*coefficient, 3*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    [path moveToPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 6*coefficient)];
    
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH-70*coefficient, 20*coefficient) controlPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 20*coefficient)];
    [path addLineToPoint:CGPointMake(70*coefficient, 20*coefficient)];
    [path addQuadCurveToPoint:CGPointMake(50*coefficient, 34*coefficient) controlPoint:CGPointMake(50*coefficient, 20*coefficient)];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(47*coefficient, 34*coefficient, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [roundPath addArcWithCenter:CGPointMake(50*coefficient, 37*coefficient) radius:2*coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [roundPath addArcWithCenter:CGPointMake(50*coefficient, 37*coefficient) radius:coefficient startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [path appendPath:roundPath];
    
    self.animationLayer1.path = path.CGPath;
    
    [self addPathAnimation];
}

- (void)addPathAnimation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = YES;
    [self.animationLayer1 addAnimation:pathAnimation forKey:@"strokeEnd"];
}


#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"animName"] isEqualToString:@"fontAnim"]) {
        self.pathLayer.fillColor = [UIColor blackColor].CGColor;
        self.pathLayer.strokeColor = nil;
    }
}












- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
