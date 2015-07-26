//
//  XFCoverTransitionManager.m
//  XFCoverTransition
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFCoverTransitionManager.h"
#import "XFPresentationController.h"
#import "XFAnimatedTransitioning.h"
#import "XFCTConfig.h"

@implementation XFCoverTransitionManager
SingletonM(Manager)

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    XFPresentationController *presentationController = [[XFPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentationController.renderSize = self.config ? self.config.renderSize : presentationController.containerView.bounds;
    return presentationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    XFAnimatedTransitioning *anim = [[XFAnimatedTransitioning alloc] init];
    anim.presented = YES;
    anim.animationDuration = self.config ? self.config.animationDuration : 0.75;
    anim.transitionStyle = self.config ? self.config.transitionStyle : XFCoverTransitionStyleCoverRight2Left;
    return anim;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    XFAnimatedTransitioning *anim = [[XFAnimatedTransitioning alloc] init];
    anim.presented = NO;
    anim.animationDuration = self.config ? self.config.animationDuration : 0.75;
    anim.transitionStyle = self.config ? self.config.transitionStyle : XFCoverTransitionStyleCoverRight2Left;
    return anim;
}

@end
