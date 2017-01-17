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
    // Do any additional setup after loading the view, typically from a nib.
//    [[CMShowHUDManager shareManager] showErrorHUDWith: @"手机号码错误" afterDelay: 2.5f];
//    [[CMShowHUDManager shareManager] showHUDWith: @"正在加载..."];
//    // 开别的线程等 5s
//    dispatch_async(dispatch_get_main_queue(), ^{
////        sleep(5);
//        [[CMShowHUDManager shareManager] hideHUD];
//    });
//    
//    [self.keyboardManager hideKeyboardForView: self.textField];
//    [self.keyboardManager setKeyboardBlock:^(id result, BOOL isShow) {
//        if (isShow) {
//            NSLog(@"键盘弹出");
//            
//            self.bottom.constant = -312;
//        } else {
//            NSLog(@"键盘隐藏");
//            self.bottom.constant = -37;
//        }
//        NSLog(@"%@", result);
//    }];
//    
//    UIImage *image = [CMQRCodeManager encodeWithObject: @{@"key" : @"https://www.baidu.com"} size: CGSizeMake(300, 300)];
//    self.qrImage.image = image;
//    NSString *str = [CMQRCodeManager decodeWithImage: image];
//    NSData *data = [str dataUsingEncoding: NSUTF8StringEncoding];
//    NSDictionary *dicton = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error: nil];
//    NSString *https = dicton[@"key"];
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: https] options: nil completionHandler:^(BOOL success) {
//        
//    }];
        dispatch_async(dispatch_get_main_queue(), ^{
    //        sleep(5);
            CGRect windowSize = self.view.bounds;
            UIView *view = [UIView new];
            [self.view addSubview: view];
            view.frame = CGRectMake(windowSize.size.width / 2 - 100, 100, 200, 200) ;
            //        self.scanRectView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
            view.layer.borderColor = [UIColor redColor].CGColor;
            view.layer.borderWidth = 1;
            
            __weak typeof(self)weakSelf = self;
            
            BOOL available = [weakSelf.scanQRCodeManager cameraAvailable];
            if (available == NO) {
                [[CMShowHUDManager shareManager] showAlertWith: nil message: @"请在iPhone\"设置\"选项中允许32teeth医生版访问您的相机" actions: @[@{@"style":@(UIAlertActionStyleCancel), @"title":@"好的"}, @{@"style":@(UIAlertActionStyleDefault), @"title":@"去设置"}] completed:^(NSInteger index) {
                    if (index == 1) {
                        NSString *setting = UIApplicationOpenSettingsURLString;
                        if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString: setting]]) {
                            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: setting]];
                        }
                    }
                }];
                return;
            }
            [weakSelf.scanQRCodeManager modifyScanAction: [CMScanAction actionWithScanView: self.view validRect: CGRectMake(windowSize.size.width / 2 - 100, 100, 200, 200) actionBlock:^BOOL(NSString *stringValue) {
                NSLog(@"%@", stringValue);
                NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"qrcode_found" ofType:@"wav"];
                [weakSelf.scanQRCodeManager playSoundWithPath: strSoundFile];
                [[CMShowHUDManager shareManager] showAlertErrorWith: nil message: stringValue completed:^(NSInteger index) {
                    [weakSelf.scanQRCodeManager startRunning];
                }];
                
                
                return YES;
            }]];
        });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
