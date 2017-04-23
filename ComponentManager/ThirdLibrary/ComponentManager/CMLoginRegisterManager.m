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

#pragma mark- 第三方登录获取用户信息
- (void)getThirdLoginUserInfoWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 上传头像
- (void)uploadImageWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

#pragma mark- 判断手机号码格式是否正确
- (BOOL)validMobile:(NSString *)mobile {
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *regularExpress = @"^(1)\\d{10}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpress];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
    return isMatch1;
//    if (mobile.length == 11) {
//        return YES;
//    } else {
//        return NO;
//    }
    
}

-(void)dealloc {
    NSLog(@"注册登录挂了..挂了");
}

@end
