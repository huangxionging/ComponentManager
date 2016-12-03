//
//  CMShowHUDManager.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMShowHUDManager.h"
#import "MBProgressHUD.h"

@interface CMShowHUDManager ()

@property (nonatomic, assign) dispatch_queue_t globalQueue;

@end

@implementation CMShowHUDManager

#pragma mark- 默认的窗口 HUD
- (MBProgressHUD *) defaultWindowHUD {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: window animated: YES];
    return hud;
}

#pragma mark- 隐藏窗口 HUD
- (void) hideDefaultWindowHUD {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD HUDForView: window];
    [hud hideAnimated: YES];
}

#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMShowHUDManager *showHUDManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        showHUDManager = [[super alloc] init];
    });
    return showHUDManager;
}

#pragma mark- 全局队列
- (dispatch_queue_t)globalQueue {
    if (_globalQueue == nil) {
        _globalQueue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    }
    return _globalQueue;
}

#pragma mark- 展示信息, 带菊花
- (void)showHUDWith:(NSString *)message {
    // 在主线程中进行
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self defaultWindowHUD];
        if (message) {
            hud.label.text = message;
        }
    });
}

#pragma mark- 隐藏
- (void)hideHUD {
    __weak typeof(self)weakSelf = self;
    dispatch_async(weakSelf.globalQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideDefaultWindowHUD];
        });
    });
}

- (void)showHUDWith:(NSString *)message afterDelay:(NSTimeInterval)timeInterval {
    // 在主线程中进行
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self defaultWindowHUD];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        [hud hideAnimated:YES afterDelay: timeInterval];
    });
}

- (void)showErrorHUDWith:(NSString *)message afterDelay:(NSTimeInterval)timeInterval {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [self defaultWindowHUD];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = message;
        hud.label.textColor = [UIColor redColor];
        // Move to bottm center.
        [hud hideAnimated:YES afterDelay: timeInterval];
    });
}


@end
