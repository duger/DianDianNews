//
//  CustomCollectionCell.m
//  DiandianNews
//
//  Created by Duger on 13-12-18.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "CustomCollectionCell.h"

@implementation CustomCollectionCell

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        //初始化时加载customcollectionCell.xib
//        NSArray *viewsArray = [[NSBundle mainBundle]loadNibNamed:@"CustomCollectionCell" owner:self options:nil];
//        //如果路径不存在return nil
//        if (viewsArray.count < 1) {
//            return nil;
//        }
//        //如果xib中的view，不属于UICollectionViewCell，返回nil
//        if (![[viewsArray objectAtIndex:0]isKindOfClass:[UICollectionViewCell class]]) {
//            return nil;
//        }
//        //加载nib
//        self = [viewsArray objectAtIndex:0];
//        
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        
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

- (void)dealloc {
    [_newsImage release],_newsImage = nil;
    [_newsTitle release],_newsTitle = nil;
    [_newsSummary release],_newsSummary = nil;
    [super dealloc];
}

-(void)collectionView:(UICollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    NSDictionary *aNews = (NSDictionary *)object;
    //    NSLog(@"%@",[aNews objectForKey:@"summary"]);
    
    self.newsSummary.text = [aNews objectForKey:@"summary"];
    self.newsSummary.numberOfLines = 0;
    self.newsSummary.lineBreakMode = NSLineBreakByTruncatingTail;
    //    self.summaryLabel.frame = CGRectMake(5, 155, 230, summaryLabelRect.size.height);
    
    
    
    CGRect titleLableRect = [self getNewsLabelSize:[aNews objectForKey:@"title"]];
    self.newsTitle.text = [aNews objectForKey:@"title"];
    self.newsTitle.numberOfLines = 0;
    self.newsTitle.lineBreakMode = NSLineBreakByWordWrapping;
    self.newsTitle.frame = CGRectMake(5, 120, 240, titleLableRect.size.height);

}



-(CGRect)getNewsLabelSize:(NSString *)string
{
    
    
    CGSize max = CGSizeMake(200, 200.0f);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string];
    
    CGRect labelSize = [attributedString boundingRectWithSize:max options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    [attributedString release];
    labelSize.size.height *= 2;
    //    [shareLabel setFrame:labelsize];
    return labelSize;
}


@end
