//
//  Columns.m
//  DiandianNews
//
//  Created by Duger on 13-12-6.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "Columns.h"

@implementation Columns

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor lightGrayColor];
        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapReceive:)];
        [self addGestureRecognizer:self.tapGesture];
    }
    return self;
}

-(void)addTitle:(NSString *)title {
    self.backgroundColor = [UIColor whiteColor];
    CGRect parentFrame = self.frame;
    CGFloat margin = 10.0;
    CGRect titleFrame = CGRectMake(margin, 0.0, parentFrame.size.width - (margin *2), parentFrame.size.height);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.contentMode = UIViewContentModeScaleAspectFit;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:[titleLabel autorelease]];
}



-(void)didTapReceive:(UITapGestureRecognizer *)sender
{
    
   if (self.delegate && [self.delegate respondsToSelector:@selector(goToPreView:)]) {
    [self.delegate goToPreView:self];
    NSLog(@"点到了");
       }
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //  Display the animation no matter if the gesture fails or not
    BOOL retVal = YES;
    
    /*  From http://developer.apple.com NSObject class reference
     *  You cannot test whether an object inherits a method from its superclass by sending respondsToSelector:
     *  to the object using the super keyword. This method will still be testing the object as a whole, not just
     *  the superclass’s implementation. Therefore, sending respondsToSelector: to super is equivalent to sending
     *  it to self. Instead, you must invoke the NSObject class method instancesRespondToSelector: directly on
     *  the object’s superclass */
    
    SEL aSel = @selector(gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:);
    
    /*  You cannot simply use [[self superclass] instancesRespondToSelector:@selector(aMethod)]
     *  since this may cause the method to fail if it is invoked by a subclass. */
    
    if ([UIView instancesRespondToSelector:aSel]){
        retVal = [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
    [self displayHighlightAnimation];
    return retVal;
}

-(void)displayHighlightAnimation{
    
    self.alpha = 0.3;
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.alpha = 1;
                     }
                     completion:^(BOOL completed){
                         // Do nothing. This is only visual feedback.
                         // See simpleExclusiveTapRecognized instead
                     }];
    
}

@end
