//
//  ZFBTopFuncView.m
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ZFBFuncGroupView.h"
#define Index_Key @"funcIndex"
#define Item_width Screen_Width/4
@interface ZFBFuncGroupView()

@property (strong,nonatomic) NSMutableArray *items;
@property (strong,nonatomic) NSMutableDictionary *keys;
@property (copy,nonatomic) void(^block)(NSInteger index, NSString * title);
@property (strong,nonatomic) NSMutableSet * subSet;
@end
@implementation ZFBFuncGroupView
- (instancetype)initWithFrame:(CGRect)frame Items:(NSMutableArray *)items tapBlock:(void(^)(NSInteger index, NSString * title))block{
    if (self = [self init]) {
        self.frame = frame;
        
        _items = items;
        _block = block;
        if (!items) {
            _items = [NSMutableArray array];
        }
        [self reloadAll];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        _items = [NSMutableArray array];
        _keys = [NSMutableDictionary dictionary];
        _subSet = [NSMutableSet set];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
/**
 输入数据源刷新

 @param items 数据源
 */
- (void)reload:(NSArray *)items{
    int index = 0;
    for (ZFBFuncGrouItemModel *model in items) {
        NSAssert([model isKindOfClass:[ZFBFuncGrouItemModel class]], @"类型错误");
          UIButton *sub = [self updateItemWithModel:model index:index];
        [self addSubButton:sub index:index];
        index ++;
    }
    if (items.count<_items.count) {
        for (int index = items.count; index < _items.count; index ++) {
            [self removeSubAndCacheForIndex:index];
        }
    }
    _items = items.mutableCopy;
}

/**
 删除多余的 node

 @param index index
 */
- (void)removeSubAndCacheForIndex:(NSInteger )index{
    NSString *key = [self subKey:index];
      UIButton *node = [_keys objectForKey:key];
    [_keys removeObjectForKey:key];
    if (node) {
        [_subSet addObject:node];
        [node removeFromSuperview];
        
    }
}
- (void)reloadAll{
    [self reload:_items];
}

/**
 通过数据源更node

 @param model 数据源
 @param index index
 @return 更新后的node
 */
- (  UIButton *)updateItemWithModel:(ZFBFuncGrouItemModel *)model index:(NSInteger)index{
      UIButton *sub = [self subNode:index];
    if (sub == nil) {
        sub = [self subInCache];
    }
    if (sub == nil) {
        sub = [self createNewNote];
    }
    CGPoint origin = [self beforeItemPointForIndex:index];
    CGRect rect = CGRectMake(0, 0, Item_width, Item_width);
    rect.origin = origin;
    sub.frame = rect;
    
    sub.tag = index;
    [self setNode:sub title:model.title Image:model.imageUrl];
    
    return sub;
}
- (void)setNode:(UIButton *)node title:(NSString *)title Image:(NSString *)image{
    UIImageView *imageView = [node viewWithTag:11];
    imageView.image = [UIImage imageNamed:image];
    UILabel *titleLabel = [node viewWithTag:12];
    titleLabel.text = title;
}
/**
 获取上一个node的布局

 @return point
 */
- (CGPoint)beforeItemPointForIndex:(NSInteger)index{
    if (index == 0) {
        return CGPointMake(0, 0);
    }
    NSInteger row = index%4;
    NSInteger section = index/4;
    float x = row*Item_width;
    float y = section*Item_width;
    
    return CGPointMake(x, y);
}

/**
 从缓存获取

 @return node
 */
- (UIButton *)subInCache{
    UIButton *sub = [_subSet anyObject];
    if (sub) {
        [_subSet removeObject:sub];
    }
    return sub;
}



/**
 创建一个新的node

 @return node
 */
- (UIButton *)createNewNote{
    UIButton *button = [[  UIButton alloc] init];
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = CGRectMake(Item_width/3, Item_width/4, Item_width/3, Item_width/3+5);
    image.tag = 11;
    [button addSubview:image];
    UILabel *title = [[UILabel alloc] init];
    title.tag = 12;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor grayColor];
    title.frame = CGRectMake(0, Item_width/3+Item_width/4+6, Item_width, 20);
    [button addSubview:title];

    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 添加视图

 @param node node
 @param index index
 */
- (void)addSubButton:(  UIButton *)node index:(NSInteger)index{
    [self addHashWithSub:node Index:index];
    [self addSubview:node];
}


/**
 从索引获取子视图

 @param index index
 @return sub
 */
- (UIButton *)subNode:(NSInteger)index{
    if (_keys.allKeys.count == 0) {
        return nil;
    }
      UIButton *node = [_keys objectForKey:[self subKey:index]];
    if (![node isKindOfClass:[UIButton class]]) {
        return nil;
    }
    return node;
}
/**
 把子视图添加到索引表
 @param sub sub
 @param index index
 
 */
- (void)addHashWithSub:(UIButton *)sub Index:(NSInteger)index{
    
    [_keys setObject:sub forKey:[self subKey:index]];
    
}

/**
 通过index 生成索引key

 @param index index
 @return key
 */
- (NSString *)subKey:(NSInteger)index{
    return [NSString stringWithFormat:@"%@%@",Index_Key,@(index)];
}
- (void)click:(  UIButton *)button{
    if (_block) {
        NSInteger index = button.tag;
        if (index >= _items.count) {
            return;
        }
        ZFBFuncGrouItemModel *model = _items[index];
//        NSString *tilte =
        _block(index,model.title);
    }
    
}
@end
@implementation ZFBFuncGrouItemModel
+ (float)tableHeightForItemCount:(NSInteger)count{
    int x = count%4?1:0;
    return 40*(count/4+x);
}
@end
