//
//  NSArray+Additon.m
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "NSArray+Additon.h"

@implementation NSArray (Additon)
-(BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile completed:(CompeletBlock)block
{
    [self writeToFile:path atomically:useAuxiliaryFile];
    
    block();
    return NO;
}

@end
