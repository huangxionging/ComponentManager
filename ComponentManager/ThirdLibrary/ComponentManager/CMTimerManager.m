//
//  CMTimerManager.m
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/5.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMTimerManager.h"

@implementation CMTimerManager

+ (instancetype)shareManager {
    static CMTimerManager *timerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[super alloc] init];
    });
    return timerManager;
}

- (void)startTimer{
    [NSTimer scheduledTimerWithTimeInterval:1 repeats: NO block:^(NSTimer * _Nonnull timer) {
        
    }];
}

@end
