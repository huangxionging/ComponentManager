//
//  CMRouterMessager.h
//  Hydrodent
//
//  Created by 黄雄 on 2018/11/26.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 支持协议 messageTo
 */
@interface CMRouterMessager : CMRouterObject


/**
 如果不指定 target, 则把消息发送给所有 target
 */
@property (nonatomic, strong) id target;

@end

NS_ASSUME_NONNULL_END
