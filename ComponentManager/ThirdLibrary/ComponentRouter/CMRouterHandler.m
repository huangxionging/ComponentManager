//
//  CMRouterHandler.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterHandler.h"
#import "CMRouterStorage.h"
#import "CMRouterTask.h"


@class CMRouterStorage, CMRouterTask;

@interface CMRouterHandler ()

@property (nonatomic, strong) CMRouterStorage *routerStorage;

@end

@implementation CMRouterHandler

- (CMRouterStorage *)routerStorage {
    if (_routerStorage == nil) {
        _routerStorage = [[CMRouterStorage alloc] init];
    }
    return _routerStorage;
}
- (CMRouterTask *)handlerURL:(NSString *)urlString parameters:(id)parameters {
    if (![urlString containsString: @"://"]) {
        return nil;
    }

    NSArray *components = [urlString componentsSeparatedByString: @"://"];

    // 第一个元素为协
    NSString *protocol = components.firstObject;
    NSDictionary *value =  [self.routerStorage queryValueForPath: components.lastObject];

    if (value == nil) {
        return nil;
    }
    CMRouterTask *task = [[CMRouterTask alloc] init];
    // 导航
    if ([protocol isEqualToString: @"navigateTo"]) {
        task.taskClass = NSClassFromString(@"CMRouterNavigator");
        // 交代目标信息
        task.value = @{@"navigatior": self.routerStorage.currentNavigationController,
                       @"destinator": @{@"parameters": parameters?parameters:@{}, @"value": value}};
    } else if ([protocol isEqualToString: @"presentTo"]) {

    } else if ([protocol isEqualToString: @"switchTo"]) {

    } else if ([protocol isEqualToString: @"dispatchTo"]) {
        task.taskClass = NSClassFromString(@"CMRouterDispatcher");
        task.value = @{@"parameters": parameters?parameters:@{}, @"value": value};
    } else if ([protocol isEqualToString: @"blockTo"]) {
        task.taskClass = NSClassFromString(@"CMRouterBlocker");
        task.value = @{@"parameters": parameters?parameters:@{}, @"value": value};
    }
    return task;
}

- (void)handlerObject:(id)obj forPath:(NSString *)path {
    // 是 UITabBarController
    // 设置控制器

    if ([obj isKindOfClass: [UIViewController class]]) {
        // 标记当前控制器
        self.routerStorage.currentTopViewController = obj;
        // 标记导航控制器
         self.routerStorage.currentNavigationController = self.routerStorage.currentTopViewController.navigationController;
        // 标记标签控制器
        self.routerStorage.currentTabBarController = self.routerStorage.currentTopViewController.tabBarController;
    } else {
        [self.routerStorage setValue: @{@"type": @"Object",@"value": obj} forKey: path];
    }
}

- (void)handlerClass:(NSString *)className forPath:(NSString *)path {
    [self.routerStorage setValue: @{@"type":@"class", @"value": className} forKey: path];
}

- (void)handlerBlock:(id _Nullable(^)(id _Nullable responseObject, id _Nullable callBack))block forPath:(NSString *)path; {
//    [self.routerStorage setValue: @{@"type":@"block", @"value": block} forKey: path];
    [self.routerStorage.routerBlockStorage setObject: block forKey: path];
}


@end
