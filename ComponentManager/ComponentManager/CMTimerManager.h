//
//  CMTimerManager.h
//  Hydrodent
//
//  Created by huangxiong on 2016/12/5.
//  Copyright © 2016年 xiaoli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMTimerManager : NSObject

+ (instancetype) shareManager;

- (void) startTimer;

@end
