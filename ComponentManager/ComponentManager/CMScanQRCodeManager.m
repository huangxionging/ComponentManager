//
//  CMScanQRCodeManager.m
//  ComponentManager
//
//  Created by huangxiong on 2017/1/16.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import "CMScanQRCodeManager.h"
#import "CMShowHUDManager.h"

@implementation CMScanAction

#pragma mark- 操作描述
+ (instancetype) actionWithScanView:(UIView *)scanView validRect:(CGRect)validRect metadataObjectTypes:(NSArray *)metadataObjectTypes actionBlock:(BOOL (^)(NSString *))actionBlock {
    CMScanAction *action = [[super alloc] init];
    if (action) {
        action.scanView = scanView;
        action.validRect = validRect;
        action.actionBlock = actionBlock;
        action.metadataObjectTypes = metadataObjectTypes;
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
        if ([_captureSession canAddInput:self.captureDeviceInput]) {
            [_captureSession addInput: self.captureDeviceInput];
        }
        
        if ([_captureSession canAddOutput: self.captureMetadataOutput]) {
            [_captureSession addOutput: self.captureMetadataOutput];
        }
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
        NSSet *availableSet = [NSSet setWithArray: self.captureMetadataOutput.availableMetadataObjectTypes];
        NSSet *destinationSet = [NSSet setWithArray: self.action.metadataObjectTypes];
        if ([destinationSet isSubsetOfSet: availableSet]) {
            self.captureMetadataOutput.metadataObjectTypes = self.action.metadataObjectTypes;
        }
        
        [self.captureSession startRunning];
        // 设置有效扫描区域
        CGRect intertRect = [self.captureVideoPreviewLayer metadataOutputRectOfInterestForRect: self.action.validRect];
        self.captureMetadataOutput.rectOfInterest = intertRect;
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
                // 开始运行
                [self startRunning];
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

- (void)dealloc {
    NSLog(@"二维码扫描器挂了...挂了");
}

@end
