//
//  CMRouterObject.m
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/6.
//  Copyright © 2018 xiaoli. All rights reserved.
//

#import "CMRouterObject.h"

@implementation CMRouterObject

- (instancetype)initWithValue: (NSDictionary *)value{
    if (self = [super init]) {
        self.values = value;
    }
    return self;
}

- (void) invokeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
}
@end
