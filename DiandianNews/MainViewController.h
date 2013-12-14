//
//  MainViewController.h
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THGridMenu.h"
#import "Columns.h"

@interface MainViewController : UIViewController<ColumnsDelegate>
@property (retain, nonatomic) IBOutlet UIView *centerView;
@property (nonatomic, strong) THGridMenu *menuView;
@property (nonatomic, strong) NSArray *selectedColumns;
@end
