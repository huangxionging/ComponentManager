//
//  CMCameraManger.m
//  Hydrodent
//
//  Created by huangxiong on 2016/12/7.
//  Copyright © 2016年 xiaoli. All rights reserved.
//

#import "CMCameraManger.h"
#import "CMShowHUDManager.h"
#import "CMImageManager.h"


@interface CMCameraAction ()

@property (nonatomic, copy) BOOL(^infoBlock)(NSDictionary<NSString *,id> * info);

@end

@implementation CMCameraAction

+ (instancetype)actionWith:(UIViewController *)viewController souceType:(UIImagePickerControllerSourceType)surceType isEdit:(BOOL)isEdit finishPickingMediaWithInfo:(BOOL (^)(NSDictionary<NSString *,id> *))infoBlock {
    CMCameraAction *action = [[super alloc] init];
    if (action) {
        action.viewController = viewController;
        action.sourceType = surceType;
        action.isEdit = isEdit;
        action.infoBlock = infoBlock;
    }
    return action;
}

@end

@interface CMCameraManger ()<UIImagePickerControllerDelegate>
/**
 相机操作
 */
@property (nonatomic, strong) CMCameraAction *acton;

/**
 相机控制器
 */
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation CMCameraManger

+ (instancetype)manager {
    CMCameraManger *manager = [[super alloc] init];
    return manager;
}

#pragma mark- 通过 action 控制器相机
- (void)cameraWithAction:(CMCameraAction *)action {
    self.acton = action;
    
    switch (self.acton.sourceType) {
        case UIImagePickerControllerSourceTypeCamera: {
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                [[CMShowHUDManager shareManager] showAlertErrorWith: @"警告" message: @"相机不可用, 请去设置打开相关权限"];
                return;
            }
            break;
        }
            
        default:
            break;
    }
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = self.acton.sourceType;
    self.imagePickerController.allowsEditing = self.acton.isEdit;
    self.imagePickerController.delegate = self;
    // 拍摄视频
    if (self.acton.mediaTypes) {
        self.imagePickerController.mediaTypes = self.acton.mediaTypes;

    }
    [self.acton.viewController presentViewController: self.imagePickerController animated: YES completion:^{
        
    }];
    
}

#pragma mark- UIImagePickerControllerDelegate
#pragma mark- 取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated: YES completion:^{
        
    }];
}

#pragma mark- 完成选择
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 保存到相册里面
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        CMImageManager *imageManager = [CMImageManager manager];
        imageManager.image = [info objectForKey: UIImagePickerControllerOriginalImage];
        UIImage *originalImage = [imageManager fixOrientation];
        
        UIImageWriteToSavedPhotosAlbum(originalImage, self,  @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    if (self.acton.infoBlock) {
        BOOL finisehd = self.acton.infoBlock(info);
        if (finisehd) {
            [picker dismissViewControllerAnimated: YES completion:^{
                
            }];
        } else{
            [picker dismissViewControllerAnimated: YES completion:^{
                
            }];
        }
    }
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    return;
}


- (void)dealloc {
    NSLog(@"CMImageManager: 挂了----挂了");
}
@end
