//
//  UINavigationController+NavTransition.m
//  FlycoSmart
//
//  Created by hss on 2017/10/10.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

#import "UINavigationController+NavTransition.h"
#import <objc/runtime.h>

#define navDefaultColor [UIColor clearColor]
#define IOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0
#define StatusH CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
@interface UINavigationController ()<UINavigationBarDelegate>

@end

@implementation UINavigationController (NavTransition)

+ (void)initialize
{
    if (self == [UINavigationController self]) {
        NSArray *arr = @[@"_updateInteractiveTransition:",@"popToViewController:animated:",@"popToRootViewControllerAnimated:"];
        for (NSString *str in arr) {
            NSString *new_str = [[@"cc_" stringByAppendingString:str] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method A = class_getInstanceMethod(self, NSSelectorFromString(str));
            Method B = class_getInstanceMethod(self, NSSelectorFromString(new_str));
            method_exchangeImplementations(A, B);
        }
    }
}

#pragma mark 交换的方法
- (void)cc_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *topVC = self.topViewController;
    if (topVC) {
        id <UIViewControllerTransitionCoordinator> transitionContext = topVC.transitionCoordinator;
        UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        UIColor *fromNavBackColor = fromVc.navBarBackgroundColor;
        UIColor *toNavBackColor = toVc.navBarBackgroundColor;
        UIColor *newNavBackColor = [self averageColorFromColor:fromNavBackColor toColor:toNavBackColor percent:percentComplete];
        [self.navigationBar cc_setBackgroundColor:newNavBackColor];
        
        [transitionContext notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            //动画结束是调用
            if (context.isCancelled) {
                //动作取消
                [self.navigationBar cc_setBackgroundColor:fromNavBackColor];
            }else{
                //动作完成
                [self.navigationBar cc_setBackgroundColor:toNavBackColor];
            }
        }];
    }
    [self cc_updateInteractiveTransition:percentComplete];
}

- (NSArray<UIViewController *> *)cc_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navBarBackgroundColor = viewController.navBarBackgroundColor;
    return [self cc_popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)cc_popToRootViewControllerAnimated:(BOOL)animated
{
    self.viewControllers[0].navBarBackgroundColor = self.viewControllers[0].navBarBackgroundColor;
    return [self cc_popToRootViewControllerAnimated:animated];
}
#pragma mark 代理
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *topVc = self.topViewController;
    id<UIViewControllerTransitionCoordinator> coor = topVc.transitionCoordinator;
    if (topVc && coor && coor.initiallyInteractive) {
        if (IOS10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        else{
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        return  YES;
    }
    
    int n = self.viewControllers.count >= navigationBar.items.count ? 2 : 1;
    UIViewController *popToVc = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVc animated:YES];
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item
{
    return YES;
}

- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations)(NSString *key) = ^(NSString *key){
    };
    
    if (context.isCancelled) {
        NSTimeInterval cancaleDuration = context.transitionDuration * context.percentComplete;
        [UIView animateWithDuration:cancaleDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }
    else{
        NSTimeInterval finishDuration = context.transitionDuration * (1 - context.percentComplete);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}
#pragma mark 私有方法
- (UIColor *)averageColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0.0;
    CGFloat fromGreen = 0.0;
    CGFloat fromBlue = 0.0;
    CGFloat fromAlpha = 0.0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0.0;
    CGFloat toGreen = 0.0;
    CGFloat toBlue = 0.0;
    CGFloat toAlpha = 0.0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat nowRed = fromRed + (toRed - fromRed) * percent;
    CGFloat nowGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat nowBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    
    return [UIColor colorWithRed:nowRed green:nowGreen blue:nowBlue alpha:nowAlpha];
}

@end

@implementation UIViewController (Smooth)

- (void)setNavBarBackgroundColor:(UIColor *)navBarBackgroundColor
{
    [self.navigationController.navigationBar cc_setBackgroundColor:navBarBackgroundColor];
    objc_setAssociatedObject(self, @selector(navBarBackgroundColor), navBarBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navBarBackgroundColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(navBarBackgroundColor));
    return color ? color : navDefaultColor;
}

@end

@implementation UINavigationBar (Awesome)
static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cc_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + StatusH)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [[self.subviews firstObject] insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}
@end
