//
//  News.m
//  DiandianNews
//
//  Created by Duger on 13-12-4.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize newsId;
@synthesize title;
@synthesize type;
@synthesize cid;
@synthesize cname;
@synthesize newsUrl;
@synthesize typeId;
@synthesize sequence;
@synthesize lastUpdateTime;
@synthesize PUBLISHDATE;
@synthesize picUrl;
@synthesize summary;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
