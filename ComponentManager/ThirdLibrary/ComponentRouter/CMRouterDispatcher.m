//
//  CMRouterDispatcher.m
//  Hydrodent
//
//  Created by huangxiong on 2018/11/6.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterDispatcher.h"

@implementation CMRouterDispatcher

- (instancetype)initWithValue:(NSDictionary *)value {
    if (self = [super initWithValue:value]) {
        if (self = [super initWithValue:value]) {
            // 存放在参数部分中
            // 方法部分
            NSDictionary *urlParameters = self.value[@"url_parameters"];
            // 方法名存在
            if (urlParameters[@"method"]) { // 不空
                self.methodNoParameter = urlParameters[@"method"];
                self.methodNeedParameter = [NSString stringWithFormat:@"%@WithParameters:", urlParameters[@"method"]];
                self.methodNeedCallback = [NSString stringWithFormat: @"%@WithParameters:success:failure:", urlParameters[@"method"]];
            }
        }
    }
    return self;
}

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSDictionary *urlParameter = self.value[@"url_parameters"];
    id responder = nil;
        // 如果指定要访问类方法
    if (urlParameter[@"type"] && [urlParameter[@"type"] isEqualToString: @"class"])  {
        // 获得类名
        responder = self.className ? NSClassFromString(self.className) : [self.object class];
    } else { // 默认方法实例方法
        responder = self.object ? self.object : [[NSClassFromString(self.className) alloc] init];
    }
    // 能响应类方法, 第一种
    if ([responder respondsToSelector: NSSelectorFromString(self.methodNeedCallback)]) {
        [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNeedCallback, self.parameters, success, failure, nil];
    } else if ([responder respondsToSelector: NSSelectorFromString(self.methodNeedParameter)]) {
        [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNeedParameter, self.parameters, nil];
        if (success) {
            success(@{@"code": @"success", @"msg": @"调用成功"});
        }
    } else if ([responder respondsToSelector: NSSelectorFromString(self.methodNoParameter)]) {
        [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNoParameter, nil];
        if (success) {
            success(@{@"code": @"success", @"msg": @"调用成功"});
        }
    } else if ([responder respondsToSelector: NSSelectorFromString([NSString stringWithFormat: @"%@:", self.methodNoParameter])]) {
        [[CMDispatchManager shareManager] dispatchTarget: responder method: [NSString stringWithFormat: @"%@:", self.methodNoParameter], self.parameters, nil];
        if (success) {
            success(@{@"code": @"success", @"msg": @"调用成功"});
        }
    }

}

DEFAULT_DEALLOC

@end
