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
        //        toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);

        switch (self.transitionStyle) {
            case XFCoverTransitionStyleCoverTop2Bottom: {
                toView.y = -toView.height;
                break;
            }
            case XFCoverTransitionStyleCoverRight2Left: {
                toView.x = toView.width;
                break;
            }
            default: {
                break;
            }
        }
        
        [UIView animateWithDuration:self.animationDuration animations:^{
            switch (self.transitionStyle) {
                case XFCoverTransitionStyleCoverTop2Bottom: {
                    toView.y = (containerView.height - toView.height) * 0.5;
                    break;
                }
                case XFCoverTransitionStyleCoverRight2Left: {
                    toView.x = (containerView.width - toView.width) * 0.5;
                    break;
                }
                default: {
                    break;
                }
            }
            //            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:self.animationDuration animations:^{
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            switch (self.transitionStyle) {
                case XFCoverTransitionStyleCoverTop2Bottom: {
                    fromView.y = -fromView.height;
                    break;
                }
                case XFCoverTransitionStyleCoverRight2Left: {
                    fromView.x = -fromView.width;
                    break;
                }
                default: {
                    break;
                }
            }
            //            fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
