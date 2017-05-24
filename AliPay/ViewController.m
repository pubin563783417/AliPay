//
//  ViewController.m
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic) UITableView *tableview;
@property (strong,nonatomic) UIScrollView *mainScrollView;
@property (strong,nonatomic) UICollectionView *funcGroupView;
@property (strong,nonatomic) UIView *topFuncView;
@property (strong,nonatomic) UIView *naviCoverView;
@property (strong,nonatomic) UIView *naviView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
    // Do any additional setup after loading the view, typically from a nib.
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    _mainScrollView.delegate = self;
    _mainScrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height-64);
    _mainScrollView.bounces = NO;
    [self.view addSubview:_mainScrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
