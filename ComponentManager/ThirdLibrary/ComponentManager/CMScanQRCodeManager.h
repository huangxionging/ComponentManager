//
//  CMScanQRCodeManager.h
//  ComponentManager
//
//  Created by huangxiong on 2017/1/16.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface  CMScanAction : NSObject

/**
 媒体对象
 */
@property (nonatomic, copy) NSArray *metadataObjectTypes;

/**
 需要扫描的视图
 */
@property (nonatomic, strong) UIView *scanView;

/**
 合法有效扫描区域
 */
@property (nonatomic, assign) CGRect validRect;

/**
 扫描操作的回调
 */
@property (nonatomic, copy) BOOL(^actionBlock)(NSString *stringValue);


+ (instancetype) actionWithScanView: (UIView *)scanView validRect: (CGRect) validRect metadataObjectTypes:(NSArray *)metadataObjectTypes actionBlock:(BOOL(^)(NSString *stringValue))actionBlock;

@end

@interface CMScanQRCodeManager : NSObject

/**
 扫描管理器

 @return 管理器对象
 */
+ (instancetype) manager;

/**
 检查相机是否可用

 @return 是否可用
 */
- (BOOL)cameraAvailable;

/**
 修改操作

 @param action 操作描述
 */
- (void) modifyScanAction: (CMScanAction *)action;

/**
 开始运行
 */
- (void)startRunning;

/**
 停止运行
 */
- (void)stopRunning;

/**
 播放声音

 @param path 声音路径
 */
- (void) playSoundWithPath: (NSString *)path;


@end
