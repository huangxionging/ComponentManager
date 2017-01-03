//
//  CMPushManager.m
//  Hydrodent
//
//  Created by huangxiong on 2016/12/23.
//  Copyright © 2016年 xiaoli. All rights reserved.
//

#import "CMPushManager.h"

@implementation CMPushManager
#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMPushManager *pushManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushManager = [[super alloc] init];
    });
    return pushManager;
}
@end
