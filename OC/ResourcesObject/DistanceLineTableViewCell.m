//
//  DistanceLineTableViewCell.m
//  ResourcesObject
//
//  Created by CMVIOS1 on 2017/11/20.
//  Copyright © 2017年 zhengxingxia. All rights reserved.
//

#import "DistanceLineTableViewCell.h"
#import "JMTool.h"

@interface DistanceLineTableViewCell ()

@property (weak,nonatomic)CAShapeLayer *animationLayer;

@end

@implementation DistanceLineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CAShapeLayer * animationLayer = [CAShapeLayer layer];
        animationLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40*coefficient);
        [self.layer addSublayer:animationLayer];
        self.animationLayer = animationLayer;
        
    }
    return self;
}

- (void)getAnimationLayerToRight {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(47*coefficient, 0, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [path moveToPoint:CGPointMake(50*coefficient, 6*coefficient)];
    
    [path addQuadCurveToPoint:CGPointMake(70*coefficient, 20*coefficient) controlPoint:CGPointMake(50*coefficient, 20*coefficient)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH-70*coefficient, 20*coefficient)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 33*coefficient) controlPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 20*coefficient)];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH-53*coefficient, 33*coefficient, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [path appendPath:roundPath];
    
    self.animationLayer.path = path.CGPath;
    
    [self addPathAnimation];
}

- (void)getAnimationLayerToLeft {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(SCREEN_WIDTH-53*coefficient, 0, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [path moveToPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 6*coefficient)];
    
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH-70*coefficient, 20*coefficient) controlPoint:CGPointMake(SCREEN_WIDTH-50*coefficient, 20*coefficient)];
    [path addLineToPoint:CGPointMake(70*coefficient, 20*coefficient)];
    [path addQuadCurveToPoint:CGPointMake(50*coefficient, 33*coefficient) controlPoint:CGPointMake(50*coefficient, 20*coefficient)];
    
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(47*coefficient, 33*coefficient, 6*coefficient, 6*coefficient) cornerRadius:3*coefficient];
    [path appendPath:roundPath];
    
    self.animationLayer.path = path.CGPath;
    
    [self addPathAnimation];
}

- (void)addPathAnimation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = YES;
    [self.animationLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
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
