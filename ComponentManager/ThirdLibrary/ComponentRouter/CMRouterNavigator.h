//
//  CMRouterNavigator.h
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CMRouterObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterNavigator : CMRouterObject

- (instancetype)initWithValue:(NSDictionary *)value;

@end

@interface UIViewController (RouterNavigator)
+ (void) routerWithNavigator:(UINavigationController *)navigationController parameters:(id)parameters;

- (void) setParameters:(id)parameters;
@end

NS_ASSUME_NONNULL_END
