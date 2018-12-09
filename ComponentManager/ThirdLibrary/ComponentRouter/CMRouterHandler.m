//
//  CMRouterHandler.m
//  ComponentManager
//
//  Created by huangxiong on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterHandler.h"
#import "CMRouterStorage.h"
#import "CMRouterTask.h"

NSString *const routerProtocolInfo = @"navigateTo=CMRouterNavigator&presentTo=CMRouterPresentor&dispatchTo=CMRouterDispatcher&blockTo=CMRouterBlocker&switchTo=CMRouterSwitcher&messageTo=CMRouterMessager&moduleTo=CMRouterModuler";

@class CMRouterStorage, CMRouterTask;

@interface CMRouterHandler ()

@property (nonatomic, strong) CMRouterStorage *routerStorage;

@property (nonatomic, strong) NSMutableDictionary *routerProtocol;

@end

@implementation CMRouterHandler

- (CMRouterStorage *)routerStorage {
    if (_routerStorage == nil) {
        _routerStorage = [[CMRouterStorage alloc] init];
    }
    return _routerStorage;
}

- (NSDictionary *)routerProtocol {
    if (_routerProtocol == nil) {
        _routerProtocol = [NSMutableDictionary dictionaryWithDictionary:[self getParameterFromURL: routerProtocolInfo]];
    }
    return _routerProtocol;
}

/**
 注册自定义协议

 @param taskClassName 自定义协议处理的类名
 @param protocol 自定义协议名
 */
- (void)registerRouterTaskClassName:(NSString *)taskClassName forProtocol:(NSString *)protocol {
    [self.routerProtocol setObject: taskClassName forKey: protocol];
}


- (CMRouterTask *)handlerURL:(NSString *)urlString parameters:(id)parameters {

    NSDictionary * components = [self getComponentsFromURL: urlString];
    if (!components) {
        return nil;
    }
    // 第一个元素为协
    NSString *protocol = components[@"protocol"];

    // 从路径得到值部分
    id object = [self.routerStorage queryValueForPath: components[@"path"]];

    // 如果是模块协议就单独处理
    if ([protocol isEqualToString: @"moduleTo"]) {
        object = components[@"path"];
    }

    if (!object) {
        return nil;
    }
    // 创建值字典
    NSMutableDictionary *value = [NSMutableDictionary dictionaryWithCapacity: 5];
    // 值部分
    [value setObject: object forKey: @"router_value"];
    // url 参数部分
    [value setObject: components[@"parameters"] ? components[@"parameters"] : @{} forKey: @"url_parameters"];
    // 设置携带的参数部分
    [value setObject: parameters ? parameters : @{} forKey: @"parameters"];
    // navigateTo 需要单独处理, 没传 navigator 的情况
    if ([protocol isEqualToString: @"navigateTo"]) {
            // 参数部分
        id valueParam = value[@"parameters"];
        // 非 dictionary
        if (![valueParam isKindOfClass: [NSDictionary class]] || !parameters[@"navigator"]) {
            // 当前的导航栏存在
            if (self.routerStorage.currentNavigationController) {

                NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity: 2];

                // 是一个字典
                if ([valueParam isKindOfClass: [NSDictionary class]]) {
                    [param addEntriesFromDictionary: valueParam];
                } else {
                    // 添加额外的参数部分
                    [param setObject: valueParam forKey: @"extra"];
                }
                [param setObject: self.routerStorage.currentNavigationController forKey: @"navigator"];
                [value setObject: param forKey: @"parameters"];
            } else {
                return nil;
            }
        }
    } else if ([protocol isEqualToString: @"presentTo"]) { // 单独处理无 front_page的情况

            // 参数部分
        id valueParam = value[@"parameters"];
            // 非 dictionary
        if (![valueParam isKindOfClass: [NSDictionary class]] || !parameters[@"front_page"]) {
                // 当前控制器存在
            if (self.routerStorage.currentTopViewController) {

                NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity: 2];

                    // 是一个字典
                if ([valueParam isKindOfClass: [NSDictionary class]]) {
                    [param addEntriesFromDictionary: valueParam];
                } else {
                        // 添加额外的参数部分
                    [param setObject: valueParam forKey: @"extra"];
                }
                [param setObject: self.routerStorage.currentTopViewController forKey: @"front_page"];
                [value setObject: param forKey: @"parameters"];
            } else {
                return nil;
            }
        }
    }
    CMRouterTask *task = [[CMRouterTask alloc] init];
    NSString *className = self.routerProtocol[protocol];
    if (className == nil) {
        NSLog(@"您使用了不支持或者错误的协议名称!!!");
        return nil;
    }
    task.taskClass = NSClassFromString(className);
    task.value = value;
    return task;
}

#pragma mark- 设置键值对
- (void)handlerObject:(id)obj forPath:(NSString *)path {
    if (!obj || !path) {
        return;
    }
    [self.routerStorage.routerStorage setValue: obj forKey: path];
}

#pragma mark- 键值对获得值
- (id)handlerObjectForPath:(NSString *)path {
    return [self.routerStorage.routerStorage objectForKey: path];
}

