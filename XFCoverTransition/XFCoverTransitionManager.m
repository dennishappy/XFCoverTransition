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

@implementation XFCoverTransitionManager
SingletonM(Manager)

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[XFPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    XFAnimatedTransitioning *anim = [[XFAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    XFAnimatedTransitioning *anim = [[XFAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}

@end
