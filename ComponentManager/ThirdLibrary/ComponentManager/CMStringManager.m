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
    NSString*decodedString= (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)url, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));

    return decodedString;
}

- (NSString *)encodeURL: (NSString *)url {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, NULL, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", kCFStringEncodingUTF8));

    if (!encodedString) {
        encodedString = @"";
    }
    return encodedString;
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

@end
