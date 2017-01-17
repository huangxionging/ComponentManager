//
//  CMViewControllerManager.h
//  ComponentManager
//
//  Created by huangxiong on 2016/12/4.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMViewControllerManager : NSObject


/**
 默认产生管理器对象的方法
 
 @return 视图管理器对象
 */
+ (instancetype) manager;

/**
 切换根视图控制器

 @param controller 视图控制器
 */
+ (void) togglesRootController: (UIViewController *)controller;


/**
 从指定 storyboard 中获取控制器

 @param storyboardKey storyBoard 的名字
 @param identifier 控制器的标识符
 @return 控制器对象
 */
+ (UIViewController *) viewControllerFromStoryboard:(NSString *)storyboardKey identifier: (NSString *)identifier;

/**
 当前控制器

 @return 控制器
 */
+ (UIViewController *)currentViewController;

/**
 设置控制器的返回标题, 对下一级控制器有效

 @param controller 控制器
 @param title 返回标题
 */
- (void) setViewController: (UIViewController *)controller backTitle: (NSString *)title;

@end
