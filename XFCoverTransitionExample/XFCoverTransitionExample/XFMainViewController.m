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
#import "XFCoverTransitionGesture.h"

@interface XFMainViewController ()

@property (nonatomic, strong) XFCoverTransitionGesture *ctGesture;
@end

@implementation XFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    XFPageViewController *page = [[XFPageViewController alloc] init];
    XFCTConfig *config = [XFCTConfig configWithRenderRect:self.view.bounds animationDuration:0.25 transitionStyle:XFCoverTransitionStyleCoverRight2Left];
    self.ctGesture = [XFCoverTransitionGesture gestureWithPresentingVC:self presentedVC:page config:config];
}

- (IBAction)modalAction:(id)sender {
    XFPageViewController *page = [[XFPageViewController alloc] init];
    page.modalPresentationStyle = UIModalPresentationCustom;
    XFCoverTransitionManager *mgr = [XFCoverTransitionManager sharedManager];
    mgr.config = [XFCTConfig configWithRenderRect:self.view.bounds animationDuration:0.75 transitionStyle:XFCoverTransitionStyleCoverRight2Left];
    page.transitioningDelegate = mgr;
    [self presentViewController:page animated:YES completion:nil];
    
}


@end
