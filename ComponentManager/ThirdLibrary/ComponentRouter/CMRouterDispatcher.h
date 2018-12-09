//
//  CMRouterDispatcher.h
//  Hydrodent
//
//  Created by huangxiong on 2018/11/6.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterDispatcher : CMRouterObject

/**
 参数名字
 */
@property (nonatomic, copy) NSString *methodName;

/**
 方法类型
 */
@property (nonatomic, copy) NSString *type;


@end

NS_ASSUME_NONNULL_END
