//
//  CMPushManager.m
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/23.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMPushManager.h"

@interface CMPushManager ()

/**
 推送对象通知
 */
@property (nonatomic, strong) NSMutableDictionary <id , NSString *> *objectNotification;

@end

@implementation CMPushManager

#pragma mark- 推送通知
- (NSMutableDictionary<id,NSString *> *)objectNotification {
    if (_objectNotification == nil) {
        _objectNotification = [NSMutableDictionary dictionaryWithCapacity: 10];
    }
    return _objectNotification;
}

#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMPushManager *pushManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushManager = [[super alloc] init];
    });
    return pushManager;
}

#pragma mark- 注册通知对象
- (void) registerObject:(id)object forNotificationName:(NSString *)name {
    NSAssert(name, @"name不能为空");
    NSAssert(object, @"object不能为空");
    if (self.objectNotification[name]) {
        NSLog(@"该通知已被注册");
    } else {
        [self.objectNotification setObject: object forKey: name];
    }
}

- (void)sendNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName: name object: nil userInfo: userInfo];
}
@end
