//
//  CustonButton.m
//  DiandianNews
//
//  Created by Duger on 13-12-12.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "CustonButton.h"

@interface CustonButton ()
{
    
}
@end

@implementation CustonButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)setButtonState:(BOOL)state
{
    self.selectedOrNot = state;
    if (state) {
        self.imageView.image = [UIImage imageNamed:@"selected.png"];
    }
    self.imageView.image = [UIImage imageNamed:@"select.png"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
