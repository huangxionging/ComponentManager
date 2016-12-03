//
//  ViewController.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "ViewController.h"
#import "CMShowHUDManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[CMShowHUDManager shareManager] showErrorHUDWith: @"手机号码错误" afterDelay: 2.5f];
    [[CMShowHUDManager shareManager] showHUDWith: @"正在加载..."];
    // 开别的线程等 5s
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(5);
        [[CMShowHUDManager shareManager] hideHUD];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
