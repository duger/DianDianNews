//
//  AppDelegate.h
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WBApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "AGViewDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>
{
    enum WXScene _scene;
    AGViewDelegate *_viewDelegate;
    SSInterfaceOrientationMask _interfaceOrientationMask;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) AGViewDelegate *viewDelegate;
@end
