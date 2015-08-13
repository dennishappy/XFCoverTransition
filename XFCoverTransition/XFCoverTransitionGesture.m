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

// 当前显示的主控制器(presentingViewController)
@property (nonatomic, weak) UIViewController *presentingViewController;
// 将要被modal出来的控制器(presentedViewController)
@property (nonatomic, weak) UIViewController *presentedViewController;

@property (nonatomic, strong) XFCTConfig *config;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) UIImageView *lastVcView;
@end

@implementation XFCoverTransitionGesture

+ (instancetype)gestureWithPresentingViewController:(UIViewController *)presentingVC presentedViewController:(UIViewController *)presentedVC config:(XFCTConfig *)config {
    
    XFCoverTransitionGesture *instance = [[XFCoverTransitionGesture alloc] init];
	
    instance.presentingViewController = presentingVC;
    instance.presentedViewController = presentedVC;
    
    // 配置modal控制器的初始位置
    instance.config = config;
    instance.config.animationDuration = config.animationDuration <= 0 ? 0.25 : config.animationDuration;
    instance.presentedViewController.view.frame = config.renderRect;
    
    
    
    // 如果只支持手势移除
    if(config.isOnlyForModalVCGestureDissmiss){
        
    }else // 否则是手势添加与移除
    {
        // 创建modal控制器的显示手势
        UIPanGestureRecognizer *presentingPan = [[UIPanGestureRecognizer alloc] initWithTarget:instance action:@selector(drag2Present:)];
        [presentingVC.view addGestureRecognizer:presentingPan];
        
        // 添加到子View
        [instance.presentingViewController.view addSubview:instance.presentedViewController.view];
        // 添加到子控制器
        [instance.presentingViewController addChildViewController:presentedVC];
        
        // 设置起始位置
        switch (config.transitionStyle) {
            case XFCoverTransitionStyleCoverRight2Left: {
                instance.presentedViewController.view.x = instance.presentingViewController.view.width;
                break;
            }
            case XFCoverTransitionStyleCoverLeft2Right: {
                instance.presentedViewController.view.x = -instance.presentingViewController.view.width;
                break;
            }
            case XFCoverTransitionStyleCoverTop2Bottom: {
                instance.presentedViewController.view.y = -instance.presentingViewController.view.height;
                break;
            }
            case XFCoverTransitionStyleCoverBottom2Top: {
                instance.presentedViewController.view.y = instance.presentingViewController.view.height;
                break;
            }
            default: {
                break;
            }
        }
    }
    // 创建被modal控制器的隐藏手势
    UIPanGestureRecognizer *presentedPan = [[UIPanGestureRecognizer alloc] initWithTarget:instance action:@selector(drag2dismiss:)];
    [presentedVC.view addGestureRecognizer:presentedPan];
    
    return instance;
}

