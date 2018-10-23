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
 单例

 @return 共享单例
 */
+ (instancetype)shareManager;

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


/**
 将对象转换成字符串

 @param object 对象
 @return 字符串值
 */
- (NSString *) stringFromObject:(id)object;

#pragma mark-16进制相关
/**
 16进制字节转换成16进制表示的字符串

 @param bytes 16进制字节
 @param length 16进制字节数组长度
 @return 字符串结果, 小写
 */
- (NSString *) hexStringFromBytes:(Byte *)bytes length: (NSInteger)length;

/**
 NSData 转换成 16进制字符串

 @param data NSData
 @return 16进制数据
 */
- (NSString *) hexStringFromData:(NSData *) data;

/**
 16进制字符串转换成字节数组

 @param hexString 16进制字符串
 @return 字节数
 */
- (Byte *) bytesFromHexString: (NSString *)hexString;

/**
 16进制字符串转换成 NSData

 @param hexString 16进制字符串
 @return NSData
 */
- (NSData *) dataFromHexString: (NSString *)hexString;

/**
 16进制表示的 ASCII 码字符串

 @param hexAscii 16进制字符串
 @return 字符串
 */
- (NSString *) stringFromHexAscii: (NSString *)hexAscii;


/**
 16进制转10进制整数

 @param hexString 16进制字符串
 @return 返回值
 */
- (NSInteger)integerFromHexString: (NSString *)hexString;


/**
 16进制字符转10进制

 @param hexChar 16进制字符
 @return 10进制值
 */
- (NSInteger)integerFromHexChar:(char)hexChar;

/**
 字典转换成参数字符串, 用 & 连接

 @param dictonary 参数字典
 @return 返回的字符串
 */
- (NSString *)parameterStringFromDictionary:(NSDictionary *)dictonary;

@end

NS_ASSUME_NONNULL_END
