//
//  CMRouterTask.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMRouterObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterTask : NSObject

@property (nonatomic, strong) CMRouterObject *object;

/**
 执行的类
 */
@property (nonatomic, strong) Class taskClass;

/**
 参数
 */
@property (nonatomic, copy) NSDictionary *value;

/**
 成功回调
 */
@property (nonatomic, copy)void(^success)(id responseObject);

/**
 失败回调
 */
@property (nonatomic, copy)void(^failure)(NSError *error);

- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
