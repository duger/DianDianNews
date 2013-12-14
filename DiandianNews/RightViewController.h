//
//  RightViewController.h
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end
