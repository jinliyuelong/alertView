//
//  MyIndefiniteAnimatedView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/14.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyIndefiniteAnimatedView.h"

@interface MyIndefiniteAnimatedView ()

@property (nonatomic,assign) MyIndefiniteAnimatedViewType  animatedViewType;

@end

@implementation MyIndefiniteAnimatedView

- (instancetype)initWithAnimatedViewType:(MyIndefiniteAnimatedViewType)type{
    _animatedViewType = type;
    return [self init];
}

- (instancetype)init{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, 75.f, 75.f);
        self.layer.cornerRadius  = 5.f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65f];
        
        [self configIndefiniteAnimatedView];
        
    }
    return self;
}

- (void)configIndefiniteAnimatedView{
    
    switch (self.animatedViewType) {
        case MyIndefiniteAnimatedViewTypeDefault:
            [self addActivityIndicatorView];
            break;
        case MyIndefiniteAnimatedViewTypeContentImg:
            [self addIndefiniteImgView];
            break;
        default:
            break;
    }
}

- (void)addActivityIndicatorView{
   
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = self.center;  //  只能设置中心，不能设置大小
    [self addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
}

- (void)addIndefiniteImgView{
    
    //背景圈圈
    UIImage *circleImg = [UIImage imageNamed:@"跳转黑圈"];
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circleImg];
    circleView.center       = self.center;
    [self addSubview:circleView];
    
    //无线旋转的圈圈
    UIImage *circleRotationImg = [UIImage imageNamed:@"跳转白圈"];
    UIImageView *circleRotateImageView = [[UIImageView alloc] initWithImage:circleRotationImg];
    circleRotateImageView.tag = 9998;
    circleRotateImageView.center       = self.center;
    [self addSubview:circleRotateImageView];
    
    //旋转动画
    NSTimeInterval animationDuration = 0.75;
    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.fromValue = (id) 0;
    animation.toValue = @(M_PI*2);
    animation.duration = animationDuration;
    animation.timingFunction = linearCurve;
    animation.removedOnCompletion = NO;
    animation.repeatCount = INFINITY;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    [circleRotateImageView.layer addAnimation:animation forKey:@"rotate"];
    
}

@end
