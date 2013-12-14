//
//  AppDelegate.m
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "NewsManager.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <RennSDK/RennSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //复制Column.plist 和 刷新新闻
    [[NewsManager defaultManager]setUp];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    RightViewController *rightVC = [[RightViewController alloc]init];
    
    MMDrawerController *drawerC = [[MMDrawerController alloc]initWithCenterViewController:mainVC leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
    [mainVC release];
    [leftVC release];
    [rightVC release];
    
    [drawerC setMaximumLeftDrawerWidth:200 animated:YES completion:^(BOOL finished) {
        nil;
    }];
    [drawerC setMaximumRightDrawerWidth:300 animated:YES completion:^(BOOL finished) {
        nil;
    }];
    [drawerC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModePanningCenterView|MMCloseDrawerGestureModeBezelPanningCenterView|MMCloseDrawerGestureModeTapCenterView];
    [drawerC setCenterHiddenInteractionMode:MMDrawerOpenCenterInteractionModeFull];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = drawerC;
    [drawerC release];
    
    
    [ShareSDK registerApp:@"iosv1101"];
    //转换链接标记
    [ShareSDK convertUrlEnabled:YES];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"
                                   wbApiCls:[WBApi class]];
    
    //添加QQ空间应用
    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加人人网应用
    [ShareSDK connectRenRenWithAppId:@"226427"
                              appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                           appSecret:@"f29df781abdd4f49beca5a2194676ca4"
                   renrenClientClass:[RennClient class]];
    
    //添加微信应用
    [ShareSDK connectWeChatWithAppId:@"wx6dd7a9b94f3dd72a"        //此参数为申请的微信AppID
                           wechatCls:[WXApi class]];
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
