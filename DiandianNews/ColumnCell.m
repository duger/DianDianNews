//
//  ColumnCell.m
//  DiandianNews
//
//  Created by Duger on 13-12-12.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "ColumnCell.h"

@interface ColumnCell ()
{
    BOOL _selectedOrNot;
}
@end

@implementation ColumnCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        UIImage *seletedImage = [UIImage imageNamed:@"select.png"];
//        self.chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [self.chooseButton setImage:seletedImage forState:UIControlStateNormal];
//        self.chooseButton.frame = CGRectMake(200, 20, 70, 70);
//        self.accessoryView = self.chooseButton;
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_columnTitleLabel release];
    [_chooseButton release];

    [super dealloc];
}

-(void)setState:(BOOL)state
{
    _selectedOrNot = state;
    if (state) {
        self.chooseButton.imageView.image = [UIImage imageNamed:@"selected"];
    }
    self.chooseButton.imageView.image = [UIImage imageNamed:@"select"];
    
}



- (IBAction)didClickChooseButton:(UIButton *)sender {
    NSLog(@"点点");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"columnChanged" object:self userInfo:self.column];
}
@end
