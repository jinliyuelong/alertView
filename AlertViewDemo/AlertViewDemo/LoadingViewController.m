//
//  LoadingViewController.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/14.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "LoadingViewController.h"
#import "MyLoadingView.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [MyLoadingView configLoadingViewAnimationType:MyIndefiniteAnimatedViewTypeContentImg];
    [MyLoadingView showLoadingView];
    [MyLoadingView dismissLoadingViewWithDelay:2.0];
    [self performSelector:@selector(show) withObject:nil afterDelay:2.1];
    [self performSelector:@selector(show2) withObject:nil afterDelay:10.0];
    [self performSelector:@selector(show) withObject:nil afterDelay:11.0];

}

- (void)show{
    [MyLoadingView configLoadingViewAnimationType:MyIndefiniteAnimatedViewTypeDefault];
    [MyLoadingView showLoadingView];
}

- (void)show2{
    [MyLoadingView configLoadingViewAnimationType:MyIndefiniteAnimatedViewTypeContentImg];
    [MyLoadingView showLoadingView];
}

- (void)dissmiss{
    [MyLoadingView dismissLoadingView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
