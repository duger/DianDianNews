//
//  CustonButton.h
//  DiandianNews
//
//  Created by Duger on 13-12-12.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustonButton : UIButton

@property(nonatomic,assign) BOOL selectedOrNot;
-(void)setButtonState:(BOOL)state;
@end
