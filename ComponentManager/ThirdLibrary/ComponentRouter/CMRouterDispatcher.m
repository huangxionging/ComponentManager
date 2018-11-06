//
//  CMRouterDispatcher.m
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/6.
//  Copyright © 2018 xiaoli. All rights reserved.
//

#import "CMRouterDispatcher.h"

@implementation CMRouterDispatcher

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSDictionary *value = self.values[@"value"];
    if (value == nil) {
        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"该类不存在"}];
        if (failure) {
            failure(error);
        }
        return;
    }

    if ([value[@"type"] isEqualToString: @"class"]) {

    }
}

DEFAULT_DEALLOC

@end
