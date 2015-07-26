# XFCoverTransition
Custom Modal transition between UIViewController,Make it more configurable
![XFCoverTransition usage1](./Doc/usage1.gif)
##Usage
First, add `#import "XFCoverTransition.h` to your UIViewController,the `XFPageViewController` is example of your presentedViewController,create `XFCoverTransitionManager` main class,using `XFCTConfig` class to config your transition.
```objc
 XFPageViewController *page = [[XFPageViewController alloc] init];
 page.modalPresentationStyle = UIModalPresentationCustom;
 XFCoverTransitionManager *mgr = [XFCoverTransitionManager sharedManager];
 mgr.config = [XFCTConfig configWithRenderRect:self.view.bounds animationDuration:2.0 transitionStyle:XFCoverTransitionStyleCoverTop2Bottom];
 page.transitioningDelegate = mgr;
 [self presentViewController:page animated:YES completion:nil];
```
