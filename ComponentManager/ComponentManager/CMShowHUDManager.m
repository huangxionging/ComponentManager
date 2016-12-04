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

@end

@implementation CMShowHUDManager

#pragma mark- 默认的窗口 HUD
- (MBProgressHUD *) defaultWindowHUD {
    [self hideDefaultWindowHUD];
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
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideDefaultWindowHUD];
        });
    });
}

#pragma mark- 展示信息, 在指定间隔时间后隐藏
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
