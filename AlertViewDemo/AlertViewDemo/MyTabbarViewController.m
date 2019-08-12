//
//  MyTabbarViewController.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyTabbarViewController.h"

#import "MyViewController.h"


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
    self.viewControllers = @[navi,navi];
}



@end


