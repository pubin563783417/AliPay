//
//  UIView+SBCollectionCell.m
//  AliPay
//
//  Created by qyb on 2017/5/24.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "UIView+SBCollectionCell.h"
#import <objc/runtime.h>
@implementation UIView (SBCollectionCell)

- (void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self, @selector(indexPath), indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)indexPath{
    return objc_getAssociatedObject(self, _cmd);
}
@end
