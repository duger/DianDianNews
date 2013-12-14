//
//  NewURLRequest.h
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NewURLRequestDelegate <NSObject>

@optional
-(void)compliteRequestWithDic:(NSDictionary *)resultDic;
-(void)compliteRequestWithError:(NSError *)error;

@end
@interface NewURLRequest : NSURLRequest
@property(nonatomic,assign) id<NewURLRequestDelegate>delegate;
@property(nonatomic,retain) NSDictionary *resultDic;
@property(nonatomic,copy) NSString *request;

-(void)webRequest:(NSURL *)requestURL;

@end
