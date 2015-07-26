//
//  XFPresentationController.m
//  XFCoverTransition
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFPresentationController.h"

@implementation XFPresentationController

// 显示大小
 - (CGRect)frameOfPresentedViewInContainerView
{
    return self.renderSize;
} 
// 开始展示
- (void)presentationTransitionWillBegin
{
    
    // 添加要展示的View到容器
    self.presentedView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.presentedView];
    
}
// 结束展示
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    [self.presentedView removeFromSuperview];
}
@end
