//
//  SBCollectionView.h
//  AliPay
//
//  Created by qyb on 2017/5/12.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBCollectionProtocol.h"
@interface SBCollectionView : UIView
//最小水平距离 defaults 0
@property (assign,nonatomic) CGFloat minHorizontalSpace;
//垂直距离 defaults 0
@property (assign,nonatomic) CGFloat verticalSpace;
//允许缓存 defaults YES
@property (assign,nonatomic) BOOL allowCache;

@property (assign,nonatomic) UIEdgeInsets contentInset;

@property (assign,nonatomic) CGSize itemSize;

@property (assign,nonatomic) NSInteger itemCount;

@property (copy,nonatomic) UIView * (^item)(SBCollectionView *cv,NSIndexPath *indexPath);
@property (copy,nonatomic) UIView * (^reloadItem)(SBCollectionView *cv,UIView *item,NSIndexPath *indexPath);
@property (weak,nonatomic) id <SBCollectionProtocol> delegate;

- (void)reloadData;
@end
