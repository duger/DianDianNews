//
//  CellView.h
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "PSCollectionViewCell.h"

@interface CellView : PSCollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *picView;
@property (retain, nonatomic) UILabel *title;
@property (retain, nonatomic) UILabel *summary;
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *summaryLabel;

-(void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index;

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth;
@end
