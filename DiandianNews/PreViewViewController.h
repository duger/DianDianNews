//
//  PreViewViewController.h
//  DiandianNews
//
//  Created by Duger on 13-12-4.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"
#import "Columns.h"

@interface PreViewViewController : UIViewController<PSCollectionViewDataSource,PSCollectionViewDelegate,UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIView *headerView;
@property (retain, nonatomic) PSCollectionView *theCollectionView;
@property (retain, nonatomic) IBOutlet UIView *centerView;

@property (retain, nonatomic) IBOutlet UIView *footerView;
- (IBAction)didClickBackButton:(UIButton *)sender;
@property (retain, nonatomic) NSArray *newsArray;
@property (assign,nonatomic ) ColumnIndex currentColumn;
@end
