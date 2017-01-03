//
//  ViewController.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "ViewController.h"
#import "CMShowHUDManager.h"
#import "CMKeyboardManager.h"

@interface ViewController ()

@property (nonatomic, strong) CMKeyboardManager *keyboardManager;

@end

@implementation ViewController

- (CMKeyboardManager *)keyboardManager {
    if (_keyboardManager == nil) {
        _keyboardManager = [CMKeyboardManager manager];
    }
    return _keyboardManager;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.keyboardManager addKeyboardNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.keyboardManager removeKeyboardAllNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[CMShowHUDManager shareManager] showErrorHUDWith: @"手机号码错误" afterDelay: 2.5f];
    [[CMShowHUDManager shareManager] showHUDWith: @"正在加载..."];
    // 开别的线程等 5s
    dispatch_async(dispatch_get_main_queue(), ^{
//        sleep(5);
        [[CMShowHUDManager shareManager] hideHUD];
    });
    
    [self.keyboardManager hideKeyboardForView: self.textField];
    [self.keyboardManager setKeyboardBlock:^(id result, BOOL isShow) {
        
        NSLog(@"%@", result);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
