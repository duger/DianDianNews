//
//  NewURLRequest.m
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "NewURLRequest.h"

@implementation NewURLRequest
-(void)webRequest:(NSURL *)requestURL
{
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        NSLog(@"%d",responseCode);
        NSError *error;
        if (!connectionError && responseCode== 200) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            [self.delegate compliteRequestWithDic:dic];
        }else
            [self.delegate compliteRequestWithError:connectionError];
        
    }];
    
}

@end
