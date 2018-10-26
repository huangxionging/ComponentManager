//
//  CMRouterHandler.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterHandler.h"
#import ""

@implementation CMRouterHandler

- (NSString *)handlerURL:(NSString *)url {
    if (![url containsString: @"://"]) {
        return nil;
    }

    NSArray *components = [url componentsSeparatedByString: @"://"];

    // 第一个元素为协议
    NSString *protocol = components.firstObject;
    

}

@end
