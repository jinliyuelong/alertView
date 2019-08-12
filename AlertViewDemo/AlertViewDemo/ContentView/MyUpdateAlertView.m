//
//  MyUpdateAlertView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyUpdateAlertView.h"

@interface MyUpdateAlertView ()

@end

@implementation MyUpdateAlertView

- (instancetype)init{
    CGRect frame = CGRectMake(0, 0, 200, 300);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor  blueColor];
        [self configSubView];
    }
    return self;
}


- (void)configSubView{
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(20, 220, 70, 30);
    [btn1 setTitle:@"忽略" forState:(UIControlStateNormal)];
    [self addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    [btn2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn2.frame = CGRectMake(110, 220, 70, 30);
    [btn2 setTitle:@"更新" forState:(UIControlStateNormal)];
    [self addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)btnClickAction:(UIButton *)sender{
   
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
    
}

- (void)dealloc{
    NSLog(@"%@ dealloc.", NSStringFromClass([self class]));
}

@end
