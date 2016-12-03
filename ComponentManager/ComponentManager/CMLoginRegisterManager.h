//
//  CMLoginRegisterManager.h
//  ComponentManager
//
//  Created by huangxiong on 2016/12/3.
//  Copyright © 2016年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

typedef NS_ENUM(NSUInteger, CMLoginRegisterErrorType) {
    // 手机号不合法
    CMLoginRegisterErrorTypePhoneNumberInvalid  = 10000,
    // 手机号已注册
    CMLoginRegisterErrorTypePhoneNumberRegistered,
    // 网络错误
    CMLoginRegisterErrorTypeNetworkError,
    // 参数不合法
    NSLoginRegisterErrorTypeParameterInvalid,
    // 签名不合法
    CMLoginRegisterErrorTypeSignInvalid,
};

/**
 只做声明使用, 子类需重写相应的有方法
 */
@interface CMLoginRegisterManager : NSObject

/**
 http session 管理器, 基于 AFNetworking, 子类请重写 setter 或 getter 方法
 */
@property (nonatomic, copy) AFHTTPSessionManager *sessionManager;

/**
 默认产生管理器对象的方法, 可以不重写
 
 @return 登录注册管理器对象
 */
+ (instancetype) manager;

/**
 判断手机号码是否有效, 该方法不用重写
 
 @param mobile 待判断的手机号
 @return 是否有效
 */
- (BOOL)validMobile:(NSString *)mobile;

/**
 获取登录验证码, 子类需重写, 因为不同的 APP 接口不同
 
 @param parameters 登录使用的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) getLoginVerificationCodeWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 获取注册验证码, 子类需重写, 因为不同的 APP 接口不同
 
 @param parameters 登录使用的参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) getRegisterVerificationCodeWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 登录接口, 子类需重写, 因为不同的 APP 接口不同
 
 @param parameters 登录所需参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) loginWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 注册接口, 子类需重写, 因为不同的 APP 接口不同
 
 @param parameters 登录所需参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) registerWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 退出登录接口, 子类需重写, 因为不同的 APP 接口不同
 
 @param parameters 登录所需参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void) logoutWithParameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
