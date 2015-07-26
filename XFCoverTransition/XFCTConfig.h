//
//  XFCTConfig.h
//  XFCoverTransitionExample
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XFCoverTransitionStyle) {
    XFCoverTransitionStyleCoverTop2Bottom = 0,
    XFCoverTransitionStyleCoverRight2Left = 1
};

@interface XFCTConfig : NSObject
@property (nonatomic, assign) CGRect renderSize;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) XFCoverTransitionStyle transitionStyle;

+ (instancetype)configWithRenderSize:(CGRect)renderSize animationDuration:(CGFloat)animDuration transitionStyle:(XFCoverTransitionStyle)style;
@end
