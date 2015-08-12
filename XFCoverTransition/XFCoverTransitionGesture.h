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
/**
 *  添加一个支持手势拖动modal控制器，创建这个实例要对其强引用，否则不会生效
 *
 *  @param presentingVC 当前显示的主控制器
 *  @param presentedVC  将要被modal出来的控制器
 *  @param config       配置信息
 */
+ (instancetype)gestureWithPresentingViewController:(UIViewController *)presentingVC presentedViewController:(UIViewController *)presentedVC config:(XFCTConfig *)config;
@end
