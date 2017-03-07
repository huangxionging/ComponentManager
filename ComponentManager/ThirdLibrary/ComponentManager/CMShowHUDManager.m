//
//  CMShowHUDManager.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMShowHUDManager.h"
#import "MBProgressHUD.h"
#import "CMViewControllerManager.h"


@interface CMShowHUDManager ()

@property (nonatomic, copy) void (^completion)(NSInteger index);

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
    MBProgressHUD *hud = [self defaultWindowHUD];
    if (message) {
        hud.label.text = message;
    }
}

#pragma mark- 隐藏
- (void)hideHUD {
    [self hideDefaultWindowHUD];
}

#pragma mark- 展示信息, 在指定间隔时间后隐藏
- (void)showHUDWith:(NSString *)message afterDelay:(NSTimeInterval)timeInterval {
    // 在主线程中进行
    MBProgressHUD *hud = [self defaultWindowHUD];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay: timeInterval];
}

- (void)showErrorHUDWith:(NSString *)message afterDelay:(NSTimeInterval)timeInterval {
    MBProgressHUD *hud = [self defaultWindowHUD];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.textColor = [UIColor redColor];
    // Move to bottm center.
    [hud hideAnimated:YES afterDelay: timeInterval];
}

- (void)showAlertErrorWith:(NSString *)title message:(NSString *)message {
    [self showAlertErrorWith: title message: message completed: nil];
}

- (void)showDimHUDWith:(NSString *)message {
    // 在主线程中进行
    
    MBProgressHUD *hud = [self defaultWindowHUD];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    if (message) {
        hud.label.text = message;
    }
}

#pragma mark- 带回调的警告框
- (void)showAlertErrorWith:(NSString *)title message:(NSString *)message  completed:(void (^)(NSInteger))completion {
    
    __weak typeof(self)weakSelf = self;
    weakSelf.completion = completion;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakSelf.completion) {
            weakSelf.completion(0);
        }
        [alertController dismissViewControllerAnimated: YES completion: nil];
    }]];
    [[CMViewControllerManager currentViewController] presentViewController: alertController animated: YES completion: nil];
    
}

#pragma mark- 展示多个 alert 选项
- (void)showAlertWith:(NSString *)title message:(NSString *)message actions:(NSArray<NSDictionary<NSString *,id> *> *)actions completed:(void (^)(NSInteger))completion {
    
    __weak typeof(self)weakSelf = self;
    weakSelf.completion = completion;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle: UIAlertControllerStyleAlert];
    
    [actions enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *diction = obj;
        NSString *title = diction[@"title"];
        UIAlertActionStyle style = [diction[@"style"] integerValue];
        [alertController addAction: [UIAlertAction actionWithTitle: title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (weakSelf.completion) {
                weakSelf.completion(idx);
            }
            [alertController dismissViewControllerAnimated: YES completion: nil];
        }]];
    }];
    [[CMViewControllerManager currentViewController] presentViewController: alertController animated: YES completion: nil];
    

}

#pragma mark- 展示 actionSheet
- (void)showActionSheetWith:(NSString *)title message:(NSString *)message actions:(NSArray<NSDictionary<NSString *,id> *> *)actions completed:(void (^)(NSInteger))completion {
    __weak typeof(self)weakSelf = self;
    weakSelf.completion = completion;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle: UIAlertControllerStyleActionSheet];
    
    [actions enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *diction = obj;
        NSString *title = diction[@"title"];
        UIAlertActionStyle style = [diction[@"style"] integerValue];
        [alertController addAction: [UIAlertAction actionWithTitle: title style:style handler:^(UIAlertAction * _Nonnull action) {
            if (weakSelf.completion) {
                weakSelf.completion(idx);
            }
            [alertController dismissViewControllerAnimated: YES completion: nil];
        }]];
    }];
    [[CMViewControllerManager currentViewController] presentViewController: alertController animated: YES completion: nil];

}

#pragma mark- 自定义视图
- (void)showViewHUD:(UIView *)view message:(NSString *)message {
    
    MBProgressHUD *hud = [self createHUDForView: view];
    if (message) {
        hud.label.text = message;
    }
}

- (void)hideViewHUD:(UIView *)view {
    [MBProgressHUD hideHUDForView: view animated: YES];
}

- (void)showViewHUD:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)timeInterval {
    MBProgressHUD *hud = [self createHUDForView: view];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:YES afterDelay: timeInterval];
}

- (void)showErrorViewHUD:(UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)timeInterval {
    MBProgressHUD *hud = [self createHUDForView: view];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.textColor = [UIColor redColor];
    [hud hideAnimated:YES afterDelay: timeInterval];
    
}

- (void)showViewDimHUD:(UIView *)view message:(NSString *)message {
    // 在主线程中进行
    MBProgressHUD *hud = [self createHUDForView: view];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    if (message) {
        hud.label.text = message;
    }
}

- (MBProgressHUD *) createHUDForView: (UIView *)view {
    // 先为 view 隐藏
    [self hideViewHUD: view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo: view animated: YES];
    return hud;
}

@end