#pragma mark- 处理类名
- (void)handlerClass:(NSString *)className forPath:(NSString *)path {

    if (!className || !path) {
        return;
    }
    [self.routerStorage setValue: className forKey: path];
}

#pragma mark- 处理 block
- (void)handlerBlock:(void(^)())block forPath:(NSString *)path; {
    // 已存在对应的值
    if (self.routerStorage.routerBlockStorage[path]) {
        return;
    }
    [self.routerStorage.routerBlockStorage setObject: block forKey: path];
}

#pragma mark- 删除item
- (void)handlerRemoveForPath:(NSString *)path {
    [self.routerStorage.routerStorage removeObjectForKey: path];
    [self.routerStorage.routerBlockStorage removeObjectForKey: path];
    [self.routerStorage.routerMessageBlockStorage removeObjectForKey: path];
}

- (BOOL)handlerExistForRouter:(NSString *)urlString {
    if (![urlString containsString: @"://"]) {
        urlString = [NSString stringWithFormat: @"XXX://%@", urlString];
    }
    NSDictionary * components = [self getComponentsFromURL: urlString];

        // 从路径得到值部分
    id object = [self.routerStorage queryValueForPath: components[@"path"]];
    if (!object) {
        return NO ;
    }
    return YES;
}

#pragma mark- 处理消息 block
- (void)handlerTarget:(id)target messageBlock:(void (^)())messageBlock forPath:(NSString *)path {
    if (!path) {
        return;
    }
    NSMutableArray *blockArray = (NSMutableArray *)self.routerStorage.routerMessageBlockStorage[path];
    if (!blockArray) {
        blockArray = [NSMutableArray arrayWithCapacity: 1];
        self.routerStorage.routerMessageBlockStorage[path] = blockArray;
    }
    [blockArray addObject: @{@"target": target?target:[NSNull null], @"messageBlock": messageBlock}];

}

- (NSDictionary *) getParameterFromURL: (NSString *)url {
        // 是否包含问号
    NSString *str = url;
    if (![url containsString: @"?"]) {
        str = [NSString stringWithFormat:@"url?%@", url];
    }
        // 切割 url 地址和参数
    NSArray<NSString *> *allComponents = [str componentsSeparatedByString: @"?"];
    if (allComponents.count == 2) {
            // 获得参数部分字符串
        NSString *parameterString = allComponents[1];
            // 通过 & 字符串切割成键值字符串数组
        NSArray<NSString *> * allParameters = [parameterString componentsSeparatedByString: @"&"];
        NSMutableDictionary *parameterData = [NSMutableDictionary dictionaryWithCapacity: 0];
            // 遍历该数组
        for(NSInteger index = 0; index < allParameters.count; ++index) {
            NSString *param = allParameters[index];
            if ([param containsString: @"="]) {
                    // 通过 = 字符串切割成 key 和 value
                NSArray<NSString *> *keyValues = [param componentsSeparatedByString: @"="];
                if (keyValues.count == 2) {
                    NSString *key = keyValues[0];
                    NSString *value = keyValues[1];
                        // 生成 key 对应的 value
                    parameterData[key] = value;
                }
            }
        }
        return parameterData;
    }
    return nil;
}

- (NSDictionary *)getComponentsFromURL:(NSString *)url {
        // 不是一个合法的 url
    if (![url containsString: @"://"]) {
        return nil;
    }
    NSMutableDictionary *componentData = [NSMutableDictionary dictionaryWithCapacity: 0];
        // 切割 url 地址和参数
    NSArray<NSString *> *allComponents = [url componentsSeparatedByString: @"://"];
        // 设置协议
    [componentData setObject: allComponents.firstObject forKey: @"protocol"];

        // 切割路径和参数部分
    NSArray<NSString *> *nonProtocols = [allComponents.lastObject componentsSeparatedByString: @"?"];
        // 路径
    [componentData setObject: nonProtocols.firstObject forKey: @"path"];

        // 包含参数
    if (nonProtocols.count == 2) {
            // 获得参数部分字符串
        NSString *parameterString = nonProtocols[1];
            // 通过 & 字符串切割成键值字符串数组
        NSArray<NSString *> * allParameters = [parameterString componentsSeparatedByString: @"&"];

        NSMutableDictionary *parameterData = [NSMutableDictionary dictionaryWithCapacity: 0];
            // 遍历该数组
        for(NSInteger index = 0; index < allParameters.count; ++index) {
            NSString *param = allParameters[index];
            if ([param containsString: @"="]) {
                    // 通过 = 字符串切割成 key 和 value
                NSArray<NSString *> *keyValues = [param componentsSeparatedByString: @"="];
                if (keyValues.count == 2) {
                    NSString *key = keyValues[0];
                    NSString *value = keyValues[1];
                        // 生成 key 对应的 value
                    parameterData[key] = value;
                }
            }
        }
            // 设置参数部分
        [componentData setObject: parameterData forKey: @"parameters"];
    }
    return componentData;
}

@end
