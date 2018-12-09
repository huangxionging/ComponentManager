//
//  CMRouterSwitcher.m
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/17.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterSwitcher.h"

@implementation CMRouterSwitcher
+ (void)load {
    [[CMDispatchManager shareManager] dispatchTarget: [CMRouterManager shareManager] method: @"registerRouterTaskClassName:forProtocol:", @"CMRouterSwitcher", @"switchTo", nil];
}
@end
