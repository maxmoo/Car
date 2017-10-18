//
//  FKPhotoSelect.m
//  FlycoSmart
//
//  Created by hss on 2017/9/4.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

#import "FKPhotoSelect.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface FKPhotoSelect() <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,copy)ImageBlock imageBlock;
@property(nonatomic,assign)BOOL isEditing;

@end

@implementation FKPhotoSelect

+ (instancetype)share{
    
    static id share;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        share = [[[self class] alloc] init];
    });
    
    return share;
}

- (void)openPhotoWithType:(FKSelectType)type sender:(UIViewController *)sender image:(ImageBlock)image{
    [self openPhotoWithType:type isAllowsEditing:YES sender:sender image:image];
}

- (void)openPhotoWithType:(FKSelectType)type isAllowsEditing:(BOOL)isEditing sender:(UIViewController *)sender image:(ImageBlock)image{
    
    self.imageBlock = image;
    self.isEditing = isEditing;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = isEditing; //可编辑
    
    switch (type) {
        case FKSelectTypePhoto:
            //判断是否可以打开相册
            if ([self isPhotoLibrary]) {
                picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            }else{
                NSLog(@"无法打开相册");
                return;
            }
            break;
        case FKSelectTypeCamara:
            if ([self isCameravail]){
                //摄像头
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                NSLog(@"没有摄像头");
                return;
            }
            break;
    }
    
    //UIStatusBarStyleDefault
    //UIStatusBarStyleLightContent
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    [sender  presentViewController:picker animated:YES completion:nil];
}

//delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    NSString *mdeiaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mdeiaType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (!self.isEditing) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            SEL saveImage = @selector(ImageWasSaveSuccessfully:didFinishSavingWithError:contextInfo:);
            UIImageWriteToSavedPhotosAlbum(image, self, saveImage, nil);
        }
        self.imageBlock(image);
    }else{
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)ImageWasSaveSuccessfully:(UIImage *)paraImage didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary<NSString *,id> *)paraInfo{
    if (error == nil) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"%@",error);
    }
}

//判断相机是否可用
- (BOOL)isCameravail{
    return   [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
- (BOOL)isPhotoLibrary{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}


@end
