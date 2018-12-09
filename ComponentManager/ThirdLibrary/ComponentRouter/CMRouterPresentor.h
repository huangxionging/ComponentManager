//
//  CMRouterPresentor.h
//  ComponentManager
//
//  Created by huangxiong on 2018/10/23.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMRouterObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface CMRouterPresentor : CMRouterObject

@end

@interface UIViewController (RouterPresentor)

+ (void) routerWithFrontViewController: (UIViewController *)frontViewController parameters:(id)parameters;

@end

NS_ASSUME_NONNULL_END
