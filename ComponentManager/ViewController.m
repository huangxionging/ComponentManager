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
#import "CMQRCodeManager.h"

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
    [self.keyboardManager removeKeyboardNotification];
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
        if (isShow) {
            NSLog(@"键盘弹出");
            
            self.bottom.constant = -312;
        } else {
            NSLog(@"键盘隐藏");
            self.bottom.constant = -37;
        }
        NSLog(@"%@", result);
    }];
    
    UIImage *image = [CMQRCodeManager encodeWithObject: @{@"key" : @"https://www.baidu.com"} size: CGSizeMake(300, 300)];
    self.qrImage.image = image;
    NSString *str = [CMQRCodeManager decodeWithImage: image];
    NSData *data = [str dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *dicton = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error: nil];
    NSString *https = dicton[@"key"];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: https] options: nil completionHandler:^(BOOL success) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
