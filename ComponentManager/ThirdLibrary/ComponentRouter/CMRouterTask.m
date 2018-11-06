//
//  CMRouterTask.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterTask.h"
#import "CMDispatchMessageManager.h"

@implementation CMRouterTask

- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
   self.object = [[CMDispatchMessageManager shareManager] dispatchReturnValueTarget: [self.taskClass alloc] method: @"initWithValue:", self.value, nil];
    [[CMDispatchMessageManager shareManager] dispatchTarget: self.object method: @"invokeWithSuccess:failure:", success, failure, nil];
}

DEFAULT_DEALLOC

@end
