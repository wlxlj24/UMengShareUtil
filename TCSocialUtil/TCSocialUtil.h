//
//  TCSocialUtil.h
//  UMeng_Demo
//
//  Created by TailC on 16/5/30.
//  Copyright © 2016年 TailC. All rights reserved.
//
/*
 使用方法：
 0.pod 'UMengSocialCOM', '~> 5.2.1'
 1.在appDelegate.m的didFinishLaunchingWithOptions方法中调用+setupUMShare方法
 2.配置需要分享的种类 +setupWechat等
 3.配置TCSocialConstantDefine.h 中的APPID,Secret
 4.配置URL scheme
 5.配置工具类中 -presentSnsIconSheetView方法中分享的种类
 6.appDelegate.m配置跳转回调
 
 -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
	BOOL result = [UMSocialSnsService handleOpenURL:url];
	
	if (result == false) {
 //调用其他SDK
	}
	
	return result;
 }
 
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UMSocialResponseEntity;

typedef void(^getUMSocialDataSuccessBlock)(UMSocialResponseEntity *response);
typedef void(^getUMSocialDataFailureBlock)(UMSocialResponseEntity *response);

@interface TCSocialUtil : NSObject

/** 初始化单例  */
+ (instancetype)sharedInstance;

/** 初始化友盟分享，需在AppDelegate.m中初始化  */
+(void)setupUMShare;

/** 微信分享初始化  */
+(void)setupWechat;

/** QQ分享初始化  */
+(void)setupQQ;

/** 新浪微博分享初始化  */
+(void)setupSina;

/**
 *  快速分享
 *
 *  @param viewController 显示VC
 *  @param title          标题
 *  @param imageURL       图片URL(imageURL和shareImage只显示一个，若imageURL存在，则显示imageURL)
 *  @param shareImage     图片UIImage
 *  @param contentText    内容
 *  @param URLStr         点击跳转URL
 *  @param aSuccessBlock  成功回调
 *  @param aFailureBlock  失败回调
 */
-(void)presentSnsIconSheetView:(UIViewController *)viewController
						 title:(NSString *)title
					  imageURL:(NSString *)imageURL
					shareImage:(UIImage *)shareImage
					 shareText:(NSString *)contentText
				   clickURLStr:(NSString *)URLStr
				getDataSuccess:(getUMSocialDataSuccessBlock)aSuccessBlock
				getDataFailure:(getUMSocialDataFailureBlock)aFailureBlock;


@end
