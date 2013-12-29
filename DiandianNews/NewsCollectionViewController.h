//
//  NewsCollectionViewController.h
//  DiandianNews
//
//  Created by Duger on 13-12-18.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Columns.h"


@interface NewsCollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (retain, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)didClickBackButton:(UIButton *)sender;
@property (retain, nonatomic) NSMutableArray *newsArray;
@property (assign,nonatomic ) ColumnIndex currentColumn;
@end
