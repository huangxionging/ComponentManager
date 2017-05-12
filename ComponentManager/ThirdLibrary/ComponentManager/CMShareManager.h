//
//  CMShareManager.h
//  32TeethDoc
//
//  Created by huangxiong on 2017/4/21.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
//@interface CMShareModel : NSObject
//
///**
// 平台类型
// */
//@property (nonatomic, assign) UMSocialPlatformType platformType;
//
///**
// appKey
// */
//@property (nonatomic, copy) NSString *appKey;
//
///**
// appSecret
// */
//@property (nonatomic, copy) NSString *appSecret;
//
///**
// 
// */
//@property (nonatomic, copy) NSString *redirectURL;
//
//+ (instancetype)modelWithPlatform:(UMSocialPlatformType)platformType appKey:(NSString *)appKey appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL;
//
//@end

/**
 基于友盟的分享
 */
@interface CMShareManager : NSObject

/**
 默认管理器 单例
 
 @return 管理器对象
 */
+ (instancetype)shareManager;

/**
 配置分享平台. 请在源代码中修改相关参数
 */
- (void) configSharePlatforms;

//- (void) configSharePlatform: (CMShareModel *)shareModel;
/**
 配置设置
 */
- (void) confitShareSettings;

/**
 配置展示的平台, 根据需要自己修改源代码
 */
- (void) configShowPlatforms;

/**
 配置需要展示的平台

 @param platforms 平台数组 UMSocialPlatformType NSNumber 数组
 */
- (void) configShowsWithPlatforms: (NSArray *)platforms;

/**
 展示分享菜单, 并执行分享动作

 @param shareMessageObject 分享的消息对象描述
 @param success 成功回调
 @param failure 失败回调
 */
- (void) showShareMenuWithShareMessageObject: (UMSocialMessageObject *)shareMessageObject success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
//ShareBlock: (void(^)(UMSocialPlatformType platformType, NSDictionary *userInfo))shareBlock;

@end
