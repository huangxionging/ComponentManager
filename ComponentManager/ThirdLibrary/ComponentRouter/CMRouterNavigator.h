//
//  CMRouterNavigator.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterNavigator : NSObject

@property (nonatomic, copy) NSDictionary *navigatorInfo;

- (void) invoke;

@end

NS_ASSUME_NONNULL_END
