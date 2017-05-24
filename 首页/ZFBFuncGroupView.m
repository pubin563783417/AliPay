//
//  ZFBTopFuncView.m
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ZFBTopFuncView.h"
@interface ZFBTopFuncView()
@end
@implementation ZFBTopFuncView
- (instancetype)initWithFrame:(CGRect)frame Items:(NSMutableArray *)items tapBlock:(void(^)(NSInteger index))block{
    if (self = [super init]) {
        self.frame = frame;
        
    }
    return self;
}

- (ASButtonNode *)createItemWithTitle:(NSString *)title Image:(UIImage *)image{
    ASButtonNode *button = [[ASButtonNode alloc] init];
    [button setImage:image forState:ASControlStateNormal];
    [button setTitle:title withFont:[UIFont systemFontOfSize:12] withColor:[UIColor grayColor] forState:ASControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:ASControlNodeEventTouchUpInside];
    return button;
}
- (void)click:(ASButtonNode *)button{
    
}
@end
