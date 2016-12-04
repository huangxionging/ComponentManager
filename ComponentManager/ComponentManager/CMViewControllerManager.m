//
//  CMViewControllerManager.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/4.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMViewControllerManager.h"

@implementation CMViewControllerManager

#pragma mark- 管理器
+ (instancetype)manager {
    CMViewControllerManager *manager = [[super alloc] init];
    return manager;
}

#pragma mark- 切换根控制器
- (void)togglesRootController:(UIViewController *)controller {
    // 在主线程里面执行
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        window.rootViewController = controller;
    });
}

@end
