//
//  ViewController.m
//  QuartzRunner
//
//  Created by Elevation Recording  on 1/17/13.
//  Copyright (c) 2013 integritas. All rights reserved.
//

#import "ViewController.h"
//#import "GameView.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    gameView = [[GameView alloc] initWithFrame:self.view.frame];//CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:gameView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
