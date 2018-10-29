//
//  CMRouterManager.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterManager.h"
#import "CMDispatchMessageManager.h"
#import "CMRouterTask.h"
#import "CMRouterHandler.h"
#import "CMRouterStorage.h"

@interface CMRouterManager ()

@property (nonatomic, strong) CMRouterHandler *routerHandler;

//@property (nonatomic, strong) CMRouterStorage *routerStorage;

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
    });
    return routeManager;
}

- (void)registerTabBarController:(UITabBarController *)tabBarController forPath:(NSString *)path {
    [self.routerHandler handlerObject: tabBarController forPath: path];
}

- (void)registerNavigationController:(UINavigationController *)navigationController forPath:(NSString *)path {
    [self.routerHandler handlerObject: navigationController forPath: path];
}

- (void)router:(NSString *)urlString parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    id obj = [self.routerHandler handlerURL: urlString];
    CMRouterTask *task = [[CMRouterTask alloc] init];
//    task.
    [task invoke];
}


@end
