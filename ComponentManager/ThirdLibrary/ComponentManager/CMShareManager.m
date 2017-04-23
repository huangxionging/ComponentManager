//
//  CMShareManager.m
//  32TeethDoc
//
//  Created by huangxiong on 2017/4/21.
//  Copyright © 2017年 huangxiong. All rights reserved.
//

#import "CMShareManager.h"
/*******************AppIDstart***************************/
//友盟AppID
#define UMENG_APP_KEY          @"580c8789f43e48111b0044aa"
#define USER_DEVICE_TOKEN      @"USER_DEVICE_TOKEN"
#define UM_RedirectURL         @"http://www.umeng.com/social"

//微信AppID
#define Weixin_APP_ID           @"wx07ca4c0ee46b147c"
#define Weixin_APP_KEY          @"b7406a732675e66454d30a3fcb0ca789"

////QQ的AppID
#define QQ_APP_ID              @"1106078968"
#define QQ_APP_KEY             @"9t9nBv0bqRaCN17Y"
//
////weibo的AppID
#define Weibo_APP_KEY             @"846435984"
#define Weibo_APP_ID              @"1105585880 "
#define Weibo_Secret                @"a4c222a7b8649994419a91cff5b8bde4 "
#define Weibo_RedirectURL         @"http://sns.whalecloud.com/sina2/callback"
@implementation CMShareManager
#pragma mark- 共享的单例
+ (instancetype)shareManager {
    static CMShareManager *shareManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManage = [[super alloc] init];
    });
    return shareManage;
}

- (void)configSharePlatforms {
    /* 设置微信的appKey和appSecret */
    //设置友盟appkey
//    [WXApi registerApp: @"wx07ca4c0ee46b147c" enableMTA: YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMENG_APP_KEY];
    //设置微信AppId、appSecret，分享url
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:Weixin_APP_ID
                                       appSecret:Weixin_APP_KEY
                                     redirectURL:UM_RedirectURL];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APP_ID/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:Weibo_APP_KEY  appSecret:Weibo_Secret redirectURL:Weibo_RedirectURL];
    
    [[UMSocialManager defaultManager] openLog:NO];
 
    
#pragma mark- 把以下未使用到的注释掉
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    

//    /* 钉钉的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//    
//    /* 支付宝的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    
//    /* 设置易信的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置点点虫（原来往）的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置领英的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
//    
//    /* 设置Twitter的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
//    
//    /* 设置Facebook的appKey和UrlString */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:@"http://www.umeng.com/social"];
//    
//    /* 设置Pinterest的appKey */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
//    
//    /* dropbox的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
//    
//    /* vk的appkey */
//    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];

}

#pragma mark- 设置分享
- (void)confitShareSettings {
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

#pragma mark- 展示的项目
- (void)configShowPlatforms {
    //设置用户自定义的平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine),
                                               @(UMSocialPlatformType_WechatFavorite),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_Qzone),
                                               @(UMSocialPlatformType_Sina),
//                                               @(UMSocialPlatformType_TencentWb),
//                                               @(UMSocialPlatformType_AlipaySession),
//                                               @(UMSocialPlatformType_DingDing),
//                                               @(UMSocialPlatformType_Renren),
//                                               @(UMSocialPlatformType_Douban),
//                                               @(UMSocialPlatformType_Sms),
//                                               @(UMSocialPlatformType_Email),
//                                               @(UMSocialPlatformType_Facebook),
//                                               @(UMSocialPlatformType_FaceBookMessenger),
//                                               @(UMSocialPlatformType_Twitter),
//                                               @(UMSocialPlatformType_LaiWangSession),
//                                               @(UMSocialPlatformType_LaiWangTimeLine),
//                                               @(UMSocialPlatformType_YixinSession),
//                                               @(UMSocialPlatformType_YixinTimeLine),
//                                               @(UMSocialPlatformType_YixinFavorite),
//                                               @(UMSocialPlatformType_Instagram),
//                                               @(UMSocialPlatformType_Line),
//                                               @(UMSocialPlatformType_Whatsapp),
//                                               @(UMSocialPlatformType_Linkedin),
//                                               @(UMSocialPlatformType_Flickr),
//                                               @(UMSocialPlatformType_KakaoTalk),
//                                               @(UMSocialPlatformType_Pinterest),
//                                               @(UMSocialPlatformType_Tumblr),
//                                               @(UMSocialPlatformType_YouDaoNote),
//                                               @(UMSocialPlatformType_EverNote),
//                                               @(UMSocialPlatformType_GooglePlus),
//                                               @(UMSocialPlatformType_Pocket),
//                                               @(UMSocialPlatformType_DropBox),
//                                               @(UMSocialPlatformType_VKontakte),
//                                               @(UMSocialPlatformType_UserDefine_Begin+1),
                                               ]];

}

- (void)configShowsWithPlatforms:(NSArray *)platforms {
    [UMSocialUIManager setPreDefinePlatforms: platforms];
}

- (void)showShareMenuWithShareMessageObject: (UMSocialMessageObject *)shareMessageObject success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [[UMSocialManager defaultManager] shareToPlatform: platformType messageObject: shareMessageObject currentViewController: nil completion:^(id result, NSError *error) {
            
            if (error) {
                UMSocialPlatformErrorType type = error.code;
                NSError *shareError = nil;
                NSString *errorTitle = nil;
                switch (type) {
                    case UMSocialPlatformErrorType_Cancel: {
                        errorTitle = @"用户取消分享";
                        break;
                    }
                    case UMSocialPlatformErrorType_NotInstall:{
                        errorTitle = @"应用未安装";
                        break;
                    }
                    case UMSocialPlatformErrorType_NotNetWork: {
                        errorTitle = @"网络错误, 请稍后再试";
                        break;
                    }
                    case UMSocialPlatformErrorType_NotSupport: {
                        errorTitle = @"客户端不支持分享";
                        break;
                    }
                    case UMSocialPlatformErrorType_ShareFailed: {
                        errorTitle = @"分享失败";
                        break;
                    }
                    case UMSocialPlatformErrorType_SourceError: {
                        errorTitle = @"第三方错误";
                        break;
                    }
                    case UMSocialPlatformErrorType_ShareDataNil: {
                        errorTitle = @"分享内容为空";
                        break;
                    }
                    case UMSocialPlatformErrorType_NotUsingHttps: {
                        errorTitle = @"未使用 https ";
                        break;
                    }
                    case UMSocialPlatformErrorType_AuthorizeFailed: {
                        errorTitle = @"授权失败";
                        break;
                    }
                    case UMSocialPlatformErrorType_CheckUrlSchemaFail: {
                        errorTitle = @"白名单错误";
                        break;
                    }
                    case UMSocialPlatformErrorType_ShareDataTypeIllegal: {
                        errorTitle = @"不支持的分享内容";
                        break;
                    }
                    default:
                        errorTitle = @"未知错误";
                        break;
                }
                shareError = [NSError errorWithDomain:error.domain code: type userInfo: @{NSLocalizedDescriptionKey: errorTitle}];
                failure(shareError);
            } else {
                success(result);
            }
        }];
    }];
}

@end
