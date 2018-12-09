//
//  CMRouterObject.m
//  Hydrodent
//
//  Created by huangxiong on 2018/11/6.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterObject.h"

@implementation CMRouterObject

- (instancetype)initWithValue: (NSDictionary *)value{
    if (self = [super init]) {
        self.value = value;
        // 分离参数
        id parameters = self.value[@"parameters"];
        if ([parameters isKindOfClass: [NSDictionary class]]) {
            // 如果附带了额外的参数
            if(parameters[@"extra"]) {
                self.parameters = parameters[@"extra"];
            } else {
                // 没有附带额外的参数
                self.parameters = parameters;
            }

        } else {
            // 如果不是一个字典
            self.parameters = parameters;
        }

            // 分离类名和对象
        id object = self.value[@"router_value"];
        if ([object isKindOfClass: [NSString class]]) {
            self.className = object;
        } else {
            self.object = object;
            self.className = nil;
        }
    }
    return self;
}

- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
}
@end
