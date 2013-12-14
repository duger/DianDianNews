//
//  LeftViewController.m
//  DiandianNews
//
//  Created by Duger on 13-12-3.
//  Copyright (c) 2013年 Duger. All rights reserved.
//

#import "LeftViewController.h"



@interface LeftViewController ()

@end

@implementation LeftViewController

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
    self.view.backgroundColor = [UIColor blueColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {


    [super dealloc];
}




- (IBAction)didClickNightOrDayButton:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeBackgroundColor" object:self];
}

- (IBAction)didClickRemarkButton:(UIButton *)sender {
}


@end
