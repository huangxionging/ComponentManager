//
//  CMShowHUDManager.h
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 必须要引入的类
 */
@class MBProgressHUD, UIAlertController, CMViewControllerManager;



/**
 默认的基于 UIWindow 的 HUD 管理器, UIView 调用对应的方法
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
 展示信息, 隐藏需自己控制, 这个带菊花转
 
 @param view 要出现的视图
 @param message 文本信息, 可空,
 */
- (void)showViewHUD: (UIView *)view message:(NSString *)message;

/**
 隐藏 HUD
 */
- (void)hideHUD;;

/**
 隐藏指定 view 上的 hud

 @param view 视图
 */
- (void)hideViewHUD: (UIView *)view;

/**
 普通的展示文本

 @param message 文本消息
 @param timeInterval 间隔时间
 */
- (void)showHUDWith:(NSString *)message afterDelay: (NSTimeInterval) timeInterval;


/**
 普通展示文本

 @param view 视图
 @param message 消息
 @param timeInterval 时间间隔
 */
- (void)showViewHUD: (UIView *)view message:(NSString *)message afterDelay: (NSTimeInterval) timeInterval;

/**
 错误信息提示

 @param message 错误的文本信息
 @param timeInterval 时间间隔
 */
- (void)showErrorHUDWith:(NSString *)message afterDelay:(NSTimeInterval)timeInterval;


/**
 错误的信息

 @param view 视图
 @param message 消息描述
 @param timeInterval 时间间隔
 */
- (void)showErrorViewHUD: (UIView *)view message:(NSString *)message afterDelay:(NSTimeInterval)timeInterval;

/**
 错误警告框提示信息, 使用 UIAlertController
 
 @param title 标题
 @param message 信息
 */
- (void)showAlertErrorWith: (NSString *)title message: (NSString *)message;


/**
 昏暗的 HUD

 @param message 消息
 */
- (void)showDimHUDWith:(NSString *)message;


/**
 在视图上增加昏暗的 hud

 @param view 视图
 @param message 消息
 */
- (void)showViewDimHUD:(UIView *)view message:(NSString *)message;


/**
 警告框提示信息, 并有完成回调

 @param title 标题
 @param message 消息
 @param completion 完成回调
 */
- (void)showAlertErrorWith: (NSString *)title message: (NSString *)message completed: (void (^)(NSInteger index))completion;

/**
 展示 alert
 
 @param title 标题
 @param message 消息
 @param actions action 描述 每个 dictionary {@"title" : 标题, @"style": @(UIAlertActionStyle)}
 @param completion 完成回调, index 与 actions 对应
 */
- (void) showAlertWith: (NSString *)title message: (NSString *)message  actions: (NSArray<NSDictionary<NSString *, id> *> *)actions  completed: (void (^)(NSInteger index))completion;

/**
 展示 actionSheet

 @param title 标题
 @param message 消息
@param actions action 描述 每个 dictionary {@"title" : 标题, @"style": @(UIAlertActionStyle)}
 @param completion 完成回调, index 与 actions 对应
 */
- (void) showActionSheetWith: (NSString *)title message: (NSString *)message  actions: (NSArray<NSDictionary<NSString *, id> *> *)actions  completed: (void (^)(NSInteger index))completion;


@end
