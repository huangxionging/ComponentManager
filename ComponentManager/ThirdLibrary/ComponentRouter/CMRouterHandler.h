//
//  CMRouterHandler.h
//  ComponentManager
//
//  Created by huangxiong on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CMRouterTask;
NS_ASSUME_NONNULL_BEGIN

@interface CMRouterHandler : NSObject

- (CMRouterTask *) handlerURL:(NSString *)urlString parameters:(id _Nullable)parameters;

/**
 通过路径处理对象

 @param obj 对象
 @param path 路径
 */
- (void)handlerObject:(id)obj forPath:(NSString *)path;

/**
 通过路径查询对象
 @param path 路径
 @return 对象
 */
- (id) handlerObjectForPath:(NSString *)path;


/**
 处理 block

 @param block block
 @param path 路径
 */
- (void)handlerBlock:(void(^)())block forPath:(NSString *)path;

/**
 处理类名

 @param className 类名
 @param path 路径
 */
- (void)handlerClass:(NSString *)className forPath:(NSString *)path;

/**
 通过 path 删除

 @param path 路径
 */
- (void)handlerRemoveForPath:(NSString *)path;

/**
 通过 path 查询

 @param path 路径
 */
- (BOOL)handlerExistForRouter:(NSString *)urlString;

/**
 处理目标对应的消息回调, 根据路径标识

 @param target 目标
 @param block 消息回调
 @param path 路径
 */
- (void)handlerTarget: (id) target messageBlock:(void(^)())messageBlock forPath:(NSString *)path;


@end

NS_ASSUME_NONNULL_END
