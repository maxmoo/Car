//
//  YBAreaPickerView.m
//  XHGY_Agent
//
//  Created by 尚往文化 on 17/6/9.
//  Copyright © 2017年 YBing. All rights reserved.
//

#import "YBPickerTool.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define kBottomHeight (kPickerHeight + kToolBarHeight)
#define kPickerHeight 220
#define kToolBarHeight 40

@interface YBPickerTool ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) YBPickerTool *pickerView;

@property (nonatomic, copy) YBPickerToolBarActionBlock toolBarSelectBlock;
@property (nonatomic, copy) YBPickerDidSelectBlock dataChangeBlock;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *datas;
@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isRelation;

@end

@implementation YBPickerTool

static YBPickerTool *instance = nil;

+ (instancetype) share
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return instance ;
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

- (UIView *)bgView
{
    if (_bgView==nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        [_bgView addGestureRecognizer:tap];
        
        [_bgView addSubview:self.bottomView];
    }
    return _bgView;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH, kScreenW, kBottomHeight)];
        [self addSubview: [self centerHeighLightView]];
        [_bottomView addSubview:self];
        [_bottomView addSubview:self.toolBar];
    }
    
    return _bottomView;
}

- (UIView *)centerHeighLightView {
    
    UIView *hlView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, kScreenW - 10, 40)];
    hlView.center = CGPointMake(kScreenW/2, kPickerHeight/2);
    hlView.backgroundColor = [UIColor lightGrayColor];
    hlView.alpha = 0.3;
    hlView.layer.cornerRadius = hlView.bounds.size.height/2;
    hlView.layer.masksToBounds = YES;
    
    return hlView;
}

- (UIView *)toolBar
{
    if (_toolBar==nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kToolBarHeight)];
        _toolBar.backgroundColor = [UIColor colorWithRed:23/255.0f green:137/255.0f blue:235/255.0f alpha:1];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        finishBtn.frame = CGRectMake(kScreenW-70, 0, 70, _toolBar.bounds.size.height);
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        finishBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [finishBtn addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:finishBtn];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(0, 0, 70, _toolBar.bounds.size.height);
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_toolBar addSubview:cancelBtn];
    }
    return _toolBar;
}

- (void)finishClick:(UIButton *)btn
{
    if (self.toolBarSelectBlock) {
        if (self.datas.count) {
            self.toolBarSelectBlock(YBPickerToolSelectSure);
        }
    }
    [self close];
}

- (void)cancelAction:(UIButton *)btn
{
    if (self.toolBarSelectBlock) {
        self.toolBarSelectBlock(YBPickerToolSelectCancel);
    }
    [self close];
}

- (void)close
{

    [UIView animateWithDuration:0.3 animations:^{
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        _bottomView.frame = CGRectMake(0, kScreenH, kScreenW, kBottomHeight);
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
        [self.toolBar removeFromSuperview];
        self.toolBar = nil;
        self.bgView = nil;
        self.pickerView = nil;
        self.bottomView = nil;
    }];
}

- (void)show:(YBPickerTool *)pickerView
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self.bgView];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _bottomView.frame = CGRectMake(0, kScreenH - kBottomHeight, kScreenW, kBottomHeight);
    }];
}

- (void)show:(NSArray<NSArray<NSString *> *> *)datas didSelectBlock:(YBPickerToolBarActionBlock)didSelectBlock
{
    _pickerView = [[YBPickerTool alloc] initWithFrame:CGRectMake(0, kToolBarHeight, kScreenW, kPickerHeight)];
    _pickerView.toolBarSelectBlock = didSelectBlock;
    _pickerView.datas = datas;
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = _pickerView;
    _pickerView.dataSource = _pickerView;
    
    [_pickerView show:_pickerView];
}

- (void)show:(NSArray<NSArray<NSString *> *> *)datas isRelation:(BOOL)relation valueChangeBlock:(YBPickerDidSelectBlock)valueChangeBlock didSelectBlock:(YBPickerToolBarActionBlock)didSelectBlock{
    
    _pickerView= [[YBPickerTool alloc] initWithFrame:CGRectMake(0, kToolBarHeight, kScreenW, kPickerHeight)];
    _pickerView.isRelation = relation;
    _pickerView.toolBarSelectBlock = didSelectBlock;
    _pickerView.dataChangeBlock = valueChangeBlock;
    _pickerView.datas = datas;
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = _pickerView;
    _pickerView.dataSource = _pickerView;
    
    [_pickerView show:_pickerView];
}

- (void)refresh:(NSArray<NSArray<NSString *> *> *)datas{
    _pickerView.datas = datas;
    [_pickerView reloadAllComponents];
    for (int i = 1; i < datas.count; i++) {
        [[YBPickerTool share] selectRow:0 section:i];
    }
}

- (void)relation:(NSIndexPath *)indexPath{
    
    if (!self.isRelation) {
        return;
    }
    for (int i = 0; i < self.datas.count; i++) {
        if (i > indexPath.section) {
            [[YBPickerTool share] selectRow:0 section:i];
        }
    }
}

- (void)selectRow:(NSInteger)row section:(NSInteger)section{
    [_pickerView selectRow:row inComponent:section animated:YES];
}

- (void)setSelect:(NSArray<NSNumber *> *)selectArray{
    
    if (!_pickerView) {
        return;
    }
    
    for (int i = 0; i < selectArray.count; i ++) {
        NSInteger row = [selectArray[i] integerValue];
        [self selectRow:row section:i];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.datas.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas[component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.datas[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSIndexPath *changePath = [NSIndexPath indexPathForRow:row inSection:component];
    [self relation:changePath];
    self.dataChangeBlock(changePath);
}
@end
