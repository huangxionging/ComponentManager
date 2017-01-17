//
//  CMScanQRCodeManager.m
//  ComponentManager
//
//  Created by huangxiong on 2017/1/16.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CMScanQRCodeManager.h"
#import "CMQRCodeManager.h"
#import "CMShowHUDManager.h"

@implementation CMScanAction

#pragma mark- 操作描述
+ (instancetype) actionWithScanView:(UIView *)scanView validRect:(CGRect)validRect actionBlock:(BOOL (^)(NSString *))actionBlock {
    CMScanAction *action = [[super alloc] init];
    if (action) {
        action.scanView = scanView;
        action.validRect = validRect;
        action.actionBlock = actionBlock;
    }
    return action;
}

@end

@interface CMScanQRCodeManager () <AVCaptureMetadataOutputObjectsDelegate>

/**
 操作
 */
@property(nonatomic, strong) CMScanAction *action;

/**
 捕捉会话
 */
@property(nonatomic, strong) AVCaptureSession *captureSession;

/**
 捕获设备
 */
@property(nonatomic, strong) AVCaptureDevice *captureDevice;

/**
 捕获设备输入
 */
@property(nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput;

/**
 捕获元数据输出
 */
@property(nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;

/**
 捕获视频预览层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

@end

@implementation CMScanQRCodeManager

#pragma mark- 管理器
+ (instancetype)manager {
    return [[super alloc] init];
}

#pragma mark- 检查授权状态
- (BOOL)cameraAvailable{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
    }
    return YES;
}

#pragma mark- 会话
- (AVCaptureSession *)captureSession {
    if (_captureSession == nil) {
        _captureSession = [[AVCaptureSession alloc] init];
        [_captureSession setSessionPreset: ([UIScreen mainScreen].bounds.size.height < 500) ? AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
        [_captureSession addInput: self.captureDeviceInput];
        [_captureSession addOutput: self.captureMetadataOutput];
    }
    return _captureSession;
}

#pragma mark- 设备
- (AVCaptureDevice *)captureDevice {
    if (_captureDevice == nil) {
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    }
    return _captureDevice;
}

#pragma mark- 输入
- (AVCaptureDeviceInput *)captureDeviceInput {
    if (_captureDeviceInput == nil) {
        NSError *error = nil;
        _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice: self.captureDevice error: &error];
        
        if (error) {
            NSLog(@"输入设备错误: %@", error);
        }
    }
    return _captureDeviceInput;
}

#pragma mark- 输出设备
- (AVCaptureMetadataOutput *)captureMetadataOutput {
    if (_captureMetadataOutput == nil) {
        _captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
        [_captureMetadataOutput setMetadataObjectsDelegate: self queue: dispatch_get_main_queue()];
    }
    return _captureMetadataOutput;
}

#pragma mark- 预览层
- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    if (_captureVideoPreviewLayer == nil) {
        // 连接会话
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession: self.captureSession];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _captureVideoPreviewLayer;
}

#pragma mark - 修改扫描 操作
- (void) modifyScanAction:(CMScanAction *)action {
    self.action = action;
    
    if (self.action) {
        // 添加层
        self.captureVideoPreviewLayer.frame = self.action.scanView.bounds;
        [self.action.scanView.layer insertSublayer: self.captureVideoPreviewLayer atIndex: 0];
        // 兼容条码 不能在创建 captureMetadataOutput 的时候设置
        // 需在 captureSession 添加了输出才行
        self.captureMetadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        CGRect scanRect = CGRectMake(self.action.validRect.origin.y / self.action.scanView.frame.size.height, self.action.validRect.origin.x / self.action.scanView.frame.size.width, self.action.validRect.size.height / self.action.scanView.frame.size.height, self.action.validRect.size.width / self.action.scanView.frame.size.width);
        self.captureMetadataOutput.rectOfInterest = scanRect;
        
        [self.captureSession startRunning];
    }
    
}

#pragma mark- 捕获代理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        [self stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        if (self.action.actionBlock) {
            BOOL done = self.action.actionBlock(metadataObject.stringValue);
            if(done) {
                return;
            }
        }
    }
}

#pragma mark- 开始运行
- (void)startRunning {
    if ([self cameraAvailable]) {
        [self.captureSession startRunning];
    }
}

#pragma mark- 停止运行
- (void)stopRunning {
    if ([self cameraAvailable]) {
        [self.captureSession stopRunning];
    }
}

#pragma mark- 播放声音和震动
- (void)playSoundWithPath:(NSString *)path {
    if (!path) {
        return;
    }
    // 播放声音
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&soundID);
    AudioServicesPlaySystemSound(soundID);
    // 播放震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
