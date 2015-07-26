//
//  XFCTConfig.m
//  XFCoverTransitionExample
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFCTConfig.h"

@implementation XFCTConfig

+ (instancetype)configWithRenderSize:(CGRect)renderSize animationDuration:(CGFloat)animDuration transitionStyle:(XFCoverTransitionStyle)style
{
    XFCTConfig *config = [XFCTConfig new];
    config.renderSize = renderSize;
    config.animationDuration = animDuration;
    config.transitionStyle = style;
    return config;
}
@end
