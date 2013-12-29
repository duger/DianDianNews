//
//  MainViewController.m
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "MainViewController.h"
#import "THGridMenuItem.h"
#import "Columns.h"
#import "PreViewViewController.h"
#import "UIViewController+ADFlipTransition.h"
#import "NewsManager.h"
#import "NewsCollectionViewController.h"



@interface MainViewController ()

@end

@implementation MainViewController
@synthesize menuView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedColumns = [[NewsManager defaultManager]getColumnDicFromPlist];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //获得通知改变栏目数目
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeColumns:) name:@"changeColumns" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBackgroundColor:) name:@"changeBackgroundColor" object:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self menuSetOrReset];
    self.centerView.backgroundColor = [UIColor blackColor];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    menuView = nil;
    self.selectedColumns = nil;
    self.centerView = nil;

    [super dealloc];
}

-(void)menuSetOrReset
{
    menuView = nil;
    menuView = [[THGridMenu alloc]initWithColumns:3 marginSize:30 gutterSize:80 rowHeight:150];

    [self.centerView addSubview:menuView];
    [self populateMenu];

    
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [menuView orientationChange];
}


-(void)populateMenu {
    //Refresh data source (in this example, just read from the plist)
    
    NSArray *columnsArr = [[NewsManager defaultManager]getColumnsSelected];
    NSLog(@"栏目%@",[columnsArr description]);
    //Iterate through the data source
    NSInteger tag = 1;
    for (NSString *title in columnsArr) {
       
        Columns *menuItem = [menuView createMenuItem];
        menuView.backgroundColor = [UIColor colorWithRed:82/255.0f green:170/255.0f blue:193/255.0f alpha:1];
        menuItem.backgroundColor = [UIColor purpleColor];
        menuItem.delegate = self;
        [menuItem addTitle:title];
        
        menuItem.tag = tag;
        switch (tag) {
            case 1:
                menuItem.columnIndex = Column1;

                NSLog(@"%d",Column1);
                tag++;
                break;
            case 2:
                menuItem.columnIndex = Column2;

                tag++;
                break;
            case 3:
                menuItem.columnIndex = Column3;

                tag++;
                break;
            case 4:
                menuItem.columnIndex = Column4;

                tag++;
                break;
            case 5:
                menuItem.columnIndex = Column5;

                tag++;
                break;
            case 6:
                menuItem.columnIndex = Column6;

                tag++;
                break;
            case 7:
                menuItem.columnIndex = Column7;

                tag++;
                break;
            case 8:
                menuItem.columnIndex = Column8;

                tag++;
                break;
                
            default:
                break;
        }
        
        
        [menuView addSubview:menuItem];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}



#pragma mark -
#pragma mark GridMenuItem Delegate
-(void)goToPreView:(Columns *)menuItem
{
    NSLog(@"出现了");
    PreViewViewController *preViewVC = [[PreViewViewController alloc]initWithNibName:@"PreViewViewController" bundle:[NSBundle mainBundle]];
    preViewVC.currentColumn = menuItem.columnIndex;
    preViewVC.view.backgroundColor = [UIColor colorWithRed:134/255.0f green:202/255.0f blue:182/255.0f alpha:1];
    
    
    //
    NewsCollectionViewController *newsVC = [[NewsCollectionViewController alloc]initWithNibName:@"NewsCollectionViewController" bundle:[NSBundle mainBundle]];

    newsVC.currentColumn = menuItem.columnIndex;
    newsVC.view.backgroundColor = [UIColor colorWithRed:134/255.0f green:202/255.0f blue:182/255.0f alpha:1];
    
    [self presentViewController:newsVC animated:YES completion:nil];
//    [self flipToViewController:newsVC fromView:menuItem withCompletion:nil];
    [newsVC release];


    
    NSDictionary *currentColumnDic = [self.selectedColumns objectAtIndex:menuItem.tag - 1];
    NSTimeInterval time = [((NSNumber *)[currentColumnDic objectForKey:@"lastUpdate"])doubleValue];
    NSLog(@"%f",time);
    NSTimeInterval currentTime = [[NSDate date]timeIntervalSince1970];
    NSLog(@"%.f",currentTime);
    if (currentTime - time > 7200.0) {
        [[NewsManager defaultManager]updateNews:menuItem.columnIndex];
    }else
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreashNow" object:nil];
}

#pragma mark -
#pragma mark Notification
-(void)changeColumns:(id)sender
{
    [self menuSetOrReset];
}

-(void)changeBackgroundColor:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"nightOrDay"]) {
        self.view.backgroundColor = [UIColor grayColor];
    }
}
@end
