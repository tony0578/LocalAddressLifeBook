//
//  AppDelegate.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/12.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

// 友盟分享
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
// 友盟统计
#import "MobClick.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define kUMeng_KEY   @"54c5f13ffd98c5e8f0000506"

#define KWeiXin_AppID           @"wx12159f5050bd33aa"//@"wx003c71dcdfeb5906" //
#define KWeiXin_AppSecret       @"b65f29e6f3d8a23497c64935b5daa82e"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    // 友盟分享
    [self umShareHander];
    // 友盟统计
    [self umengTrack];
    
    return YES;
}

// 友盟统计
- (void)umengTrack {
    
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io
#endif
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:kUMeng_KEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    //    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    //    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
  
    //    [[TWUserContext sharedInstance] umengCheckUpdate:YES];
    
}

#pragma mark  友盟分享

-(void)umShareHander
{
    //@"https://itunes.apple.com/cn/app/jiu-yang-yun-jia-dian/id929607381?mt=8"
    [UMSocialData setAppKey:kUMeng_KEY];
    
    [UMSocialConfig showNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:KWeiXin_AppID appSecret:KWeiXin_AppSecret url:@"https://itunes.apple.com/cn/app/jiu-yang-yun-jia-dian/id929607381?mt=8"];
    
    NSLog(@"%@",@([WXApi isWXAppInstalled]));
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
