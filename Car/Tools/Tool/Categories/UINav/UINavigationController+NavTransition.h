//
//  UINavigationController+NavTransition.h
//  FlycoSmart
//
//  Created by hss on 2017/10/10.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NavTransition)
@end

@interface UIViewController (Smooth)
@property (nonatomic, strong) UIColor *navBarBackgroundColor;
@end


@interface UINavigationBar (Awesome)
- (void)cc_setBackgroundColor:(UIColor *)backgroundColor;
@end
