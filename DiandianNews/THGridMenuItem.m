//
//  THGridMenuItem.m
//  THGridMenu
//
//  Created by Troy HARRIS on 5/12/13.
//

#import "THGridMenuItem.h"

@implementation THGridMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizesSubviews:YES];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
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
