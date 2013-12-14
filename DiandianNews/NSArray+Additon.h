//
//  NSArray+Additon.h
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompeletBlock)();
@interface NSArray (Additon)
-(BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile completed:(CompeletBlock)block;
@end
