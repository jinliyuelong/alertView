//
//  MySuperSearchAlertView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MySuperSearchAlertViewActionBlock)(UIButton *sender);

@interface MySuperSearchAlertView : UIView

@property (nonatomic,copy) MySuperSearchAlertViewActionBlock actionBlock;

@end
