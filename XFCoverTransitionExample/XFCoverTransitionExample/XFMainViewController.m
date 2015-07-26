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

@interface XFMainViewController ()

@end

@implementation XFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)modalAction:(id)sender {
    XFPageViewController *page = [[XFPageViewController alloc] init];
    page.modalPresentationStyle = UIModalPresentationCustom;
    XFCoverTransitionManager *mgr = [XFCoverTransitionManager sharedManager];
    mgr.config = [XFCTConfig configWithRenderRect:self.view.bounds animationDuration:0.75 transitionStyle:XFCoverTransitionStyleFlipZ];
    page.transitioningDelegate = mgr;
    [self presentViewController:page animated:YES completion:nil];
    
    
}


@end
