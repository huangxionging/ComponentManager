//
//  CMStringManager.m
//  ComponentManager
//
//  Created by 黄雄 on 2018/10/22.
//  Copyright © 2018 huangxiong. All rights reserved.
//

#import "CMStringManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@implementation CMStringManager

#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMStringManager *stringManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stringManager = [[super alloc] init];
    });
    return stringManager;
}

#pragma mark - md5 方法
- (NSString *) getMD5String:(NSString *)original {
    const char *cStr = [original UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    // 拼接 MD5 之后的结果
    NSMutableString *md5String = [NSMutableString string];
    for (NSInteger index = 0; index < CC_MD5_DIGEST_LENGTH; ++index) {
        // 追加字符串
        [md5String appendFormat: @"%02x", result[index]];
    }
    // 释放内存
    free(result);
    free(&cStr);
    return [md5String uppercaseString];
}

#pragma mark - URL 方法
- (NSString*)decodeURL:(NSString *)url{
    return [url stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)encodeURL: (NSString *)url {
    return  [url stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
}


- (NSDictionary *) getParameterFromURL: (NSString *)url {
    // 是否包含问号
    NSString *str = url;
    if (![url containsString: @"?"]) {
        str = [NSString stringWithFormat:@"url?%@", url];
    }
    // 切割 url 地址和参数
    NSArray<NSString *> *allComponents = [url componentsSeparatedByString: @"?"];
    if (allComponents.count == 2) {
        // 获得参数部分字符串
        NSString *parameterString = allComponents[1];
        // 通过 & 字符串切割成键值字符串数组
        NSArray<NSString *> * allParameters = [parameterString componentsSeparatedByString: @"&"];
        NSMutableDictionary *parameterData = [NSMutableDictionary dictionaryWithCapacity: 0];
        // 遍历该数组
        for(NSInteger index = 0; index < allParameters.count; ++index) {
            NSString *param = allParameters[index];
            if ([param containsString: @"="]) {
                // 通过 = 字符串切割成 key 和 value
                NSArray<NSString *> *keyValues = [param componentsSeparatedByString: @"="];
                if (keyValues.count == 2) {
                    NSString *key = keyValues[0];
                    NSString *value = keyValues[1];
                    // 生成 key 对应的 value
                    parameterData[key] = value;
                }
            }
        }
        return parameterData;
    }
    return nil;
}

- (NSString *)toHttp:(NSString *)url {
    return [NSString stringWithFormat: @"http://%@", [url componentsSeparatedByString: @"://"].lastObject];
}

- (NSString *)toHttps:(NSString *)url {
    return [NSString stringWithFormat: @"http://%@", [url componentsSeparatedByString: @"://"].lastObject];
}

#pragma mark -小数精度还原
- (NSString *) decimalString: (NSString *)original; {
    NSString *string = [NSString stringWithFormat: @"%lf", original.doubleValue];
    NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString: string];
    return [decimalNumber stringValue];
}

#pragma mark -计算尺寸信息
- (CGSize) sizeWithText:(NSString *)text width: (CGFloat)width height: (CGFloat)height systemFontSize: (CGFloat)fontSize {

    return [text boundingRectWithSize: CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName :[UIFont systemFontOfSize: fontSize]} context: nil].size;
}

#pragma mark -将对象转化为字符串
- (NSString *)stringFromObject:(id)object {
    return [NSString stringWithFormat: @"%@", object];
}

#pragma mark -16进制相关
- (NSString *) hexStringFromBytes:(Byte *)bytes length: (NSInteger)length {
    NSMutableString *hexString = [NSMutableString stringWithString: @"0x"];
    for (NSInteger index =0; index < length; ++index) {
        [hexString appendFormat: @"%02x", bytes[index]];
    }
    return hexString;
}

- (NSString *) hexStringFromData:(NSData *) data {
    NSInteger length = data.length;
    Byte *bytes = (Byte *)[data bytes];
    return [self hexStringFromBytes: bytes length: length];
}

- (Byte *) bytesFromHexString: (NSString *)hexString {
    if (![hexString hasPrefix: @"0x"]) {
        hexString = [NSString stringWithFormat: @"0x%@", hexString];
    }

    // 求长度
    NSUInteger length = hexString.length / 2 - 1;

    // 创建字节数组
    Byte *bytes = (Byte *)malloc(sizeof(Byte) *length);
    memset(bytes, 0, length);
    // 转换成小写
    NSString *lowcaseString = [hexString lowercaseString];

    // for loop 开始转换
    for (NSInteger index = 2; index < lowcaseString.length; index+=2) {
        // 获取高位字符
        char highChar = [lowcaseString characterAtIndex: index];
        // 获取低位字符
        char lowChar = [lowcaseString characterAtIndex: index + 1];
        // 将字符转换为10进制整数
        NSInteger highValue = [self integerFromHexChar: highChar];
        NSInteger lowValue = [self integerFromHexChar: lowChar];
        bytes[index / 2 - 1] = highValue * 16 + lowValue;
    }
    return bytes;
}

- (NSInteger)integerFromHexChar:(char)hexChar {
    if (hexChar >= '0' && hexChar <= '9') {
        return hexChar - 48;
    } else if (hexChar >= 'a' && hexChar <= 'f') {
        // 'a' 是 97, 但表示 10, 所以 hexChar - 97 + 10 = hexChar - 87
        return hexChar - 87;
    } else if (hexChar >= 'A' && hexChar <= 'F') {
        // 'A' 是 65, 但表示 10, 所以 hexChar - 65 + 10 = hexChar - 55
        return hexChar - 65 + 10;
    }
    return NSNotFound;
}

- (NSData *)dataFromHexString:(NSString *)hexString {
    if (![hexString hasPrefix: @"0x"]) {
        hexString = [NSString stringWithFormat: @"0x%@", hexString];
    }
    Byte *bytes = [self bytesFromHexString: hexString];
    return [NSData dataWithBytes: bytes length: hexString.length / 2 - 1];
}

- (NSString *) stringFromHexAscii: (NSString *)hexAscii {

    NSInteger hexLength = hexAscii.length;
    // 16 进制字符串都是偶数个
    if (hexLength % 2 != 0) {
        return nil;
    }
    if (![hexAscii hasPrefix: @"0x"]) {
        hexAscii = [NSString stringWithFormat: @"0x%@", hexAscii];
    }
    NSMutableString *string = [NSMutableString string];
    for (NSInteger index = 2; index < hexAscii.length; index += 2) {
        NSString *sub = [hexAscii substringWithRange: NSMakeRange(index, 2)];
        // 获得 对应的字符
        char value = (char)[self integerFromHexString: sub];
        // 拼接字符串
        [string appendFormat: @"%c", value];

    }
    return string;
}

- (NSInteger)integerFromHexString: (NSString *)hexString {
    // 添加 0x 前缀
    if (![hexString hasPrefix: @"0x"]) {
        hexString = [NSString stringWithFormat: @"0x%@", hexString];
    }

    // 得到长度
    NSInteger leng = hexString.length / 2 - 1;

    // 获得字节
    Byte *bytes = [self bytesFromHexString: hexString];

    // 获取结果
    NSInteger sum = 0;
    for (NSInteger index = leng - 1; index >= 0; --index) {
        sum += bytes[index] * pow(256, leng - index - 1);
    }
    free(bytes);
    return sum;
}

- (NSString *)parameterStringFromDictionary:(NSDictionary *)dictonary {
    // 拼接 key=value
    NSMutableArray *paramArray = [NSMutableArray arrayWithCapacity: 10];
    for (NSInteger index = 0; index < dictonary.allKeys.count; ++index) {
        NSString * key = dictonary.allKeys[index];
        NSString * value = [self stringFromObject: dictonary[key]];
        NSString *keyValue = [NSString stringWithFormat:@"%@=%@", key, value];
        [paramArray addObject: keyValue];
    }
    // 对 数组排序, 按字母排序
    [paramArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare: obj2];
    }];

    NSString *paramString = [paramArray componentsJoinedByString: @"&"];
    paramArray = nil;
    return  paramString;
}

@end
