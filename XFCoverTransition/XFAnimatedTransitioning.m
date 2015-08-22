//
//  XFAnimatedTransitioning.m
//  XFCoverTransition
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFAnimatedTransitioning.h"
#import "UIView+Extention.h"

//const CGFloat duration = 0.75;

@implementation XFAnimatedTransitioning

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.animationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *containerView = toView.superview;

        switch (self.transitionStyle) {
            case XFCoverTransitionStyleTop2Bottom: {
                toView.y = -containerView.height;
                break;
            }
            case XFCoverTransitionStyleBottom2Top: {
                toView.y = containerView.height;
                break;
            }
            case XFCoverTransitionStyleRight2Left: {
                toView.x = containerView.width;
                break;
            }
            case XFCoverTransitionStyleLeft2Right: {
                toView.x = -containerView.width;
                break;
            }
            case XFCoverTransitionStyleFlipY:{
                toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                break;
            }
            case XFCoverTransitionStyleFlipZ:{
                toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
                break;
            }
            default: {
                break;
            }
        }
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            switch (self.transitionStyle) {
                case XFCoverTransitionStyleTop2Bottom:
                case XFCoverTransitionStyleBottom2Top:{
                    toView.y = (containerView.height - toView.height) * 0.5;
                    break;
                }
                case XFCoverTransitionStyleRight2Left:
                case XFCoverTransitionStyleLeft2Right: {
                    toView.x = (containerView.width - toView.width) * 0.5;
                    break;
                }
                case XFCoverTransitionStyleFlipY:
                case XFCoverTransitionStyleFlipZ:
                {
                    toView.layer.transform = CATransform3DIdentity;
                    break;
                }
                default: {
                    break;
                }
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:self.animationDuration animations:^{
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            switch (self.transitionStyle) {
                case XFCoverTransitionStyleTop2Bottom: {
                    fromView.y = -fromView.height;
                    break;
                }
                case XFCoverTransitionStyleBottom2Top: {
                    fromView.y = fromView.height;
                    break;
                }
                case XFCoverTransitionStyleRight2Left: {
                    fromView.x = fromView.width;
                    break;
                }
                case XFCoverTransitionStyleLeft2Right: {
                    fromView.x = -fromView.width;
                    break;
                }
                case XFCoverTransitionStyleFlipY:{
                    fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, -1, 0, 0);
                    break;
                }
                case XFCoverTransitionStyleFlipZ:{
                    fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, -1, -1, 0);
                    break;
                }
                default: {
                    break;
                }
            }
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
