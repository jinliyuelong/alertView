//
//  MyTabbarViewController.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyTabbarViewController.h"

#import "MyViewController.h"
#import "LoadingViewController.h"


@interface MyTabbarViewController ()

@end

@implementation MyTabbarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configViewControllers];
}

- (void)configViewControllers{
    
    MyViewController *controller = [[MyViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:controller];
    
    LoadingViewController *loadingController = [[LoadingViewController alloc] init];
    UINavigationController *loadingNavi = [[UINavigationController alloc] initWithRootViewController:loadingController];

    self.viewControllers = @[navi,loadingNavi];
}



@end


