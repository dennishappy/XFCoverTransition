//
//  XFCoverTransitionGesture.m
//  XFCoverTransitionExample
//
//  Created by 付星 on 15/8/9.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import "XFCoverTransitionGesture.h"
#import "XFCTConfig.h"
#import "UIView+Extention.h"

@interface XFCoverTransitionGesture ()

@property (nonatomic, strong) XFCTConfig *config;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImageView *lastVcView;
@end

@implementation XFCoverTransitionGesture

+ (instancetype)gestureWithPresentingVC:(UIViewController *)presentingVC presentedVC:(UIViewController *)presentedVC config:(XFCTConfig *)config {
    
    XFCoverTransitionGesture *instance = [[XFCoverTransitionGesture alloc] init];
	// 创建modal控制器的显示手势
    UIPanGestureRecognizer *presentingPan = [[UIPanGestureRecognizer alloc] initWithTarget:instance action:@selector(drag2Present:)];
    [presentingVC.view addGestureRecognizer:presentingPan];
    // 创建被modal控制器的隐藏手势
    UIPanGestureRecognizer *presentedPan = [[UIPanGestureRecognizer alloc] initWithTarget:instance action:@selector(drag2dismiss:)];
    [presentedVC.view addGestureRecognizer:presentedPan];
    
    instance.presentingViewController = presentingVC;
    instance.presentedViewController = presentedVC;
    
    // 配置modal控制器的初始位置
    instance.config = config;
    instance.presentedViewController.view.frame = config.renderRect;
    switch (config.transitionStyle) {
        case XFCoverTransitionStyleCoverRight2Left: {
            instance.presentedViewController.view.x = instance.presentingViewController.view.width;
            break;
        }
        case XFCoverTransitionStyleCoverLeft2Right: {
            instance.presentedViewController.view.x = -instance.presentingViewController.view.width;
            break;
        }
        default: {
            break;
        }
    }
    [instance.presentingViewController.view addSubview:instance.presentedViewController.view];
    [instance.presentingViewController addChildViewController:presentedVC];
    
    return instance;
}

- (void)drag2Present:(UIPanGestureRecognizer *)recognizer {
    // 获取偏移量
    CGFloat tx = [recognizer translationInView:self.presentingViewController.view].x;
    // 当前modal view的x值
    CGFloat x = self.presentedViewController.view.x;
    
    BOOL isCancel = false;
    CGFloat destX = 0;
    if (self.config.transitionStyle == XFCoverTransitionStyleCoverRight2Left) {
        if (tx > 0) return;
         // 如果没有滑动到1/3，返回
        isCancel = x > self.presentingViewController.view.width * 0.7;
        if (isCancel) {
            destX = self.presentingViewController.view.width;
        }else{
            destX = -self.presentingViewController.view.width;
        }
        
    }else if(self.config.transitionStyle == XFCoverTransitionStyleCoverLeft2Right){
        if (tx < 0) return;
        // 如果没有滑动到1/3，返回
        isCancel = x < -self.presentingViewController.view.width * 0.7;
        if (isCancel) {
            destX = -self.presentingViewController.view.width;
        }else{
//            NSLog(@"isCancel -- %d",isCancel);
            destX = self.presentingViewController.view.width;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
       
        [UIView animateWithDuration:0.25 animations:^{
            self.presentedViewController.view.transform = CGAffineTransformMakeTranslation(destX, 0);
        } completion:nil];
    } else if(recognizer.state == UIGestureRecognizerStateChanged) {
        // 移动view
        self.presentedViewController.view.transform = CGAffineTransformMakeTranslation(tx, 0);
        
        // 当第二次拖动时，需要增减一个屏宽
        if (self.presentedViewController.view.x > self.presentingViewController.view.width) {
            self.presentedViewController.view.x -= self.presentingViewController.view.width;
        }
        if (self.presentedViewController.view.x < -self.presentingViewController.view.width) {
            self.presentedViewController.view.x += self.presentingViewController.view.width;
        }
    }
}

- (void)drag2dismiss:(UIPanGestureRecognizer *)recognizer {
    CGFloat tx = [recognizer translationInView:self.presentedViewController.view].x;
    // 创建视图截屏
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self createScreenShot];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 添加截图到最后面
        self.lastVcView.image = [self.images lastObject];
        [window insertSubview:self.lastVcView atIndex:0];
    }
    
    // 当前modal view的x值
    CGFloat x = self.presentedViewController.view.x;
    
    BOOL isCancel = false;
    CGFloat destX = 0;
    if (self.config.transitionStyle == XFCoverTransitionStyleCoverRight2Left) {
        if (tx < 0) return;
        // 如果没有滑动到1/3，返回
        isCancel = x < self.presentingViewController.view.width * 0.3;
        if (isCancel) {
            destX = 0;
        }else{
            destX = self.presentingViewController.view.width;
        }
    }else if(self.config.transitionStyle == XFCoverTransitionStyleCoverLeft2Right){
        if (tx > 0) return;
        // 如果没有滑动到1/3，返回
        isCancel = x > -self.presentingViewController.view.width * 0.3;
        if (isCancel) {
            destX = 0;
        }else{
            destX = -self.presentingViewController.view.width;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.presentedViewController.view.x = destX;
        } completion:^(BOOL finished) {
            if(!isCancel)
                [self.lastVcView removeFromSuperview];
        }];
    } else if(recognizer.state == UIGestureRecognizerStateChanged){
        // 移动view
        self.presentedViewController.view.x = tx;
    }
}

- (void)createScreenShot
{
    UIGraphicsBeginImageContextWithOptions(self.presentingViewController.view.size, YES, 0.0);
    [self.presentingViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self.images removeAllObjects];
    [self.images addObject:image];
}

- (UIImageView *)lastVcView
{
    if (_lastVcView == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIImageView *lastVcView = [[UIImageView alloc] init];
        lastVcView.backgroundColor = [UIColor whiteColor];
        lastVcView.frame = window.bounds;
        _lastVcView = lastVcView;
    }
    return _lastVcView;
}
- (NSMutableArray *)images
{
    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
    }
    return _images;
}

@end
