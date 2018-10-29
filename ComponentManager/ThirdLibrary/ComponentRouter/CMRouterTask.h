//
//  CMRouterTask.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterTask : NSObject

/**
 
 */
@property (nonatomic, copy) NSString *taskClass;

@property (nonatomic, strong) id parameter;

- (void) invoke;

@end

NS_ASSUME_NONNULL_END
