//
//  PreViewViewController.m
//  DiandianNews
//
//  Created by Duger on 13-12-4.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "PreViewViewController.h"
#import "UIImageView+WebCache.h"
#import "CellView.h"
#import "NewsManager.h"
#import "UIViewController+ADFlipTransition.h"
#import "ReaderViewController.h"

#define kNewsCellHight 330

@interface PreViewViewController ()

@end

@implementation PreViewViewController
@synthesize theCollectionView;

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
    theCollectionView = [[PSCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height )];
    self.theCollectionView.delegate = self;
    self.theCollectionView.collectionViewDataSource = self;
    self.theCollectionView.collectionViewDelegate = self;
    self.headerView.backgroundColor = [UIColor colorWithRed:54/255.0 green:181/255.0 blue:150/255.0 alpha:1];
    theCollectionView.backgroundColor = [UIColor colorWithRed:54/255.0 green:181/255.0 blue:150/255.0 alpha:1];
    self.footerView.backgroundColor = [UIColor colorWithRed:82/255.0 green:170/255.0 blue:193/255.0 alpha:1];
    theCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
    theCollectionView.numColsLandscape = 4;
    theCollectionView.numColsPortrait = 3;

    self.centerView.backgroundColor = [UIColor clearColor];
    self.centerView.clipsToBounds = YES;
    [self.centerView addSubview:theCollectionView];
    [theCollectionView release];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didReceiveRefeashNoti:) name:@"refreashNow" object:nil];
    
//    self.newsArray = [[NewsManager defaultManager]readFromNewsPlist:self.currentColumn];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d",self.currentColumn);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_headerView release];
    [theCollectionView release];
    [_centerView release];
    [_footerView release];
    [_newsArray release];
    
    [super dealloc];
}
#pragma mark -
#pragma mark Notification
-(void)didReceiveRefeashNoti:(id)sender
{
    self.newsArray = [[NewsManager defaultManager]readFromNewsPlist:self.currentColumn];
    [theCollectionView reloadData];
}


#pragma mark PSCollection Delegate
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    CellView *cellView = (CellView *)[self.theCollectionView dequeueReusableViewForClass:[self.theCollectionView class]];
    //    if (!v) {
    //        v = [[[PSCollectionViewCell alloc] initWithFrame:CGRectZero] autorelease];
    //    }
    if(cellView == nil) {
        NSArray *nib =
        [[NSBundle mainBundle] loadNibNamed:@"CellView" owner:self options:nil];
        cellView = [nib objectAtIndex:0];
    }
    
//    [cellView.picView setImage:[UIImage imageNamed:@"test.png"]];
    NSDictionary *news = [self.newsArray objectAtIndex:index];
    [cellView collectionView:self.theCollectionView fillCellWithObject:news atIndex:index];
    [cellView.image setImageWithURL:[news objectForKey:@"picUrl"] placeholderImage:[UIImage imageNamed:@"placeHolderImage.jpg"]];
    cellView.backgroundColor = [UIColor colorWithRed:199/255.0 green:232/255.0 blue:250/255.0 alpha:1];
    return cellView;
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    NSLog(@"%d",[self.newsArray count]);
    return [self.newsArray count];
    
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{

//    return [CellView rowHeightForObject:news inColumnWidth:self.theCollectionView.colWidth];
    return kNewsCellHight;
}

-(void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    NSLog(@"选到新闻了%d",index);
    ReaderViewController *readerVC = [[ReaderViewController alloc]initWithNibName:@"ReaderViewController" bundle:[NSBundle mainBundle]];
    readerVC.currentColumnArr = self.newsArray;
    
    readerVC.newsIndex = index;
    [self flipToViewController:readerVC fromView:cell withCompletion:^{
        
    }];
}



- (IBAction)didClickBackButton:(UIButton *)sender {
    [self dismissFlipWithCompletion:nil];
    theCollectionView = nil;
    _newsArray = nil;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
