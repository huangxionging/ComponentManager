//
//  CMRouterNavigator.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterNavigator.h"
#import <UIKit/UIKit.h>

@implementation CMRouterNavigator

- (void) push {
    NSObject *navigatior = self.navigatorInfo[@"navigatior"];
    NSObject *destinator = self.navigatorInfo[@"destinator"];

}

- (void) pop {
    NSObject *navigatior = self.navigatorInfo[@"navigatior"];
    NSObject *destinator = self.navigatorInfo[@"destinator"];


}

@end
