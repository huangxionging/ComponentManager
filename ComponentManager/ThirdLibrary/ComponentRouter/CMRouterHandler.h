//
//  CMRouterHandler.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/24.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CMRouterHandler : NSObject

- (NSString *) handlerURL: (NSString  *)url;

- (void)handlerObject:(id)obj forPath:(NSString *)path;


@end

NS_ASSUME_NONNULL_END
