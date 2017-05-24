//
//  ZFBTopFuncView.h
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFBFuncGroupView : UIView
- (instancetype)initWithFrame:(CGRect)frame Items:(NSMutableArray *)items tapBlock:(void(^)(NSInteger index, NSString * title))block;
- (void)reload:(NSArray *)items;
@end
@interface ZFBFuncGrouItemModel : NSObject
+ (float)tableHeightForItemCount:(NSInteger)count;
@property (copy,nonatomic) NSString *title;
@property (assign,nonatomic) NSInteger index;
@property (copy,nonatomic) NSString *imageUrl;
@end
