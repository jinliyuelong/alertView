//
//  MyUpdateAlertView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MyUpdateAlertViewActionBlock)(UIButton *sender);

@interface MyUpdateAlertView : UIView

@property (nonatomic,copy) MyUpdateAlertViewActionBlock actionBlock;

@end

