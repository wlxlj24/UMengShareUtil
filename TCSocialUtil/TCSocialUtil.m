//
//  TCSocialUtil.m
//  UMeng_Demo
//
//  Created by TailC on 16/5/30.
//  Copyright © 2016年 TailC. All rights reserved.
//

#import "TCSocialUtil.h"
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import "TCSocialConstantDefine.h"

@interface TCSocialUtil ()<UMSocialUIDelegate>

@property (nonatomic,readwrite,copy) getUMSocialDataSuccessBlock successBlock;
@property (nonatomic,readwrite,copy) getUMSocialDataFailureBlock falureBlock;

@end


@implementation TCSocialUtil

+ (instancetype)sharedInstance {
	static id sharedInstance = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] init];
	});
	
	return sharedInstance;
}

+(void)setupUMShare{
	
	//设置友盟社会化组件appkey
	[UMSocialData setAppKey:UMengSocial_Appkey];
	
	//打开调试log的开关
	[UMSocialData openLog:YES];
	
	//如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
	//	[UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
	
}

+(void)setupWechat{
	//设置微信AppId，设置分享url，默认使用友盟的网址
	[UMSocialWechatHandler setWXAppId:UMengSocial_WX_APP_ID
							appSecret:UMengSocial_WX_APP_SECRET
								  url:UMengSocial_WX_URL];
}

+(void)setupQQ{
	
}

+(void)setupSina{
	
	// 打开新浪微博的SSO开关
	// 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
	//	[UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
	//											  secret:@"04b48b094faeb16683c32669824ebdad"
	//										 RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
	
	
}



-(void)presentSnsIconSheetView:(UIViewController *)viewController
						 title:(NSString *)title
					  imageURL:(NSString *)imageURL
					shareImage:(UIImage *)shareImage
					 shareText:(NSString *)contentText
				   clickURLStr:(NSString *)URLStr
				getDataSuccess:(getUMSocialDataSuccessBlock)aSuccessBlock
				getDataFailure:(getUMSocialDataFailureBlock)aFailureBlock{
	
	self.successBlock = aSuccessBlock;
	self.falureBlock = aFailureBlock;
	
	[UMSocialData defaultData].extConfig.title = title;
	//配置 点击分享内容后的跳转链接
	[UMSocialData defaultData].extConfig.wechatSessionData.url = URLStr;
	
	//注意当URL图片和UIImage同时存在时，只有URL图片生效
	[[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:imageURL];
	
	//TODO:配置分享类型种类
	[UMSocialSnsService presentSnsIconSheetView:viewController
										 appKey:UMengSocial_Appkey
									  shareText:contentText
									 shareImage:shareImage
								shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
									   delegate:self];
	
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
	//根据`responseCode`得到发送结果,如果分享成功
	if(response.responseCode == UMSResponseCodeSuccess)
	{
		//得到分享到的平台名
		NSLog(@"分享成功");
		NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
		//成功block回调
		self.successBlock(response);
	}else{
		NSLog(@"分享失败");
		self.falureBlock(response);
	}
}

@end
