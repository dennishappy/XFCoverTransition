//
//  XFCoverTransitionManager.h
//  XFCoverTransition
//
//  Created by Yizzuide on 15/7/26.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@class XFCTConfig;

@interface XFCoverTransitionTouch : NSObject <UIViewControllerTransitioningDelegate>
SingletonH(Instance)

@property (nonatomic, strong) XFCTConfig *config;
@end
