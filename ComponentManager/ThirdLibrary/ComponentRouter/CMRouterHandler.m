//
//  CMRouterHandler.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterHandler.h"
#import "CMDispatchMessageManager.h"

@class CMRouterStorage, CMRouterTask;

@interface CMRouterHandler ()

@property (nonatomic, strong) CMRouterStorage *routerStorage;

@end

@implementation CMRouterHandler

- (CMRouterStorage *)routerStorage {
    if (_routerStorage == nil) {
        _routerStorage = [[NSClassFromString(@"CMRouterStorage") alloc] init];
    }
    return _routerStorage;
}


- (CMRouterTask *)handlerURL:(NSString *)url {
    if (![url containsString: @"://"]) {
        return nil;
    }

    NSArray *components = [url componentsSeparatedByString: @"://"];

    // 第一个元素为协
    NSString *protocol = components.firstObject;
    id value = [[CMDispatchMessageManager shareManager] dispatchReturnValueTarget: self.routerStorage method: @"queryValueForPath:", components.lastObject, nil];
    CMRouterTask *task = [[NSClassFromString(@"CMRouterTask") alloc] init];
    NSObject *obj = (NSObject *)task;
    [obj setValue: @"taskClass" forKey: value];
    NSLog(@"%@", value);
    return task;
}

- (void)handlerObject:(id)obj forPath:(NSString *)path {
    // 是 UITabBarController
    NSObject *routerStorage = (NSObject *)self.routerStorage;
    // 设置控制器
    [routerStorage setValue: obj forKey: path];
    if ([obj isKindOfClass: NSClassFromString(@"UITabBarController")]) {
        // 默认 tabBar
        [[CMDispatchMessageManager shareManager] dispatchTarget: routerStorage method: @"setCurrentTabBarController:", obj, nil];
    } else if ([obj isKindOfClass: NSClassFromString(@"UINaviagationController")]) {
        [[CMDispatchMessageManager shareManager] dispatchTarget: routerStorage method: @"setCurrentNavigationBarController:", obj, nil];
    } else if ([obj isKindOfClass: NSClassFromString(@"UIViewController")]) {
        [[CMDispatchMessageManager shareManager] dispatchTarget: routerStorage method: @"setCurrentTopViewController:", obj, nil];
    }
    NSLog(@"%@::", routerStorage);
}


@end
