//
//  ColumnCell.h
//  DiandianNews
//
//  Created by Duger on 13-12-12.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColumnCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *columnTitleLabel;
@property (retain, nonatomic) IBOutlet UIButton *chooseButton;

@property (retain, nonatomic) NSDictionary *column;
- (IBAction)didClickChooseButton:(UIButton *)sender;
-(void)setState:(BOOL)state;
@end
