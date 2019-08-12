//
//  MyViewController.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyViewController.h"


#import "MyBaseAlertView.h"

#import "MyUpdateAlertView.h"
#import "MyAdvertisementView.h"
#import "MySuperSearchAlertView.h"


@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view2];
    view2.center = self.view.center;
    
    __weak typeof(self) weakSelf = self;
    view2.actionBlock = ^(UIButton *sender) {
        [weakSelf showSerialQueueAlertView];
    };

}

- (void)showSerialQueueAlertView{
    
    //创建一个队列，串行并行都可以，主要为了操作信号量
    dispatch_queue_t queue = dispatch_queue_create("alertViewDemo", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        //创建一个初始为0的信号量
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        //同理，创建第N个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                
                MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                [alertView2 showContentView:view2];
                [self.view addSubview:alertView2];
                view2.actionBlock = ^(UIButton *sender) {
                    [alertView2 dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
            
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        
        //同理，创建第N个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                
                MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                [alertView2 showContentView:view2];
                [self.view addSubview:alertView2];
                view2.actionBlock = ^(UIButton *sender) {
                    [alertView2 dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
            
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        //第一个弹框，UI的创建和显示，要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框1" message:@"第一个弹框" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    //点击Alert上的按钮，我们发送一次信号。
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                dispatch_semaphore_signal(sema);
            }
        });
        
        
        //等待信号触发，注意，这里是在我们创建的队列中等待
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //上面的等待到信号触发之后，再创建第二个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框2" message:@"第二个弹框" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        
        //同理，创建第三个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框3" message:@"第三个弹框" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        
        //同理，创建第N个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([self showAlertView]) {
                
                MyUpdateAlertView *view1 = [[MyUpdateAlertView alloc] init];
                MyBaseAlertView *alertView = [[MyBaseAlertView alloc] init];
                [alertView showContentView:view1];
                [self.view addSubview:alertView];
                view1.actionBlock = ^(UIButton *sender) {
                    [alertView dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
        });
        
        
        
        
        //同理，创建第N个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                
                MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                [alertView2 showContentView:view2];
                [self.view addSubview:alertView2];
                view2.actionBlock = ^(UIButton *sender) {
                    [alertView2 dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        
        
        
        //同理，创建第N个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self showAlertView]) {
                
                MySuperSearchAlertView *view3 = [[MySuperSearchAlertView alloc] init];
                MyBaseAlertView *alertView3 = [[MyBaseAlertView alloc] init];
                [alertView3 showContentView:view3];
                [self.view addSubview:alertView3];
                view3.actionBlock = ^(UIButton *sender) {
                    [alertView3 dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
        });
        
        NSLog(@"执行完毕所有的内容");
        
    });
    NSLog(@"添加完所有提示框");
}


- (BOOL)showAlertView{
    int x = arc4random() % 10;
    NSLog(@"当前随机数 %d",x);
    if (x % 2 == 0) {
        return YES;
    }else{
        return NO;
    }
}


@end
