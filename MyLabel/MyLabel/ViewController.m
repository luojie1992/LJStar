//
//  ViewController.m
//  MyLabel
//
//  Created by 东莞证券lj on 17/5/3.
//  Copyright © 2017年 dgzq. All rights reserved.
//

#import "ViewController.h"
#import "LJLoopView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LJLoopView *loopView = [[LJLoopView alloc] initWithFrame:CGRectMake(100, 100, 200, 60)] ;
    loopView.backgroundColor = [UIColor lightGrayColor] ;
    [loopView start] ; 
    [self.view addSubview:loopView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
