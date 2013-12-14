//
//  ReaderViewController.h
//  DiandianNews
//
//  Created by Duger on 13-12-4.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "AGViewDelegate.h"
@class AppDelegate;

@interface ReaderViewController : UIViewController<SwipeViewDataSource,SwipeViewDelegate,UIWebViewDelegate>
{
    AppDelegate *_appDelegate;
}
- (IBAction)didClickBackButton:(UIButton *)sender;
- (IBAction)didClickShareButton:(UIButton *)sender;
- (IBAction)didClickNightButton:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet SwipeView *swipeView;

@property (retain, nonatomic) NSArray *currentColumnArr;
@property (assign, nonatomic) NSInteger newsIndex;
@property (copy, nonatomic) NSString *urlString;
@end
