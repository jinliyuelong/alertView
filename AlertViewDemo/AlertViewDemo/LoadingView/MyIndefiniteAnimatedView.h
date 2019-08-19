//
//  MyIndefiniteAnimatedView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/14.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyIndefiniteAnimatedViewType) {
    MyIndefiniteAnimatedViewTypeDefault,
    MyIndefiniteAnimatedViewTypeContentImg,
};


@interface MyIndefiniteAnimatedView : UIView

- (instancetype)initWithAnimatedViewType:(MyIndefiniteAnimatedViewType)type;

@end

