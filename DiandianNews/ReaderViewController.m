//
//  ReaderViewController.m
//  DiandianNews
//
//  Created by Duger on 13-12-4.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "ReaderViewController.h"
#import "UIViewController+ADFlipTransition.h"
#import <AGCommon/UINavigationBar+Common.h>
#import <AGCommon/UIImage+Common.h>
#import <AGCommon/UIColor+Common.h>
#import <AGCommon/UIDevice+Common.h>
#import <AGCommon/NSString+Common.h>
#import "AGViewDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"
#define INHERIT_VALUE [SSInheritValue inherit]

@interface ReaderViewController ()
{
    UIActivityIndicatorView *activityIdicatorView;
}

@end

@implementation ReaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    activityIdicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 32.0f, 32.0f)];
    [activityIdicatorView setCenter:self.view.center];
    [activityIdicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [self.view addSubview:activityIdicatorView];
    [activityIdicatorView release];
    [self.swipeView scrollToPage:self.newsIndex duration:0];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"hahah");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    self.swipeView.delegate = nil;
    self.swipeView.dataSource = nil;
    self.swipeView = nil;
    self.currentColumnArr = nil;
    
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)didClickBackButton:(UIButton *)sender {
    [self dismissFlipWithCompletion:NULL];
    
}

- (IBAction)didClickShareButton:(UIButton *)sender {
    
    [self simpleShareAllButtonClickHandler:sender];
}

- (IBAction)didClickNightButton:(UIButton *)sender {
    UIWebView *webView = (UIWebView *)[self.swipeView viewWithTag:7777];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('body')[0].style.background = '#00ff';"];
    
}

#pragma mark -
#pragma mark iCarousel methods
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.currentColumnArr.count;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSDictionary *currentNews = [self.currentColumnArr objectAtIndex:index];
    self.urlString = [currentNews objectForKey:@"newsUrl"];
    NSString *html;
    NSLog(@"%@",[currentNews objectForKey:@"newsHtml"]);
    if (![currentNews objectForKey:@"newsHtml"]) {
       html = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.urlString] encoding:NSUTF8StringEncoding error:nil];
        
        html = [html stringByReplacingOccurrencesOfString:@"<link href=\"../../../Styles/RBstyle_phone.css\" rel=\"stylesheet\" type=\"text/css\" />" withString:@"<link href=\"RBstyle_phone.css\" rel=\"stylesheet\" type=\"text/css\" />"];
        html = [html stringByReplacingOccurrencesOfString:@"<link href=\"../../../Styles/bwxsj.css\" rel=\"stylesheet\" type=\"text/css\" />" withString:@"<link href=\"bwxsj.css\" rel=\"stylesheet\" type=\"text/css\" />"];
        
        html = [html stringByReplacingOccurrencesOfString:@"../../.." withString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication"];
    }else
        html = [currentNews objectForKey:@"newsHtml"];
    
    
    NSLog(@"%@",html);
//    NSString *html = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"news" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    
    
    UIWebView *webView;
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:self.view.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.tag = 7777;
        webView.backgroundColor = [UIColor redColor];
        
        [view addSubview:webView];

        
        
    }else{
        
        //使用回收的view
        [view setFrame:self.view.bounds];
        webView = (UIWebView *)[view viewWithTag:7777];
        [webView setFrame:self.view.bounds];
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        webView.backgroundColor = [UIColor redColor];
        
        [view addSubview:webView];

    }
   
    
    [webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]resourcePath]]];
    NSLog(@"%@",webView.class);
    return view;
    
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self reloadInputViews];
}

#pragma mark -
#pragma mark WevView delegate
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIdicatorView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIdicatorView stopAnimating];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"出错！" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [alterview show];
    [alterview release];
}

#pragma mark - shareSDK分享

/*
- (void)shareClickHandler:(UIButton *)sender withShareViewWithType:(ShareType)shareType
{
//    @(ShareTypeSinaWeibo)
    //创建分享内容
    //    NSLog(@"%@",newsVC.shareTitle);
    //    NSLog(@"%@",newsVC.shareUrl);
    //    NSLog(@"%@",newsVC.shareSummary);
    //    NSLog(@"%@",newsVC.sharePicUrl);
    id<ISSContent> publishContent = [ShareSDK content:@"王甫"
                                       defaultContent:nil
                                                image:nil
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionDown];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:shareType
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:_appDelegate.viewDelegate
                                                       friendsViewDelegate:_appDelegate.viewDelegate
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 if (state == SSPublishContentStateSuccess)
                                 {
                                     UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"发布成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                     [alertView show];
                                 }
                                 else if (state == SSPublishContentStateFail)
                                 {
                                     NSLog(@"发布失败!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                 }
                             }];
}

*/

- (void)simpleShareAllButtonClickHandler:(id)sender
{
    id<ISSShareActionSheetItem> diandianer = [ShareSDK shareActionSheetItemWithTitle:@"点点儿"
                                                                            icon:[UIImage imageNamed:@"Icon.png"]
                                                                    clickHandler:^{
                                                                        NSLog(@"执行你的分享代码!");
                                                                        
                                                                        
                                                                    }];
    
    
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"测试"
                                       defaultContent:@""
                                                image:nil
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    //定制人人网信息
    [publishContent addRenRenUnitWithName:@"Hello 人人网"
                              description:nil
                                      url:nil
                                  message:@"Hello 人人网"
                                    image:nil
                                  caption:nil];
    //定制QQ空间信息
    [publishContent addQQSpaceUnitWithTitle:@"Hello QQ空间"
                                        url:INHERIT_VALUE
                                       site:nil
                                    fromUrl:nil
                                    comment:INHERIT_VALUE
                                    summary:INHERIT_VALUE
                                      image:INHERIT_VALUE
                                       type:INHERIT_VALUE
                                    playUrl:nil
                                       nswb:nil];
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:INHERIT_VALUE
                                           title:@"Hello 微信好友!"
                                             url:INHERIT_VALUE
                                           image:INHERIT_VALUE
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                          content:INHERIT_VALUE
                                            title:@"Hello 微信朋友圈!"
                                              url:nil
                                            image:INHERIT_VALUE
                                     musicFileUrl:@"http://mp3.mwap8.com/destdir/Music/2009/20090601/ZuiXuanMinZuFeng20090601119.mp3"
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    //创建自定义分享列表
    NSArray *shareList = [ShareSDK customShareListWithType:
                          diandianer,

                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                          SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                          SHARE_TYPE_NUMBER(ShareTypeRenren),
                          SHARE_TYPE_NUMBER(ShareTypeQQSpace),

                          nil];
    

    
    //结束定制信息
    ////////////////////////
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionDown];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:_appDelegate.viewDelegate];
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"内容分享"
                                                              oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                               qqButtonHidden:YES
                                                        wxSessionButtonHidden:YES
                                                       wxTimelineButtonHidden:YES
                                                         showKeyboardOnAppear:NO
                                                            shareViewDelegate:_appDelegate.viewDelegate
                                                          friendsViewDelegate:_appDelegate.viewDelegate
                                                        picViewerViewDelegate:nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}


@end
