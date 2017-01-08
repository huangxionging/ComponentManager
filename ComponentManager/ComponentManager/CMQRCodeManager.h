//
//  CMQRCodeManager.h
//  Hydrodent
//
//  Created by huangxiong on 2016/12/20.
//  Copyright © 2016年 xiaoli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 支持 iOS 8以上系统
 */
@interface CMQRCodeManager : NSObject

/**
 根据字典生成的二维码

 @param object id 类型
 @param size 尺寸大小
 @return 对象
 */
+ (UIImage *) encodeWithObject: (id) object size:(CGSize)size;

/**
 识别二维码

 @param image 二维码图片
 @return 二维码生成的结果
 */
+ (NSString *) decodeWithImage: (UIImage *)image;

@end
