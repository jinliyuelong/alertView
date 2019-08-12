//
//  MyBaseAlertView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyBaseAlertView : UIView

@property (nonatomic,assign) BOOL  grayViewUserInteractionEnabled;

- (void)showContentView:(UIView *)contentView;

- (void)dissmissContentView;

@end

