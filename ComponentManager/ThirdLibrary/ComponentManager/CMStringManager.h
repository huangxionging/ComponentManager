//
//  CMStringManager.h
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/22.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMStringManager : NSObject

/**
 对字符串进行 MD5加密

 @return 加密结果
 */
- (NSString *)getMD5String:(NSString *)original;

/**
 URL 解密后的结果

 @return url
 */
-(NSString*)decodeURL:(NSString *)url;

/**
 将 url 转义编码

 @return 转义 url 编码
 */
- (NSString *)encodeURL: (NSString *)url;

/**
 以 获得 http 开头的地址

 @param url 原始地址
 @return http 地址
 */
- (NSString *)urlToHttp: (NSString *)url;

/**
 以 https 协议访问

 @param url 原始地址
 @return https 地址
 */
- (NSString *)urlToHttps: (NSString *)url;

/**
 适配 字符串尺寸信息

 @param text 文本信息
 @param width 宽度
 @param height 高度
 @param fontSize 字体大小
 @return 字符串尺寸信息
 */
- (CGSize) sizeWithText: (NSString *)text width: (CGFloat)width height: (CGFloat)height systemFontSize: (CGFloat)fontSize;

/**
 小数字符串

 @param original 原字符串
 @return 还原原本精度
 */
- (NSString *) decimalString: (NSString *)original;

/**
 从 url 中提取参数

 @param url url 参数
 @return 提取的参数
 */
- (NSDictionary *) getParameterFromURL: (NSString *)url;


@end

NS_ASSUME_NONNULL_END
