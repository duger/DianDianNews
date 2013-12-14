//
//  News.h
//  DiandianNews
//
//  Created by Duger on 13-12-4.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property(nonatomic,copy) NSString *newsId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,retain) NSNumber *cid;
@property(nonatomic,retain) NSString *cname;
@property(nonatomic,retain) NSURL *newsUrl;
@property(nonatomic,retain) NSNumber *typeId;
@property(nonatomic,retain) NSNumber *sequence;
@property(nonatomic,retain) NSDate *lastUpdateTime;
@property(nonatomic,retain) NSDate *PUBLISHDATE;
@property(nonatomic,copy) NSString *picUrl;
@property(nonatomic,copy) NSString *summary;

@end
