//
//  YBAreaPickerView.h
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YBPickerToolSelectSure  = 1,
    YBPickerToolSelectCancel = 2,
} YBPickerToolSelect;


typedef void (^YBPickerDidSelectBlock)(NSIndexPath *indexPath);
typedef void (^YBPickerToolBarActionBlock)(YBPickerToolSelect selectType);

@interface YBPickerTool : UIPickerView

+ (instancetype) share;
- (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(YBPickerToolBarActionBlock)didSelectBlock;
- (void)show:(NSArray<NSArray<NSString *> *> *)datas isRelation:(BOOL)relation valueChangeBlock:(YBPickerDidSelectBlock)valueChangeBlock didSelectBlock:(YBPickerToolBarActionBlock)didSelectBlock;
- (void)setSelect:(NSArray *)selectArray;

- (void)refresh:(NSArray<NSArray<NSString *> *> *)datas;

@end
