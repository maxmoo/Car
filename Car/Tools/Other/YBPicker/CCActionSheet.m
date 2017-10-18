//
//  CCActionSheet.m
//  CCActionSheet
//
//  Created by maxmoo on 16/1/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "CCActionSheet.h"

#define CC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define CC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define cellHeight 45
#define lastHeight (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + 25)
@interface CCActionSheet()

@property (nonatomic, strong) UIWindow *sheetWindow;
@property (nonatomic, strong) NSArray *selectArray;
@property (nonatomic, strong) NSString *cancelString;
@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (weak, nonatomic) id<CCActionSheetDelegate> delegate;


@end

@implementation CCActionSheet

+ (instancetype)shareSheet{
    static id shareSheet;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareSheet = [[[self class] alloc] init];
    });
    return shareSheet;
}

- (void)cc_actionSheetWithSelectArray:(NSArray *)array cancelTitle:(NSString *)cancel delegate:(id)delegate{
    
    self.selectArray = [NSArray arrayWithArray:array];
    self.cancelString = cancel;
    self.delegate = delegate;
    
    if (!_sheetWindow) {
        [self initSheetWindow];
    }
    _sheetWindow.hidden = NO;
    
    [self showSheetWithAnimation];
}

- (void)initSheetWindow{
    _sheetWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, CC_SCREEN_WIDTH, CC_SCREEN_HEIGHT)];
//    _sheetWindow.windowLevel = UIWindowLevelStatusBar;
    _sheetWindow.backgroundColor = [UIColor clearColor];
    
    _sheetWindow.hidden = YES;

    //zhezhao
    _backView = [[UIView alloc] initWithFrame:_sheetWindow.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.0;
    [_sheetWindow addSubview:_backView];
    
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    _tapGesture.numberOfTapsRequired = 1;
    [_backView addGestureRecognizer:_tapGesture];
    
    UIView *selectView = [self creatSelectButton];
    
    [_sheetWindow addSubview:selectView];
}


- (void)showSheetWithAnimation{
    CGFloat viewHeight = [self sheetHeight];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _sheetView.frame = CGRectMake(0, CC_SCREEN_HEIGHT - viewHeight, CC_SCREEN_WIDTH, viewHeight);
        _backView.alpha = 0.4;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidSheetWithAnimation{
    CGFloat viewHeight = [self sheetHeight];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _sheetView.frame = CGRectMake(0, CC_SCREEN_HEIGHT, CC_SCREEN_WIDTH, viewHeight);
        _backView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self hidActionSheet];
    }];
}
    
- (CGFloat)sheetHeight{
    CGFloat viewHeight = cellHeight * (self.selectArray.count) + 5 + (self.selectArray.count - 2) * 2 + lastHeight;
    return viewHeight;
}
    
- (UIView *)creatSelectButton{
    CGFloat viewHeight = [self sheetHeight];
    _sheetView = [[UIView alloc] initWithFrame:CGRectMake(0, CC_SCREEN_HEIGHT, CC_SCREEN_WIDTH, viewHeight)];
    _sheetView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    
    for (int i = 0; i < self.selectArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, i * (cellHeight+1), CC_SCREEN_WIDTH, cellHeight);
        [button setTitle:[NSString stringWithFormat:@"%@",self.selectArray[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_blank_0_3"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1001+i;
        [_sheetView addSubview:button];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, viewHeight - lastHeight, CC_SCREEN_WIDTH, cellHeight);
    cancelButton.backgroundColor = [UIColor whiteColor];
    [cancelButton setTitle:[NSString stringWithFormat:@"%@",self.cancelString] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"bg_blank_0_3"] forState:UIControlStateHighlighted];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(buttonSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tag = 1000;
    [_sheetView addSubview:cancelButton];
    
    return _sheetView;
}

- (void)buttonSelectAction:(UIButton *)btn{
    UIButton *button = (UIButton *)btn;
    NSInteger index = button.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cc_actionSheetDidSelectedIndex:)]) {
        [self.delegate cc_actionSheetDidSelectedIndex:index];
    }
    [self hidSheetWithAnimation];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self hidSheetWithAnimation];
}

- (void)hidActionSheet{
    _sheetWindow.hidden = YES;
    _sheetWindow = nil;
}

@end
