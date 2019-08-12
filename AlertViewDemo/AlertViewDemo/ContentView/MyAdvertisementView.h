//
//  MyAdvertisementView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyAdvertisementViewActionBlock)(UIButton *sender);

@interface MyAdvertisementView : UIView

@property (nonatomic,copy) MyAdvertisementViewActionBlock actionBlock;

@end

