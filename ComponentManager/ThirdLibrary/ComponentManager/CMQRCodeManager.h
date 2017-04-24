//
//  CMQRCodeManager.h
//  32TeethDoc
//
//  Created by huangxiong on 2016/12/20.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMQRCodeManager : NSObject


/**
 根据文本生成二维码

 @param text 文本描述
 @param size 尺寸信息
 @return 二维码图
 */
+ (UIImage *) encodeWithText: (NSString *) text size: (CGSize) size;

@end
