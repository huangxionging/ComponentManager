//
//  CMKeyboardManager.m
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/8.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMKeyboardManager.h"

@interface CMKeyboardManager ()

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) NSMutableArray<id<UITextInput>> *keyBoardViews;

@end



@implementation CMKeyboardManager

+ (instancetype)manager {
    CMKeyboardManager *manager = [[super alloc] init];
    return manager;
}

- (NSMutableArray<id<UITextInput>> *)keyBoardViews {
    if (_keyBoardViews == nil) {
        _keyBoardViews = [NSMutableArray arrayWithCapacity: 5];
    }
    return _keyBoardViews;
}

#pragma mark- 注册键盘视图
- (void)registerKeyboardView:(id<UITextInput>)view {
    if (![self.keyBoardViews containsObject: view]) {
        [self.keyBoardViews addObject: view];
    }
}

#pragma mark- 删除单个键盘视图
- (void)removeKeyboardView:(id<UITextInput>)view {
    [self.keyBoardViews removeObject: view];
}

#pragma mark- 删除所有键盘视图
- (void)removeAllKeyboardView {
    [self.keyBoardViews removeAllObjects];
}

#pragma mark- 查找第一响应者
- (id<UITextInput>)firstResponder {
    __block id <UITextInput> firstResponderView = nil;
    [self.keyBoardViews enumerateObjectsUsingBlock:^(id<UITextInput>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        if ([view isFirstResponder]) {
            firstResponderView = obj;
            *stop = YES;
        }
    }];
    return  firstResponderView;
}


#pragma mark- 为 view 添加 工具栏, view 必须是输入控件
- (void) hideKeyboardForView:(UIView *)view {
    ((UITextField *)view).inputAccessoryView = self.toolBar;
}

#pragma mark- 添加 toobar
- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        NSInteger width = [UIScreen mainScreen].bounds.size.width;
        _toolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, width, 40)];
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target: self action: @selector(hideKeyboard:)];
        UIBarButtonItem *midBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(hideKeyboard:)];
        [_toolBar setItems: @[leftBarItem, midBarItem, rightItem] animated: YES];
    }
    return _toolBar;
}


- (void) hideKeyboard: (UIBarButtonItem *) sender{
    // 收键盘
    [self.toolBar.nextResponder becomeFirstResponder];
    [self.toolBar.nextResponder resignFirstResponder];
    
}

#pragma mark- 添加键盘通知
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark- 移除键盘通知
- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillShowNotification object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillHideNotification object: nil];
    
}

- (void) keyboardWillShow: (NSNotification *)notification {
    
    if(self.keyboardBlock) {
        self.keyboardBlock(notification, YES);
    }
}

- (void) keyboardWillHide: (NSNotification *)notification {
    if(self.keyboardBlock) {
        self.keyboardBlock(notification, NO);
    }
}

- (void)dealloc {
    NSLog(@"CMKeyboardManager == 挂了---挂了");
}

@end
