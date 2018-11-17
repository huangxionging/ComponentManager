//
//  CMRouterNavigator.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterNavigator.h"

@implementation CMRouterNavigator



- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    UINavigationController *navigatior = self.values[@"navigatior"];
    if (navigatior == nil) {
        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"导航控制器不能为空"}];
        if (failure) {
            failure(error);
        }
        return;
    }
    NSDictionary *destinator = self.values[@"destinator"];
    NSDictionary *value = destinator[@"value"];
    NSDictionary *parameters = destinator[@"parameters"];
    NSLog(@"%@", value);
    if ([value[@"type"] isEqualToString: @"class"]) {
        NSString *className = value[@"value"];
        // 主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *viewController = [[NSClassFromString(className) alloc] init];
            [[CMDispatchMessageManager shareManager] dispatchTarget: viewController method: @"setParameters:", parameters, nil];
            viewController.hidesBottomBarWhenPushed = YES;
            [navigatior pushViewController: viewController animated: YES];
            if (success) {
                success(@{@"code": @"success", @"msg": @"导航成功"});
            }
        });
    }
}

- (void) push {
    NSObject *navigatior = self.values[@"navigatior"];


}

- (void) pop {
    NSObject *navigatior = self.values[@"navigatior"];
    NSObject *destinator = self.values[@"destinator"];


}

DEFAULT_DEALLOC

@end
