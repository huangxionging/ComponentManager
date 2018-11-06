//
//  CMRouterHandler.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CMRouterTask;
NS_ASSUME_NONNULL_BEGIN

@interface CMRouterHandler : NSObject

- (CMRouterTask *) handlerURL:(NSString *)urlString parameters:(id _Nullable)parameters;

- (void)handlerObject:(id)obj forPath:(NSString *)path;


/**
 处理 block

 @param block block
 @param path 路径
 */
- (void)handlerBlock:(void(^)(id _Nullable responseObject, id _Nullable callBack))block forPath:(NSString *)path;

/**
 处理类名

 @param className 类名
 @param path 路径
 */
- (void)handlerClass:(NSString *)className forPath:(NSString *)path;


@end

NS_ASSUME_NONNULL_END
