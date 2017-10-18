//
//  FKPhotoSelect.h
//  FlycoSmart
//
//  Created by hss on 2017/9/4.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef  void(^ImageBlock)(UIImage *image);

@interface FKPhotoSelect : NSObject

typedef enum : NSUInteger {
    FKSelectTypePhoto   = 0,
    FKSelectTypeCamara  = 1,
} FKSelectType;

+ (instancetype)share;

- (void)openPhotoWithType:(FKSelectType)type sender:(UIViewController *)sender image:(ImageBlock)image;
- (void)openPhotoWithType:(FKSelectType)type isAllowsEditing:(BOOL)isEditing sender:(UIViewController *)sender image:(ImageBlock)image;

@end
