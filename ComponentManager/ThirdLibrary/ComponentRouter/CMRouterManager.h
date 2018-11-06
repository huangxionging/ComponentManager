//
//  CMRouterManager.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface CMRouterManager : NSObject

/**
 单例

 @return 共享单例
 */
+ (instancetype)shareManager;

//
///**
// 注册 标签导航控制器, 支持路由 url=switchTo://path
//
// @param tabBarController 标签控制器
// @param path 对应的路径
// */
//- (void) registerTabBarController: (UITabBarController *)tabBarController forPath: (NSString *)path;
//
///**
// 注册导航控制器, 支持路由 url=navigateTo://path
//
// @param navigationController 导航控制器
// @param path 对应的路径
// */
//- (void) registerNavigationController:(UINavigationController *)navigationController forPath:(NSString *)path;

/**
 注册控制器

 @param viewController 视图控制器
 @param path 对应的路径
 */
- (void) registerTopViewController:(UIViewController *)viewController forPath:(NSString *)path;


/**
  通过类名注册类

 @param className 类名
 @param path 路径
 */
- (void) registerClass:(NSString *)className forPath:(NSString *)path;

/**
 注册 block 回调

 @param block 回调, 支持路由协议 url=blockTo://path
 @param path 对应的路径
 */
- (void) registerBlock: (void(^)(id _Nullable responseObject, id _Nullable callBack))block forPath:(NSString *)path;

/**
 通过 类 URL 协议来访问数据

 @param urlString URL 协议地址, navigateTo:// 表示导航; presentTo:// 表示 Present, switchTo 表示 tabBar 切换
 @param parameters 携带的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) router:(NSString *)urlString parameters:(id _Nullable)parameters  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
