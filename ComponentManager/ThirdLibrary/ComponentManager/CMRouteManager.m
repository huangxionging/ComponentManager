//
//  CMRouteManager.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouteManager.h"

@implementation CMRouteManager
#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMStringManager *stringManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stringManager = [[super alloc] init];
    });
    return stringManager;
}


@end
