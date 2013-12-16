//
//  RightViewController.m
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "RightViewController.h"
#import "NewsManager.h"
#import "ColumnCell.h"
#import "CustonButton.h"

@interface RightViewController ()
{
    NSMutableArray *columns;
}
@end

@implementation RightViewController

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
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithRed:134/255.0 green:202/255.0 blue:182/255.0 alpha:1];
    columns = [[NSMutableArray arrayWithArray:[[NewsManager defaultManager]getAllColumnDicFromPlist] ]retain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [columns count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ColumnCell" owner:nil options:nil];

    ColumnCell *cell = [nib lastObject];
    [cell setFrame:CGRectMake(0, 0, 300, 70)];
    NSDictionary *dic = [columns objectAtIndex:indexPath.row];
    cell.columnTitleLabel.text = [dic objectForKey:@"column"];
    UIImage *seletedImage = [UIImage imageNamed:@"selected.png"];
    UIImage *seletImage = [UIImage imageNamed:@"select.png"];
    CustonButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[[columns objectAtIndex:indexPath.row]objectForKey:@"selected"]isEqualToString:@"1"]) {
        [chooseButton setImage:seletedImage forState:UIControlStateNormal];
    }else
        [chooseButton setImage:seletImage forState:UIControlStateNormal];
    
    
    chooseButton.frame = CGRectMake(195, 20, 40, 40);
    cell.accessoryView = chooseButton;
    [chooseButton addTarget:self action:@selector(didClickChooseButton:forEvent:) forControlEvents:UIControlEventTouchUpInside];

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(void)didClickChooseButton:(UIButton *)button forEvent:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        [self tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点点");
    NSString *isSelected = [[columns objectAtIndex:indexPath.row]objectForKey:@"selected"];
    NSMutableDictionary *columnDic = [columns objectAtIndex:indexPath.row];
    if ([isSelected isEqualToString:@"1"]) {
        [columnDic setObject:@"0" forKey:@"selected"];
    }else
        [columnDic setObject:@"1" forKey:@"selected"];
    
    NSLog(@"%@",[columnDic description]);
   [self.tableView reloadData];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"columnChanged" object:self userInfo:columnDic];
}


@end
