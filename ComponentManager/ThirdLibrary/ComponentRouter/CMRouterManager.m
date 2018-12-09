//
//  CMRouterManager.m
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterManager.h"
#import "CMDispatchManager.h"
#import "CMRouterTask.h"
#import "CMRouterHandler.h"
#import "CMRouterStorage.h"

@interface CMRouterManager ()

@property (nonatomic, strong) CMRouterHandler *routerHandler;

@property (nonatomic, strong) CMRouterTask *task;

@property (nonatomic,  strong) dispatch_queue_t routerQueue;

@end


@implementation CMRouterManager

- (CMRouterHandler *)routerHandler {
    if (_routerHandler == nil) {
        _routerHandler = [[CMRouterHandler alloc] init];
    }
    return _routerHandler;
}

#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMRouterManager *routeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routeManager = [[super alloc] init];
        // 创建并发队列
        routeManager.routerQueue = dispatch_queue_create("CMRouterManager", DISPATCH_QUEUE_CONCURRENT);
    });
    return routeManager;
}

- (void)registerRouterTaskClassName:(NSString *)taskClassName forProtocol:(NSString *)protocol {
    [[CMDispatchManager shareManager] dispatchTarget: self.routerHandler method: @"registerRouterTaskClassName:forProtocol:", taskClassName, protocol, nil];
}

//- (void)registerTabBarController:(UITabBarController *)tabBarController forPath:(NSString *)path {
//    [self.routerHandler handlerObject: tabBarController forPath: path];
//}
//
//- (void)registerNavigationController:(UINavigationController *)navigationController forPath:(NSString *)path {
//    [self.routerHandler handlerObject: navigationController forPath: path];
//}

- (void) registerTopViewController:(UIViewController *)viewController forPath:(NSString *)path {
//    [self.routerHandler handlerObject: viewController forPath: path];
    if (viewController) {
            // 标记当前控制器
        CMRouterStorage *storage = [self.routerHandler valueForKey: @"routerStorage"];
        storage.currentTopViewController = viewController;
            // 标记导航控制器
        storage.currentNavigationController = viewController.navigationController;
            // 标记标签控制器
        storage.currentTabBarController = viewController.tabBarController;
    }
}

- (void)registerBlock:(void(^)())block forPath:(NSString *)path{
    [self.routerHandler handlerBlock: block forPath: path];
}

- (void)registerObject:(id)object forPath:(NSString *)path {
    [self.routerHandler handlerObject: object forPath: path];
}

- (id)objectForPath:(NSString *)path {
    return [self.routerHandler handlerObjectForPath: path];
}

- (void)registerClass:(NSString *)className forPath:(NSString *)path {
    [self.routerHandler handlerClass: className forPath: path];
}

- (void)registerTarget:(id)target messageBlock:(void (^)())messageBlock forPath:(NSString *)path {
    [self.routerHandler handlerTarget: target messageBlock: messageBlock forPath: path];
}

- (void)removeItemWithPath:(NSString *)path {
    [self.routerHandler handlerRemoveForPath: path];
}

#pragma mark -判断路由是否存在
- (BOOL)itemExistWithRouter:(NSString *)urlString {
    return [self.routerHandler handlerExistForRouter: urlString];
}

#pragma mark -在并发队列, 执行代码
- (void)router:(NSString *)urlString parameters:(id)parameters success:(void (^_Nullable)(id _Nullable))success failure:(void (^_Nullable)(NSError * _Nullable))failure{

    void (^block)() = ^(){
        CMRouterTask *task = [self.routerHandler handlerURL: urlString parameters: parameters];
        task.success = success;
        task.failure = failure;
        [task invokeWithSuccess:success failure:failure];
    };
    // 路由协议使用主线程同步执行
    if ([urlString hasPrefix: @"moduleTo"]) {
         [self dispatchAsyncMainQueueBlock: block];
    } else {
        // 其他协议使用路由线程执行
        [self dispatchAsyncRouterQueueBlock: block];
    }
}

#pragma mark- 路由线程执行
- (void)dispatchAsyncRouterQueueBlock:(void (^)(void))block {
    dispatch_queue_async_safe(self.routerQueue, block);
}

#pragma mark -回到主线程
- (void)dispatchAsyncMainQueueBlock:(void (^)(void))block {
    dispatch_main_async_safe(block);
}

@end
