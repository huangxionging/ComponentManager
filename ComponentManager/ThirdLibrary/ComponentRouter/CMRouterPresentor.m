//
//  CMRouterPresentor.m
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterPresentor.h"
#import "TSBannerPopViewController.h"

@interface CMRouterPresentor ()

@property (nonatomic, weak) UIViewController *frontViewController;

@end

@implementation CMRouterPresentor


- (instancetype)initWithValue:(NSDictionary *)value {
    if (self = [super initWithValue:value]) {
            // 存放在参数部分中
        self.frontViewController = self.value[@"parameters"][@"front_page"];
        NSDictionary *urlParameters = self.value[@"url_parameters"];
            // 方法名存在
        if (urlParameters[@"method"]) { // 不空
            self.methodNoParameter =  [NSString stringWithFormat:@"%@WithFrontViewController:", urlParameters[@"method"]];
            self.methodNeedParameter = [NSString stringWithFormat:@"%@WithFrontViewController:parameters:", urlParameters[@"method"]];
            self.methodNeedCallback = [NSString stringWithFormat: @"%@WithFrontViewController:parameters:success:failure:", urlParameters[@"method"]];
        }
    }
    return self;
}

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {

    if (self.frontViewController == nil) {
        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"前台控制器不能为空"}];
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
                [NSClassFromString(self.className) routerWithFrontViewController: self.frontViewController parameters: self.parameters];
            } else {
                    // 类名不存在则是对象
                [self.frontViewController presentViewController: self.object animated: YES completion:^{
                    if (success) {
                        success(@{@"code": @"success", @"msg": @"模态成功"});
                    }
                }];
            }
        } else { // 需要使用自定义的导航方式
                 // 类方法存在则使用类方法, 不存在则使用实例方法. 不存在有 object 使用类方法的情况(自己写个符合规则的实例方法), 也不存在无 object, 使用实例方法的情况(自己在类方法中创建对象)
            id responder = self.className ? NSClassFromString(self.className) : self.object;
                // 能响应类方法, 第一种
            if ([responder respondsToSelector: NSSelectorFromString(self.methodNeedCallback)]) {
                [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNeedCallback, self.frontViewController, self.parameters, success, failure, nil];
            } else if ([responder respondsToSelector: NSSelectorFromString(self.methodNeedParameter)]) {
                [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNeedParameter, self.frontViewController, self.parameters, nil];
                if (success) {
                    success(@{@"code": @"success", @"msg": @"模态成功"});
                }
            } else if ([responder respondsToSelector: NSSelectorFromString(self.methodNoParameter)]) {
                [[CMDispatchManager shareManager] dispatchTarget: responder method: self.methodNoParameter, self.frontViewController, nil];
                if (success) {
                    success(@{@"code": @"success", @"msg": @"模态成功"});
                }
            }
        }

    }];

    // 根据参数 routerType 判断是 class 还是 object
    // 根据参数 method 和 callback 指定对应的方法, method 不填写, 则表示调用默认方式
    // 根据参数 callback 指定是否需要回调
    // 根据参数 parameter 设置对应的参数
    // 根据参数 front_page 指定之前的页面
}

@end

@implementation UIViewController (RouterPresentor)

+ (void)routerWithFrontViewController:(UIViewController *)frontViewController parameters:(id)parameters {
    UIViewController *viewController = [[[self class] alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
        // 如果有参数, 就配置参数
    if (parameters) {
        [viewController setParameters: parameters];
    }
    [frontViewController presentViewController: viewController animated: YES completion: nil];
}

@end
