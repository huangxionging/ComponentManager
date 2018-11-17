//
//  CMRouterBlocker.m
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/6.
//  Copyright © 2018 xiaoli. All rights reserved.
//

#import "CMRouterBlocker.h"

@implementation CMRouterBlocker

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {

//    NSDictionary *value = self.values[@"value"];
//    if (value == nil) {
//        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"该回调不存在"}];
//        if (failure) {
//            failure(error);
//        }
//        return;
//    }
    NSLog(@"%@", self);
    id (^block)() = self.values[@"value"];
//    id parameter = self.values[@"parameters"];
        // 表示参数个数
    block(@"dd", nil);
//    if ([value[@"type"] isEqualToString: @"block"]) {
//
//    }

}

DEFAULT_DEALLOC

@end
