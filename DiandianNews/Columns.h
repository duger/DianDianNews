//
//  Columns.h
//  DiandianNews
//
//  Created by Duger on 13-12-6.
//  Copyright (c) 2013年 Duger. All rights reserved.
//
typedef NS_ENUM(NSInteger, ColumnIndex){
    Column1 = 213,
    Column2 = 214,
    Column3 = 220,
    Column4 = 215,
    Column5 = 216,
    Column6 = 217,
    Column7 = 218,
    Column8 = 219
    
};
#import "THGridMenuItem.h"


@protocol ColumnsDelegate <NSObject>

-(void)goToPreView:(THGridMenuItem *)menuItem;

@end


@interface Columns : THGridMenuItem

@property(nonatomic,assign) id<ColumnsDelegate> delegate;
@property(nonatomic,assign) ColumnIndex columnIndex;
@property(nonatomic,retain) UITapGestureRecognizer *tapGesture;


-(void)addTitle:(NSString *)title;
@end
