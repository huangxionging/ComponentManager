//
//  CMShowHUDManager.h
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 必须要引入的框架
 */
@class MBProgressHUD;



/**
 简单的基于 UIWindow 的 HUD 管理器
 */
@interface CMShowHUDManager : NSObject

/**
 默认管理器 单例

 @return 管理器对象
 */
+ (instancetype)shareManager;

/**
 展示信息, 隐藏需自己控制, 这个带菊花转

 @param message 文本信息, 可空,
 */
- (void)showHUDWith:(NSString *)message;

/**
 隐藏 HUD
 */
- (void)hideHUD;;

/**
 普通的展示文本

 @param message 文本消息
 @param timeInterval 间隔时间
 */
- (void)showHUDWith:(NSString *)message afterDelay: (NSTimeInterval) timeInterval;

/**
 错误信息提示

 @param message 错误的文本信息
 @param timeInterval 时间间隔
 */
- (void)showErrorHUDWith:(NSString *)message afterDelay:(NSTimeInterval)timeInterval;

@end
