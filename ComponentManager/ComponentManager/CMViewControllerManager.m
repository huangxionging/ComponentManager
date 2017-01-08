//
//  CMViewControllerManager.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/4.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMViewControllerManager.h"
#import <libxml2/libxml/HTMLparser.h>

@implementation CMViewControllerManager

#pragma mark- 管理器
+ (instancetype)manager {
    CMViewControllerManager *manager = [[super alloc] init];
    return manager;
}

#pragma mark- 切换根控制器
+ (void)togglesRootController:(UIViewController *)controller {
    // 在主线程里面执行
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        window.rootViewController = controller;
    });
}

#pragma mark- 从故事版获取控制器
+ (UIViewController *)viewControllerFromStoryboard:(NSString *)storyboardKey identifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: storyboardKey bundle: nil];
    return [storyboard instantiateViewControllerWithIdentifier: identifier];
}

#pragma mark---获取当前顶层视图控制器
+ (UIViewController *)currentViewController {
    UIViewController *result = nil;
    
    // 获取住窗口
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    // 如果主窗口不是普通的窗口则执行if语句
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        // 遍历窗口找到窗口
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    // 获得窗口的第一个子视图
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    // 先判断 UITransitionView
    NSString *classString = NSStringFromClass([frontView class]);
    if ([classString isEqualToString: @"UITransitionView"]) {
        NSLog(@"%@", frontView);
        if (frontView.subviews.count != 0) {
            frontView = frontView.subviews[0];
        }
    }
    
    // 得到其响应者
    id nextResponder = [frontView nextResponder];
    
    // 获取最上层的控制器
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }
    else {
        result = window.rootViewController;
    }
    
    return result;
}



- (void)setviewController:(UIViewController *)controller backTitle:(NSString *)title {
    if (controller.navigationController) {
        controller.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: title style:UIBarButtonItemStylePlain target: nil action: nil];
    }
}

@end
