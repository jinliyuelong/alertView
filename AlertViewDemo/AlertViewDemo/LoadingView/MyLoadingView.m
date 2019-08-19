//
//  MyLoadingView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/14.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyLoadingView.h"


@interface MyLoadingView ()

@property (nonatomic,assign) MyIndefiniteAnimatedViewType animationType;

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) MyIndefiniteAnimatedView *indefiniteAnimationView;

@end


@implementation MyLoadingView

+ (MyLoadingView *)sharedLoadingView{
    
    static MyLoadingView *loadingView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingView = [[MyLoadingView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return loadingView;
    
}

+ (void)showLoadingView{
    [[self sharedLoadingView] updateLoadingView];
}


+ (void)dismissLoadingView{
    [[self sharedLoadingView] dismissWithDelay:0 completion:nil];
}

+ (void)dismissLoadingViewWithCompletion:(void (^)(void))completion{
    [[self sharedLoadingView] dismissWithDelay:0 completion:completion];
}

+ (void)dismissLoadingViewWithDelay:(NSTimeInterval)delay{
    [[self sharedLoadingView] dismissWithDelay:delay completion:nil];
}

+ (void)dismissLoadingViewWithDelay:(NSTimeInterval)delay completion:(void (^)(void))completion{
    [[self sharedLoadingView] dismissWithDelay:delay completion:completion];
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.backgroundView];
        [self addSubview:self.indefiniteAnimationView];
        
    }
    return self;
}

- (void)updateLoadingView{
    __weak MyLoadingView *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        __strong MyLoadingView *strongSelf = weakSelf;
        [[UIApplication sharedApplication].keyWindow addSubview:strongSelf];
        [strongSelf.superview bringSubviewToFront:strongSelf];
        
        [strongSelf layoutSubviews];
        [strongSelf layoutIfNeeded];
        
    }];
}


- (void)dismissLoadingView{
    [self dismissWithDelay:0 completion:nil];
}

- (void)dismissWithDelay:(NSTimeInterval)delay completion:(void(^)(void))completion{
    
    __weak MyLoadingView *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        __strong MyLoadingView *strongSelf = weakSelf;
        
        __block void (^completionBlock)(void) = ^{
            [strongSelf removeFromSuperview];

            if (completion) {
                completion();
            }
        };
        
        if (delay > 0) {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                completionBlock();
            });
        }else{
            completionBlock();
        }
    
        
    }];
}



#pragma mark - getter
- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[self bounds]];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return _backgroundView;
}


- (MyIndefiniteAnimatedView *)indefiniteAnimationView{
    if (!_indefiniteAnimationView) {
        _indefiniteAnimationView = [[MyIndefiniteAnimatedView alloc] initWithAnimatedViewType:self.animationType];
        _indefiniteAnimationView.center = self.center;
        _indefiniteAnimationView.hidden = NO;
    }
    return _indefiniteAnimationView;
}


#pragma mark - public method
+ (void)configLoadingViewAnimationType:(MyIndefiniteAnimatedViewType)type{
    [[self sharedLoadingView].indefiniteAnimationView removeFromSuperview];
    [self sharedLoadingView].indefiniteAnimationView = nil;
    [self sharedLoadingView].animationType = type;
    [[self sharedLoadingView] addSubview:[self sharedLoadingView].indefiniteAnimationView];
    [[self sharedLoadingView] updateLoadingView];
}


@end
