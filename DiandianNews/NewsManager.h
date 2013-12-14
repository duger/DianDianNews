//
//  NewsManager.h
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewURLRequest.h"
#import "Columns.h"
@protocol NewsManagerDelegate<NSObject>
-(void)didFinishWritePlist;

@end


@interface NewsManager : NSObject<NewURLRequestDelegate>
+(NewsManager *)defaultManager;
@property(nonatomic,assign) id<NewsManagerDelegate>delegate;
@property(nonatomic,retain) NSArray *newsArr;
@property(nonatomic,assign) NSInteger startRecord;
@property(nonatomic,assign) NSInteger cid;
//@property(nonatomic,retain) NSDate *lastUpdate;
@property(nonatomic,assign) ColumnIndex currentColumn;
@property(nonatomic,retain) NSMutableArray *selectedColumns;
@property(nonatomic,assign) NSTimeInterval lastUpdate;

//启动
-(void)setUp;
/*-----------------------------------------------------------------------
                    新闻  新闻
 -----------------------------------------------------------------------*/
-(void)updateNews:(ColumnIndex)column;
-(void)writeIntoNewsPlist:(NSArray *)array;
-(NSArray *)readFromNewsPlist:(ColumnIndex)column;
/*-----------------------------------------------------------------------
                    栏目  栏目
 -----------------------------------------------------------------------*/
//获得已经选择好的栏目
-(NSArray *)getColumnsSelected;
//获取所有选择好的栏目字典
-(NSArray *)getColumnDicFromPlist;
//获取所有的栏目字典
-(NSArray *)getAllColumnDicFromPlist;

@end
