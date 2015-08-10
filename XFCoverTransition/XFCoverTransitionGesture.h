//
//  XFCoverTransitionGesture.h
//  XFCoverTransitionExample
//
//  Created by 付星 on 15/8/9.
//  Copyright (c) 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XFCTConfig;

@interface XFCoverTransitionGesture : NSObject
@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, weak) UIViewController *presentedViewController;

+ (instancetype)gestureWithPresentingVC:(UIViewController *)presentingVC presentedVC:(UIViewController *)presentedVC config:(XFCTConfig *)config;
@end
