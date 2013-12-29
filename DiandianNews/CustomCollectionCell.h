//
//  CustomCollectionCell.h
//  DiandianNews
//
//  Created by Duger on 13-12-18.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *newsImage;
@property (retain, nonatomic) IBOutlet UILabel *newsTitle;
@property (retain, nonatomic) IBOutlet UILabel *newsSummary;


-(void)collectionView:(UICollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index;
@end
