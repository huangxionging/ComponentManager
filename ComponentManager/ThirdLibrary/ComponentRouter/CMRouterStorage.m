//
//  CMRouterStorage.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
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

- (NSMutableDictionary<NSString *, __nullable id (^)(id _Nonnull, id _Nonnull)> *)routerBlockStorage {
    if (_routerBlockStorage == nil) {
        _routerBlockStorage = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _routerBlockStorage;
}

- (id)queryValueForPath: (NSString *)path {
    id value =  [self.routerStorage valueForKey: path];
    if (!value) {
        value = [self.routerBlockStorage valueForKeyPath: path];
    }
    return value;
}

- (void)setValue:(NSDictionary *)value forKey:(NSString *)key {
    [self.routerStorage setValue: value forKey: key];
}




@end
