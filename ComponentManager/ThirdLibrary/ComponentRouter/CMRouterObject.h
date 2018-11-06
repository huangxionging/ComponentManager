//
//  CMRouterObject.h
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/6.
//  Copyright © 2018 xiaoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CMDispatchMessageManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterObject : NSObject

@property (nonatomic, copy) NSDictionary *values;

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
