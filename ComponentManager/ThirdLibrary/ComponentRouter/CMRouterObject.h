//
//  CMRouterObject.h
//  Hydrodent
//
//  Created by huangxiong on 2018/11/6.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CMDispatchManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterObject : NSObject

@property (nonatomic, copy) NSDictionary *value;

/**
 正常的方法, 有一个参数, 含导航栏
 */
@property (nonatomic, copy) NSString *methodNeedParameter;

/**
 方法前缀, 无参数部分, 含导航栏
 */
@property (nonatomic, copy) NSString *methodNoParameter;

/**
 完整的方法, 有回调 含导航栏
 */
@property (nonatomic, copy) NSString *methodNeedCallback;


/**
 类名
 */
@property (nonatomic, copy, nullable) NSString *className;

/**
 对象
 */
@property (nonatomic, strong) id object;

/**
 参数
 */
@property (nonatomic, strong) id parameters;

/**
 存储参数信息

 @param value 值
 @return 对象
 */
- (instancetype)initWithValue: (NSDictionary *)value;

/**
 调用导航方法

 @param success 成功回调
 @param failure 失败回调
 */
- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
