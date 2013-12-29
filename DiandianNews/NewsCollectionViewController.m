//
//  NewsCollectionViewController.m
//  DiandianNews
//
//  Created by Duger on 13-12-18.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#define kCell @"CustomCollectionCell"

#import "NewsCollectionViewController.h"
#import "CustomCollectionCell.h"
#import "NewsManager.h"
#import "UIImageView+WebCache.h"


#import "UIViewController+ADFlipTransition.h"
#import "ReaderViewController.h"

void safeRelease(NSObject *object){
    [object release],object = nil;
}

@interface NewsCollectionViewController ()

@end

@implementation NewsCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //声明Cell的类
//    [self.collectionView registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:kCell];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:kCell];
//    UICollectionViewLayout *layout = nil;
//    [self.collectionView setCollectionViewLayout:layout];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveRefeashNoti:) name:@"refreashNow" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"获得内存警告！！");
    self.collectionView = nil;
    self.newsArray = nil;
    safeRelease(_collectionView);
}

#define kSafeRelease(object) [object release],object = nil

- (void)dealloc {
    NSLog(@"释放啦！！！");
    [_collectionView release];
    [_newsArray release],_newsArray = nil;
//    self.newsArray = nil;
    [super dealloc];
}

- (void)setNewsArray:(NSMutableArray *)newsArray
{
    if (_newsArray != newsArray) {
        [_newsArray release];
        _newsArray = [newsArray retain];
       
    }

}



- (IBAction)didClickBackButton:(UIButton *)sender {
//    [self dismissFlipWithCompletion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark Notification
-(void)didReceiveRefeashNoti:(id)sender
{
//    self.newsArray = [[[NSMutableArray alloc]initWithArray:[[NewsManager defaultManager]readFromNewsPlist:self.currentColumn]]autorelease];
    NSArray * oriArray = [[NewsManager defaultManager]readFromNewsPlist:self.currentColumn];
  self.newsArray = [[[NSMutableArray alloc]initWithArray:oriArray] autorelease];

    [self.collectionView reloadData];
}

#pragma -
#pragma mark Collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%d",self.newsArray.count);
    return self.newsArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionCell *customCell = (CustomCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
//    if (customCell == nil) {
//        customCell = [[CustomCollectionCell alloc]init];
//    }
    NSDictionary *news = [self.newsArray objectAtIndex:indexPath.row];
    [customCell collectionView:self.collectionView fillCellWithObject:news atIndex:indexPath.row];
    [customCell.newsImage setImageWithURL:[news objectForKey:@"picUrl"] placeholderImage:[UIImage imageNamed:@"placeHolderImage.jpg"]];
 
    return customCell;
}

@end
