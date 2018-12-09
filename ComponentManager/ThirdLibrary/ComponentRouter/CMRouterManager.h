//
//  CMRouterManager.h
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


 /**
  参考 SDWebImage 源代码, 线程安全, 核心思想就是, 目标线程和当前线程一致, 就同步执行, 否则就异步执行

  @param queue 线程队列
  @param block block
  @return
  */

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
    block();\
} else {\
    dispatch_async(queue, block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif


@interface CMRouterManager : NSObject

/**
 单例

 @return 共享单例
 */
+ (instancetype)shareManager;


/**
 注册自定义协议

 @param taskClassName 处理的类名
 @param protocol 协议名
 */
- (void)registerRouterTaskClassName:(NSString *)taskClassName forProtocol:(NSString *)protocol;
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
 通过 path 删除对应的 item

 @param path 路径
 */
- (void) removeItemWithPath:(NSString *)path;

/**
 判断对应的路径存在与否

 @param path 路径
 @return bool 值
 */
- (BOOL) itemExistWithRouter:(NSString *)urlString;

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
 通过对象注册

 @param object 对象
 @param path 路径
 */
- (void) registerObject:(id)object forPath:(NSString *)path;


/**
 通过路径获得注册的对象

 @param path 路径
 @return 对象值
 */
- (id) objectForPath:(NSString *)path;


/**
 注册 block 回调

 @param block 回调, 支持路由协议 url=blockTo://path
 @param id 对应的路径
 */
- (void) registerBlock: (void(^)())block forPath:(NSString *)path;

/**
 为目标注册消息 block

 @param target 消息目标
 @param messageBlock 消息回调
 @param path 路径
 */
- (void) registerTarget: (id) target messageBlock:(void(^)())messageBlock forPath:(NSString *)path;

/**
 通过 类 URL 协议来访问数据

 @param urlString URL 协议地址, navigateTo:// 表示导航; presentTo:// 表示 Present, switchTo 表示 tabBar 切换
 @param parameters 携带的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) router:(NSString *)urlString parameters:(id _Nullable)parameters  success:(void (^_Nullable)(id _Nullable responseObject) )success failure:(void (^_Nullable)(NSError * _Nullable error))failure;


/**
 回到主线程去执行一段代码

 @param block 回到主线程执行的代码
 */
- (void) dispatchAsyncMainQueueBlock: (void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
