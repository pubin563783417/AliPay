//
//  ZFBFirstFootListView.m
//  AliPay
//
//  Created by qyb on 2017/5/3.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ZFBFirstFootListView.h"

@interface ZFBFirstFootListView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation ZFBFirstFootListView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        CALayer *layer = [[CALayer alloc] init];
        
    }
    
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}
@end
