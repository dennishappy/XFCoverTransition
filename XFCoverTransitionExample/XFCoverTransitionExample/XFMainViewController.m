//
//  ViewController.m
//  XFCoverTransationExample
//
//  Created by Yizzuide on 15/7/25.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "XFMainViewController.h"
#import "XFPageViewController.h"
#import "XFCoverTransition.h"
#import "UIView+Extention.h"

@interface XFMainViewController ()

@property (nonatomic, strong) XFCoverTransitionGesture *ctGesture;
@end

@implementation XFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 全手势模拟modal效果
    /*XFPageViewController *page = [[XFPageViewController alloc] init];
    XFCTConfig *config = [XFCTConfig configWithRenderRect:self.view.bounds animationDuration:0.25 transitionStyle:XFCoverTransitionStyleTop2Bottom];
    self.ctGesture = [XFCoverTransitionGesture gestureWithPresentingViewController:self presentedViewController:page config:config];*/
}

- (IBAction)modalAction:(id)sender {
    // 自定义modal
    XFPageViewController *page = [[XFPageViewController alloc] init];
    page.modalPresentationStyle = UIModalPresentationCustom;
    XFCoverTransitionTouch *ctTouch = [XFCoverTransitionTouch sharedInstance];
    ctTouch.config = [XFCTConfig configWithRenderRect:self.view.bounds animationDuration:0.25 transitionStyle:XFCoverTransitionStyleRight2Left];
    // 添加手势移除支持
    ctTouch.config.onlyForModalVCGestureDissmiss = YES;
    page.transitioningDelegate = ctTouch;
    [self presentViewController:page animated:YES completion:nil];
}


@end
