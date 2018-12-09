//
//  CMRouterTask.m
//  ComponentManager
//
//  Created by huangxiong on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterTask.h"
#import "CMDispatchManager.h"

@implementation CMRouterTask

- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
   self.object = [[CMDispatchManager shareManager] dispatchReturnValueTarget: [self.taskClass alloc] method: @"initWithValue:", self.value, nil];
    [[CMDispatchManager shareManager] dispatchTarget: self.object method: @"invokeWithSuccess:failure:", success, failure, nil];
}

DEFAULT_DEALLOC

@end
