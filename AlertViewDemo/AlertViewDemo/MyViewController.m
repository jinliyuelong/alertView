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

@property (nonatomic,assign) dispatch_queue_t myQueue;
@property (nonatomic,assign) NSInteger currentLoop;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNaviBarButton];
}

- (void)addNaviBarButton{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickAction)];
    self.navigationItem.rightBarButtonItem = barButton;
}


- (void)clickAction{
    NSLog(@"开始执行");
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
        NSLog(@"执行完毕");
    }];
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
        NSLog(@"执行完毕");
    }];
}


- (void)showSerialQueueAlertViewCompletion:(void(^)(BOOL finished))completion{
    self.currentLoop++;
    NSString *loopStr = [NSString stringWithFormat:@"当前第%ld轮弹框",self.currentLoop];
    self.navigationItem.title = [NSString stringWithFormat:@"点击次数%ld",self.currentLoop];
    NSLog(@"开始执行  弹框 ：%@",[NSThread currentThread]);
    //异步  这里会开启新的线程
    //为保证 在同一个线程 必须确保queue 是同一个同步队列
    dispatch_async(self.myQueue, ^{
        //创建一个初始为0的信号量
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSLog(@"串行队列执行 第一个 弹框 ：%@",[NSThread currentThread]);
        //创建第1个Alert UI的创建和显示，要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"串行队列 主线程 执行 第一个 弹框 ：%@",[NSThread currentThread]);
            if ([self showAlertView]) {
                MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
                view2.title = [NSString stringWithFormat:@"%@,第一个",loopStr];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                alertView2.animationType = MyBaseAlertViewAnimationTypeMoveFromBottomToBottom;
                [alertView2 showContentView:view2];
                [self.view addSubview:alertView2];
                view2.actionBlock = ^(UIButton *sender) {
                    [alertView2 dissmissContentView];
                    //点击Alert上的按钮，我们发送一次信号。
                    dispatch_semaphore_signal(sema);
                };
            }else{
                // 如果无需显示 直接发送信号量
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        //等待信号触发，注意，这里是在我们创建的队列中等待
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"串行队列执行 第二个 弹框 ：%@",[NSThread currentThread]);
        //上面的等待到信号触发之后，再创建第二个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"串行队列 主线程 执行 第二个 弹框 ：%@",[NSThread currentThread]);
            
            if ([self showAlertView]) {
                MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
                view2.title = loopStr;
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                alertView2.animationType = MyBaseAlertViewAnimationTypeMoveFromTopToTop;
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
                
                MyAdvertisementView *view2 = [[MyAdvertisementView alloc] init];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                view2.title = loopStr;

                alertView2.animationType = MyBaseAlertViewAnimationTypeMoveFromBottomToTop;
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
                view3.title = [NSString stringWithFormat:@"%@,最后一个",loopStr];
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
        
        // 最终执行完毕 执行完毕回掉 同时也是为了衔接最后一个alert 和 下一轮的第一个alert 不然会出现同时弹出两个alert 的情况
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"执行finished block 回掉");
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(sema);
            if (completion) {
                completion(YES);
            }
        });
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

- (dispatch_queue_t)myQueue{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("alertViewDemo", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}


@end

