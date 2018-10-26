//
//  CMRouterManager.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterManager : NSObject

/**
 单例

 @return 共享单例
 */
+ (instancetype)shareManager;


/**
 通过 类 URL 协议来访问数据

 @param urlString URL 协议地址, navigateTo:// 表示导航; presentTo:// 表示 Present, /路径表示切换路径, 默认为当前控制器所在路径
 @param parameters 携带的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) router:(NSString *)urlString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
