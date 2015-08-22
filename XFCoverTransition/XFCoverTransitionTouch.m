//
//  XFCoverTransitionManager.m
//  XFCoverTransition
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFCoverTransitionTouch.h"
#import "XFPresentationController.h"
#import "XFAnimatedTransitioning.h"
#import "XFCTConfig.h"
#import "XFCoverTransitionGesture.h"

@interface XFCoverTransitionTouch ()

@property (nonatomic, strong) XFCoverTransitionGesture *ctGesture;
@end

@implementation XFCoverTransitionTouch
SingletonM(Instance)

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    XFPresentationController *presentationController = [[XFPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationController.renderRect = self.config ? self.config.renderRect : presentationController.containerView.bounds;
    // 添加手势移除功能
    if (self.config.isOnlyForModalVCGestureDissmiss && self.config.transitionStyle <= XFCoverTransitionStyleRight2Left) {
        self.ctGesture = [XFCoverTransitionGesture gestureWithPresentingViewController:source presentedViewController:presented config:self.config];
    }
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    XFAnimatedTransitioning *anim = [[XFAnimatedTransitioning alloc] init];
    anim.presented = YES;
    anim.animationDuration = self.config ? self.config.animationDuration : 0.75;
    anim.transitionStyle = self.config ? self.config.transitionStyle : XFCoverTransitionStyleRight2Left;
    return anim;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    XFAnimatedTransitioning *anim = [[XFAnimatedTransitioning alloc] init];
    anim.presented = NO;
    anim.animationDuration = self.config ? self.config.animationDuration : 0.75;
    anim.transitionStyle = self.config ? self.config.transitionStyle : XFCoverTransitionStyleRight2Left;
    return anim;
}

@end
