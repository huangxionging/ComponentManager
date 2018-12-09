//
//  CMRouterModuler.h
//  32TeethProtector
//
//  Created by 黄雄 on 2018/12/9.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 支持协议 moduleTo://xxx.plist 或 moduleTo://xxx.json, 两种格式
 新增路由模块管理器, 就是专门用来配置 AppDelegate 的 window.rootViewController
 支持 UITabBarController 及其子类, UINavigationController 及其子类, 或者普通的 UIViewController 及其子类
 仅支持 plist/json 两种类型的文件配置.
 */
@interface CMRouterModuler : CMRouterObject

@end

NS_ASSUME_NONNULL_END
