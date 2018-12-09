//
//  CMRouterBlocker.m
//  Hydrodent
//
//  Created by huangxiong on 2018/11/6.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterBlocker.h"

@implementation CMRouterBlocker

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    void(^block)() = self.object;
    if (block == nil) {
        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"block为空"}];
        if (failure) {
            failure(error);
        }
        return;
    }
    id parameter = self.parameters;
    // 表示参数个数
    block(parameter, success, failure);
}

DEFAULT_DEALLOC

@end
