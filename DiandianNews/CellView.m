//
//  CellView.m
//  DiandianNews
//
//  Created by Duger on 13-12-5.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "CellView.h"
#import "News.h"

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

-(void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    NSDictionary *aNews = (NSDictionary *)object;
//    NSLog(@"%@",[aNews objectForKey:@"summary"]);

    self.summaryLabel.text = [aNews objectForKey:@"summary"];
    self.summaryLabel.numberOfLines = 0;
    self.summaryLabel.lineBreakMode = NSLineBreakByTruncatingTail;
//    self.summaryLabel.frame = CGRectMake(5, 155, 230, summaryLabelRect.size.height);
    
    
    
    CGRect titleLableRect = [self getNewsLabelSize:[aNews objectForKey:@"title"]];
    self.titleLabel.text = [aNews objectForKey:@"title"];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.frame = CGRectMake(5, 120, 200, titleLableRect.size.height);
    
    self.image.frame = CGRectMake(0, 0, self.bounds.size.width, self.image.bounds.size.height);
}

+ (CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth{
    NSDictionary *aNews =(NSDictionary *)object;
    CGFloat hight = [self getLabelHight:[aNews objectForKey:@"summary"]] ;
    return hight;
}

+(CGFloat)getLabelHight:(NSString *)string
{
    CGSize max = CGSizeMake(220, 200.0f);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string];
    CGRect labelSize = [attributedString boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    [attributedString release];
    labelSize.size.height *= 2;
    //    [shareLabel setFrame:labelsize];
    return labelSize.size.height;
}

-(CGRect)getNewsLabelSize:(NSString *)string
{
    
    
    CGSize max = CGSizeMake(200, 200.0f);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string];
    
    CGRect labelSize = [attributedString boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    labelSize.size.height *= 2;
    //    [shareLabel setFrame:labelsize];
    return labelSize;
}

- (void)dealloc {
    [_titleLabel release];
    [_summaryLabel release];
    [_image release];
    [super dealloc];
}
@end
