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

- (id)queryValueForPath: (NSString *)path {
    return [self.routerStorage valueForKey: path];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [self.routerStorage setValue: value forKey: key];
}




@end
