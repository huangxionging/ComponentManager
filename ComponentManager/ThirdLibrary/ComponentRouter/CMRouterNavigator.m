//
//  CMRouterNavigator.m
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterNavigator.h"

@interface CMRouterNavigator ()

/**
 导航控制器
 */
@property (nonatomic, weak) UINavigationController *navigatior;

@end

@implementation CMRouterNavigator

- (instancetype)initWithValue:(NSDictionary *)value {
    if (self = [super initWithValue:value]) {
        // 存放在参数部分中
        self.navigatior = self.value[@"parameters"][@"navigator"];
        // 方法部分
        NSDictionary *urlParameters = self.value[@"url_parameters"];
        // 方法名存在
        if (urlParameters[@"method"]) { // 不空
            self.methodNoParameter = [NSString stringWithFormat:@"%@WithNavigator:", urlParameters[@"method"]];
            self.methodNeedParameter = [NSString stringWithFormat:@"%@WithNavigator:parameters:", urlParameters[@"method"]];
            self.methodNeedCallback = [NSString stringWithFormat: @"%@WithNavigator:parameters:success:failure:", urlParameters[@"method"]];
        }
    }
    return self;
}

- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    if (self.navigatior == nil) {
        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"导航控制器不能为空"}];
        if (failure) {
            failure(error);
        }
        return;
    }

    // 主线程执行
    [self dispatchAsyncMainQueue:^{
        // 默认为空
        if (!self.methodNeedParameter) {
            // 类名存在
            if (self.className) {
                [NSClassFromString(self.className) routerWithNavigator: self.navigatior parameters: self.parameters];
            } else {
                // 类名不存在则是对象
                [self.object setHidesBottomBarWhenPushed: YES];
                [self.navigatior pushViewController: self.object animated: YES];
            }
            if (success) {
                success(@{@"code": @"success", @"msg": @"导航成功"});
            }
        } else { // 需要使用自定义的导航方式
            // 类方法存在则使用类方法, 不存在则使用实例方法. 不存在有 object 使用类方法的情况(自己写个符合规则的实例方法), 也不存在无 object, 使用实例方法的情况(自己在类方法中创建对象)
            id responder = self.className ? NSClassFromString(self.className) : self.object;
                // 能响应类方法, 第一种
            if ([responder respondsToSelector: NSSelectorFromString(self.methodNeedCallback)]) {
                [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNeedCallback, self.navigatior, self.parameters, success, failure, nil];
            } else if ([responder respondsToSelector: NSSelectorFromString(self.methodNeedParameter)]) {
                [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNeedParameter, self.navigatior, self.parameters, nil];
                if (success) {
                    success(@{@"code": @"success", @"msg": @"导航成功"});
                }
            } else if ([responder respondsToSelector: NSSelectorFromString(self.methodNoParameter)]) {
                [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNoParameter, self.navigatior, nil];
                if (success) {
                    success(@{@"code": @"success", @"msg": @"导航成功"});
                }
            }
        }

    }];
}


DEFAULT_DEALLOC

@end

@implementation UIViewController (RouterNavigator)

+ (void)routerWithNavigator:(UINavigationController *)navigationController parameters:(id)parameters {
    UIViewController *viewController = [[[self class] alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
        // 如果有参数, 就配置参数
    if (parameters) {
        [viewController setParameters: parameters];
    }
    [navigationController pushViewController: viewController animated: YES];
}

- (void) setParameters:(id)parameters {

}

@end
