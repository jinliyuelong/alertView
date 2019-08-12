//
//  MyAdvertisementView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyAdvertisementView.h"

@interface MyAdvertisementView ()

@end


@implementation MyAdvertisementView


- (instancetype)init{
    CGRect frame = CGRectMake(0, 0, 300, 300);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor  redColor];
        [self configSubView];
    }
    return self;
}


- (void)configSubView{
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(110, 220, 80, 30);
    [btn1 setTitle:@"关闭" forState:(UIControlStateNormal)];
    [self addSubview:btn1]; 
    [btn1 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
