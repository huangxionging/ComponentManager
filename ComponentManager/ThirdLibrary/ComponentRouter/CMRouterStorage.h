//
//  CMRouterStorage.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterStorage : NSObject

@property(nonatomic , strong) NSMutableDictionary *routerStorage;

/**
 当前的 tabBar 控制器
 */
@property (nonatomic, strong) UITabBarController *currentTabBarController;

/**
 当前的导航控制器
 */
@property (nonatomic, strong, nullable) UINavigationController *currentNavigationController;

/**
 当前最顶层的控制器
 */
@property (nonatomic, strong) UIViewController *currentTopViewController;

- (NSDictionary *)queryValueForPath: (NSString *)path;

@end

NS_ASSUME_NONNULL_END
