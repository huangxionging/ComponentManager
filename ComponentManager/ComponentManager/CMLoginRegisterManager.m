//
//  CMLoginRegisterManager.m
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import "CMLoginRegisterManager.h"

@implementation CMLoginRegisterManager

+ (instancetype) manager {
    CMLoginRegisterManager *manager = [[super alloc] init];
    return manager;
}


#pragma mark- 获取登录验证码
- (void) getLoginVerificationCodeWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
}

#pragma mark- 获取注册验证码
- (void) getRegisterVerificationCodeWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 登录接口
- (void)loginWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 注册接口
- (void) registerWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 退出登录接口
- (void)logoutWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 第三方登录
- (void)thirdLoginWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 判断手机号码格式是否正确
- (BOOL)validMobile:(NSString *)mobile {
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (mobile.length != 11) {
        return NO;
    } else {
        
        // 移动
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        // 联通
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        // 电信
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        // 判断是否有效
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

@end
