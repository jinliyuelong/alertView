//
//  MyBaseAlertView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyBaseAlertView.h"

@interface MyBaseAlertView()

@property (nonatomic,weak  ) UIView *contentView;    //-> 提示的弹框
@property (nonatomic,strong) UIView *grayView;       //-> 灰色半透明背景

@end

@implementation MyBaseAlertView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    return self;
}

- (void)showContentView:(UIView *)contentView{
    
    self.contentView = contentView;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self creatGrayBgView];
    [self creatContentView];
    
}


- (void)creatGrayBgView{
    
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.grayView = [[UIView alloc] initWithFrame:frame];
    self.grayView.backgroundColor = [UIColor blackColor];
    self.grayView.alpha = 0;
    [self addSubview:self.grayView];
    
    // 执行渐变动画
    [UIView animateWithDuration:0.3f animations:^{
        self.grayView.alpha = 0.25f;
    } completion:^(BOOL finished) {
        [self addTapGestureRecognizer];
    }];
}


- (void)creatContentView{
    
    [self addSubview:self.contentView];
    self.contentView.center = self.grayView.center;
    self.contentView.userInteractionEnabled = NO;
    self.contentView.transform = CGAffineTransformMakeScale(0.f, 0.f);

    [UIView animateWithDuration:1 delay:0.5 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1.f, 1.f);
    } completion:^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
    }];
}



- (void)dissmissContentView{
    
    [UIView animateWithDuration:0.2f animations:^{
        self.contentView.alpha     = 0.f;
        self.grayView.alpha = 0.f;
        self.contentView.transform = CGAffineTransformMakeScale(0.75f, 0.75f);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.grayView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

- (void)dealloc{
    NSLog(@"%@ dealloc.", NSStringFromClass([self class]));
}

- (void)addTapGestureRecognizer{
    //单击的手势
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tapRecognize.numberOfTapsRequired = 1;
    [tapRecognize setEnabled :YES];
    [tapRecognize delaysTouchesBegan];
    [tapRecognize cancelsTouchesInView];
    [self.grayView addGestureRecognizer:tapRecognize];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer{
    NSLog(@"---单击手势-------");
    if (self.grayViewUserInteractionEnabled) {
//        [self dissmissContentView];
    }
}

@end
