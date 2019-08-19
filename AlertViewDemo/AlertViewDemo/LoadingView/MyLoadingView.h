//
//  MyLoadingView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/14.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyIndefiniteAnimatedView.h"

@interface MyLoadingView : UIView

+ (void)showLoadingView;

+ (void)dismissLoadingView;
+ (void)dismissLoadingViewWithCompletion:(void(^)(void))completion;
+ (void)dismissLoadingViewWithDelay:(NSTimeInterval)delay;
+ (void)dismissLoadingViewWithDelay:(NSTimeInterval)delay completion:(void(^)(void))completion;


+ (void)configLoadingViewAnimationType:(MyIndefiniteAnimatedViewType)type;

@end

