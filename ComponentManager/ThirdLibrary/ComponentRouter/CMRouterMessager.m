//
//  CMRouterMessager.m
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/26.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterMessager.h"

@implementation CMRouterMessager

- (instancetype)initWithValue:(NSDictionary *)value {
    if (self = [super initWithValue:value]) {
            // 方法部分
        NSDictionary *urlParameters = self.value[@"url_parameters"];
            // 方法名存在
        if (urlParameters[@"target"]) { // 不空
            // 从路由管理器里读取目标 target
            self.target = [[CMRouterManager shareManager] objectForPath: urlParameters[@"target"]];
        }
    }
    return self;
}

- (void)invokeWithSuccess:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    NSArray *blockArray = self.object;
    if (blockArray == nil) {
        NSError *error = [NSError errorWithDomain: NSStringFromClass([self class]) code: 10001 userInfo: @{NSLocalizedDescriptionKey : @"消息体为空"}];
        if (failure) {
            failure(error);
        }
        return;
    }
    id parameter = self.parameters;
    NSArray *messageArray = blockArray;
    if (self.target) {
        // 过滤 target
       messageArray = [blockArray filteredArrayUsingPredicate: [NSPredicate predicateWithFormat: @"SELF.target==%@",self.target]];
    }
    // 开启多线程执行
    dispatch_queue_t queue = dispatch_queue_create("CMRouterMessager", DISPATCH_QUEUE_CONCURRENT);
    for (NSDictionary *messageDiction in messageArray) {
        dispatch_async(queue, ^{
            void(^block)() = messageDiction[@"messageBlock"];
            block(parameter, success, failure);
        });
    }
}
@end
