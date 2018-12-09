//
//  CMRouterModuler.m
//  32TeethProtector
//
//  Created by 黄雄 on 2018/12/9.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterModuler.h"

@interface CMRouterModuler ()

/**
 文件名
 */
@property (nonatomic, copy) NSString *fileName;

@end

@implementation CMRouterModuler

- (instancetype)initWithValue:(NSDictionary *)value {
    if (self = [super initWithValue:value]) {
        // 得到文件名
        self.fileName = self.className;
    }
    return self;
}

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
//    [[CMRouterManager shareManager] dispatchAsyncMainQueueBlock:^{
//        [UIApplication sharedApplication].delegate.window.rootViewController = [[UIViewController alloc] init];
//    }];

}


@end
