//
//  CMCameraManger.h
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/7.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 使用到的组件
 */
@class CMShowHUDManager, CMViewControllerManager;


/**
 相机操作
 */
@interface CMCameraAction : NSObject
/**
 当前的控制器
 */
@property (nonatomic, weak) UIViewController *viewController;


/**
 资源类型
 */
@property (nonatomic, assign) UIImagePickerControllerSourceType sourceType;


/**
 是否可编辑图片
 */
@property (nonatomic, assign) BOOL isEdit;


/**
 媒体类型数组
 */
@property(nonatomic, copy) NSArray<NSString *> *mediaTypes;
// kUTTypeImage


/**
 类方法创建 action

 @param viewController 要打开相机的当前控制器
 @param surceType 媒体类型
 @param isEdit 是否编辑图片
 @param infoBlock 完成回调
 @return action 对象
 */
+ (instancetype) actionWith: (UIViewController *)viewController souceType: (UIImagePickerControllerSourceType) surceType isEdit:(BOOL)isEdit finishPickingMediaWithInfo: (BOOL(^)(NSDictionary<NSString *,id> *info))infoBlock;

@end

@interface CMCameraManger : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


/**
 相机管理器

 @return 相机管理器对象
 */
+ (instancetype)manager;

/**
 通过配置 action 打开相机

 @param action 相机操作描述
 */
- (void) cameraWithAction: (CMCameraAction *)action;

@end
