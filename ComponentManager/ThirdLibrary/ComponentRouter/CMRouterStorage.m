//
//  CMRouterStorage.m
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterStorage.h"

@implementation CMRouterStorage

- (NSMutableDictionary *)routerStorage {
    if (_routerStorage == nil) {
        _routerStorage = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _routerStorage;
}

- (NSMutableDictionary<NSString *,void (^)()> *)routerBlockStorage{
    if (_routerBlockStorage == nil) {
        _routerBlockStorage = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _routerBlockStorage;
}

- (NSMutableDictionary<NSString *,NSArray *> *)routerMessageBlockStorage {
    if (_routerMessageBlockStorage) {
        _routerMessageBlockStorage = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _routerMessageBlockStorage;
}

#pragma mark- 根据路径查询
- (id)queryValueForPath: (NSString *)path {
    id value =  nil;
    NSArray *propertyArray = [CMRouterStorage getProperties];
    // 过滤机制
    NSArray *valueArray = [propertyArray filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"SELF LIKE 'router*Storage'"]];
    if (valueArray.count > 0) {
        for (NSString *property in valueArray) {
            NSMutableDictionary *storage = [self valueForKey: property];
            if (storage[path]) {
                value = storage[path];
                break;
            }
        }
    }
    return value;
}

- (void)setValue:(NSDictionary *)value forKey:(NSString *)key {
    [self.routerStorage setValue: value forKey: key];
}




@end