- (void)drag2Present:(UIPanGestureRecognizer *)recognizer {
    // 获取偏移量
    CGPoint offset = [recognizer translationInView:self.presentedViewController.view];
    CGFloat tx = offset.x;
    CGFloat ty = offset.y;
    
    CGFloat x = self.presentedViewController.view.x;
    CGFloat y = self.presentedViewController.view.y;
    
    // 拖动是否取消
    bool isCancel = false;
    // 目标值
    CGFloat destX = 0;
    CGFloat destY = 0;
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
            destX = self.presentingViewController.view.width;
        }
    }else if(self.config.transitionStyle == XFCoverTransitionStyleCoverBottom2Top){
        if (ty > 0) return;
        isCancel = y > self.presentingViewController.view.height * 0.7;
        if (isCancel) {
            destY = self.presentingViewController.view.height;
        }else{
            destY = -self.presentingViewController.view.height;
        }
    }else if(self.config.transitionStyle == XFCoverTransitionStyleCoverTop2Bottom){
        if (ty < 0) return;
        isCancel = y < -self.presentingViewController.view.height * 0.7;
        if (isCancel) {
            destY = -self.presentingViewController.view.height;
        }else{
            destY = self.presentingViewController.view.height;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
       
        [UIView animateWithDuration:self.config.animationDuration animations:^{
            if(self.config.transitionStyle == XFCoverTransitionStyleCoverLeft2Right || self.config.transitionStyle == XFCoverTransitionStyleCoverRight2Left)
                self.presentedViewController.view.transform = CGAffineTransformMakeTranslation(destX, 0);
            if(self.config.transitionStyle == XFCoverTransitionStyleCoverTop2Bottom || self.config.transitionStyle == XFCoverTransitionStyleCoverBottom2Top)
                self.presentedViewController.view.transform = CGAffineTransformMakeTranslation(0, destY);
        } completion:nil];
    } else if(recognizer.state == UIGestureRecognizerStateChanged) {
        if(self.config.transitionStyle == XFCoverTransitionStyleCoverLeft2Right || self.config.transitionStyle == XFCoverTransitionStyleCoverRight2Left){
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
        if(self.config.transitionStyle == XFCoverTransitionStyleCoverTop2Bottom || self.config.transitionStyle == XFCoverTransitionStyleCoverBottom2Top){
            self.presentedViewController.view.transform = CGAffineTransformMakeTranslation(0, ty);
            
            if (self.presentedViewController.view.y > self.presentingViewController.view.height) {
                self.presentedViewController.view.y -= self.presentingViewController.view.height;
            }
            if (self.presentedViewController.view.y < -self.presentingViewController.view.height) {
                self.presentedViewController.view.y += self.presentingViewController.view.height;
            }
        }
        
    }
}

- (void)drag2dismiss:(UIPanGestureRecognizer *)recognizer {
    CGPoint offset = [recognizer translationInView:self.presentedViewController.view];
    CGFloat tx = offset.x;
    CGFloat ty = offset.y;
    
    // 创建视图截屏
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (!self.config.isOnlyForModalVCGestureDissmiss) {
            [self createScreenShot];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            // 添加截图到最后面
            self.lastVcView.image = [self.images lastObject];
            [window insertSubview:self.lastVcView atIndex:0];
        }
    }
    
    // 当前modal view的x值
    CGFloat x = self.presentedViewController.view.x;
    CGFloat y = self.presentedViewController.view.y;
    
    bool isCancel = false;
    CGFloat destX = 0;
    CGFloat destY = 0;
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
    }else if(self.config.transitionStyle == XFCoverTransitionStyleCoverBottom2Top){
        if (ty < 0) return;
        isCancel = y < self.presentingViewController.view.height * 0.3;
        if (isCancel) {
            destY = 0;
        }else{
            destY = self.presentingViewController.view.height;
        }
    }else if(self.config.transitionStyle == XFCoverTransitionStyleCoverTop2Bottom){
        if (ty > 0) return;
        isCancel = y > -self.presentingViewController.view.height * 0.3;
        if (isCancel) {
            destY = 0;
        }else{
            destY = -self.presentingViewController.view.height;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:self.config.animationDuration animations:^{
            if(self.config.transitionStyle == XFCoverTransitionStyleCoverLeft2Right || self.config.transitionStyle == XFCoverTransitionStyleCoverRight2Left)
                self.presentedViewController.view.x = destX;
            if(self.config.transitionStyle == XFCoverTransitionStyleCoverTop2Bottom || self.config.transitionStyle == XFCoverTransitionStyleCoverBottom2Top)
                self.presentedViewController.view.y = destY;
        } completion:^(BOOL finished) {
            if (self.config.isOnlyForModalVCGestureDissmiss) {
                if(!isCancel)
                    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
            }else{
                if(!isCancel)
                    [self.lastVcView removeFromSuperview];
            }
        }];
    } else if(recognizer.state == UIGestureRecognizerStateChanged){
        // 移动view
        if(self.config.transitionStyle == XFCoverTransitionStyleCoverLeft2Right || self.config.transitionStyle == XFCoverTransitionStyleCoverRight2Left)
            self.presentedViewController.view.x = tx;
        if(self.config.transitionStyle == XFCoverTransitionStyleCoverTop2Bottom || self.config.transitionStyle == XFCoverTransitionStyleCoverBottom2Top)
            self.presentedViewController.view.y = ty;
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
