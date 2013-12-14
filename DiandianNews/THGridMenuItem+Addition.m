//
//  THGridMenuItem+Addition.m
//  DiandianNews
//
//  Created by Duger on 13-12-6.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "THGridMenuItem+Addition.h"

@implementation THGridMenuItem (Addition)
-(void)addTitle:(NSString *)title {
    self.backgroundColor = [UIColor whiteColor];
    CGRect parentFrame = self.frame;
    CGFloat margin = 10.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2), parentFrame.size.height);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.contentMode = UIViewContentModeScaleAspectFit;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:[titleLabel autorelease]];
}
@end
