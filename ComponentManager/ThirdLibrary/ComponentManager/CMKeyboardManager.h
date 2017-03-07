//
//  CMKeyboardManager.h
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/8.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMKeyboardManager : NSObject

/**
 键盘 block
 */
@property (nonatomic, copy) void(^keyboardBlock)(id result, BOOL isShow);

/**
 管理器

 @return 管理器对象
 */
+ (instancetype)manager;

/**
 添加键盘通知
 */
- (void) addKeyboardNotification;

/**
 删除键盘通知
 */
- (void) removeKeyboardNotification;

/**
 为输入控件添加收键盘的 view

 @param view 待添加的 view(输入控件, UITextField, UITextView)
 */
- (void) hideKeyboardForView: (UIView *)view;

/**
 隐藏键盘

 @param sender 隐藏键盘
 */
- (void) hideKeyboard: (UIBarButtonItem *) sender;

@end
