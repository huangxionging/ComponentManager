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
#import "CMScanQRCodeManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CMStringManager.h"
#import "CMRouterManager.h"

@interface ViewController ()

@property (nonatomic, strong) CMKeyboardManager *keyboardManager;

@property (nonatomic, strong) CMScanQRCodeManager *scanQRCodeManager;

@end

@implementation ViewController

- (CMKeyboardManager *)keyboardManager {
    if (_keyboardManager == nil) {
        _keyboardManager = [CMKeyboardManager manager];
    }
    return _keyboardManager;
}

- (CMScanQRCodeManager *)scanQRCodeManager {
    if (_scanQRCodeManager == nil) {
        _scanQRCodeManager = [CMScanQRCodeManager manager];
    }
    return _scanQRCodeManager;
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
    Byte *bytes = (Byte *)malloc(sizeof(Byte) *10);
    bytes[0] = 0xe6;
    bytes[1] = 0x3f;
    bytes[2] = 0x18;
    bytes[3] = 0x45;
    bytes[4] = 0x79;
    bytes[5] = 0x3a;
    bytes[6] = 0x4b;
    bytes[7] = 0x2c;
    bytes[8] = 0x5d;
    bytes[9] = 0x0e;
    NSString *hexString = [[CMStringManager shareManager] hexStringFromBytes: bytes length: 10];
    NSLog(@"%@", hexString);
    Byte *byte1 = [[CMStringManager shareManager] bytesFromHexString: hexString];
    hexString = @"0x4875616E6758696F6e67";
    NSString *string = [[CMStringManager shareManager] stringFromHexAscii: hexString];
    NSLog(@"%@", string);
    NSDictionary *dic = @{@"name": @"huangxiong", @"email":@"huangxionging@163.com", @"sex":@"man"};
    NSLog(@"%@", [[CMStringManager shareManager] encodeURL: @"http://qnimage.32teeth.cn/窝沟封闭可以帮助儿童预防龋齿_360.mp4"]);
    [[CMRouterManager shareManager] router: @"navigateTo://page/my/personal" parameters: nil success:^(id  _Nonnull responseObject) {

    } failure:^(NSError * _Nonnull error) {

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
