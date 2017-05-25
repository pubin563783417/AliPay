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

- (void)setUserInteractionEnabledForAllowClick:(BOOL)allowClick{
    
    if (allowClick && !self.userInteractionEnabled) {
        self.userInteractionEnabled = allowClick;
    }else if (!allowClick && self.userInteractionEnabled){
        self.userInteractionEnabled = allowClick;
    }
    
}

- (void)setClickItem:(void (^)(NSIndexPath *))clickItem{
    if (!self.clickItem && clickItem) {
        objc_setAssociatedObject(self, @selector(clickItem), clickItem, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}
- (void (^)(NSIndexPath *))clickItem{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.clickItem) {
        self.clickItem(self.indexPath);
    }
}
@end
