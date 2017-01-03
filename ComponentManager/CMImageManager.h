//
//  CMImageManager.h
//  ComponentManager
//
//  Created by huangxiong on 2017/1/3.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMImageManager : NSObject

/**
 源图像
 */
@property (nonatomic,  strong) UIImage *image;

/**
 管理器对象

 @return 图像管理器对象
 */
+ (instancetype)manager;

/**
 修正过方向的图像
 
 @return 图片对象
 */
- (UIImage *)fixOrientation;


/**
 正常的图像
 
 @return 图像对象
 */
- (UIImage *)normalizedImage;

@end
