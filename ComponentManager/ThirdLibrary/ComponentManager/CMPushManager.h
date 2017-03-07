//
//  CMPushManager.h
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/23.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMPushManager : NSObject


/**
 默认管理器 单例
 
 @return 管理器对象
 */
+ (instancetype)shareManager;


/**
 为通知名称注册对象
 
 @param object 注册通知对象
 @param name 通知名称
 */
- (void) registerObject:(id) object forNotificationName: (NSString *)name;

/**
 发送通知

 @param name 通知名称
 @param userInfo 用户信息
 */
- (void) sendNotificationWithName: (NSString *)name userInfo: (NSDictionary *)userInfo;

@end
