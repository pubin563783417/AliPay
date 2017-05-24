//
//  SBCollectionView.m
//  AliPay
//
//  Created by qyb on 2017/5/12.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SBCollectionView.h"
#import "SBColletionLayout.h"
#import "StaticCacheManager.h"

static NSInteger const __tagbase = 1000;
static NSString *const __cachekey = @"__sb_collection_cache_key";
@interface SBCollectionView()
@property (strong,nonatomic) NSMutableArray *dataSource;
@end
@implementation SBCollectionView
{
    StaticCacheManager *_cacheManager;
    
    SBColletionLayout *_privateLayout;
    NSInteger _rowCount;
    CGFloat _privateHorizontalSpace;
    NSInteger _beforeCount;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static float screen_width(){
    return screen_width_ratio(1.0f);
}
static float screen_width_ratio(float ratio){
    float screenwidth = [UIScreen mainScreen].bounds.size.width;
    return screenwidth*ratio;
}
- (instancetype)init{
    if (self = [super init]) {
        _allowCache = YES;
        _verticalSpace = 0;
        _minHorizontalSpace = 0;
        _cacheManager = [StaticCacheManager shareManager];
        _dataSource = [NSMutableArray new];
        _itemCount = 0;
        _beforeCount = 0;
    }
    return self;
}
- (void)reloadData{
    NSInteger index = 0;
    _rowCount = [self countOfRow];
    while (index < self.itemCount) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self reloadItem:[self itemWithIndexPath:indexPath] atIndexPath:indexPath];
        index ++;
    }
    
    for (int i = index; i<_beforeCount; i ++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UIView *item = [self itemWithIndexPath:indexPath];
        [item removeFromSuperview];
    }
    _beforeCount = self.itemCount;
}
- (void)reloadItem:(UIView *)item atIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(collectionView:drawedObject:indexPath:)]) {
        item = [self.delegate collectionView:self drawedObject:item indexPath:indexPath];
    }else if (self.reloadItem){
        item = _reloadItem(self,item,indexPath);
    }
    
    if ([self.delegate respondsToSelector:@selector(layoutsForCollectionView:layout:indexPath:)]) {
        [self drawItem:item layout:[self.delegate layoutsForCollectionView:self layout:[self layout] indexPath:indexPath]];
    }else{
        [self drawItem:item layout:[self nomalLayoutWithIndex:indexPath]];
    }
    NSLog(@"item rect: %@",NSStringFromCGRect(item.frame));
}

- (SBColletionLayout *)nomalLayoutWithIndex:(NSIndexPath*)indexPath{
    SBColletionLayout *layout = [self layout];
    layout.frame = [self calculateframeAtIndexPath:indexPath];
    return layout;
}
- (SBColletionLayout *)layout{
    if (!_privateLayout) {
        _privateLayout = [[SBColletionLayout alloc] init];
    }
    [_privateLayout clear];
    return _privateLayout;
}
- (NSInteger)itemCount{
    if ([self.delegate respondsToSelector:@selector(itemsCountForCollectionView:)]) {
        _itemCount = [self.delegate itemsCountForCollectionView:self];
    }
    return _itemCount;
}
- (NSInteger)countOfRow{
    NSInteger count = 0;
    CGFloat width = screen_width()-self.contentInset.left-self.contentInset.right;
    float pb_float = (width+self.minHorizontalSpace)/self.itemSize.width+1;
    count = floor(pb_float);
    NSAssert(count, @"contentInset or size value is wrong");
    if (count == 1) {
        _privateHorizontalSpace = 0;
        return count;
    }
    _privateHorizontalSpace = (width-count*self.itemSize.width)/(count-1);
    return count;
}
- (CGRect)calculateframeAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame;
    CGFloat x = self.contentInset.left+(indexPath.row%_rowCount)*(self.itemSize.width+_privateHorizontalSpace);
    CGFloat y = self.contentInset.top+(indexPath.row/_rowCount)*(self.itemSize.height+self.verticalSpace);
    frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
    return frame;
}
/**
 是否允许cache
 @param allowCache allowed
 */
- (void)setAllowCache:(BOOL)allowCache{
    if (!allowCache) {
        [_cacheManager removeSetForKey:@""];
    }else{
        [_cacheManager createNewSetForKey:@""];
    }
}
/**
 从代理方获取一个新的item

 @return new item
 */
- (UIView *)newItem:(NSIndexPath *)indexPath{
    UIView *item = nil;
    if ([self.delegate respondsToSelector:@selector(collectionView:itemInitAtIndexPath:)]) {
        item = [self.delegate collectionView:self itemInitAtIndexPath:indexPath];
    }else if(self.item){
        item = _item(self,indexPath);
    }
    NSAssert(item, @"item initialize invalid");
    return item;
}

- (UIView *)itemWithIndexPath:(NSIndexPath *)indexPath{
    UIView *item = [self viewWithTag:[self tagWithIndexPath:indexPath]];
    if (item) {
        return item;
    }
    
    item = [_cacheManager anyObjectForKey:__cachekey];
    if (!item) {
        item = [self newItem:indexPath];
    }
    [self addSubview:item];
    return item;
}

- (NSInteger)tagWithIndexPath:(NSIndexPath*)indexPath{
    return indexPath.row+__tagbase;
}
- (void)drawItem:(UIView *)item layout:(SBColletionLayout *)layout{
    item.frame = layout.frame;
    item.bounds = layout.bounds;
    item.tag = [self tagWithIndexPath:layout.indexPath];
    item.alpha = layout.alpha;
    item.hidden = layout.hidden;
    item.opaque = layout.opaque;
}


- (void)addSubview:(UIView *)view{
    [super addSubview:view];
}
- (void)willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    [_cacheManager addObject:subview forKey:__cachekey];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
@end
