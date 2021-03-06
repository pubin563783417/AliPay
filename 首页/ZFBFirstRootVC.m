//
//  ZFBFirstRootVC.m
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ZFBFirstRootVC.h"
#import "ZFBFuncGroupView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ZFBFirstFootTopFuncView.h"
#import "ZFBFirstFootNaviBarView.h"
#import "SBCollectionView.h"
@interface ZFBFirstRootVC ()<UIScrollViewDelegate,SBCollectionProtocol>
@property (strong,nonatomic) ZFBFirstFootNaviBarView *naviBar;
@property (strong,nonatomic) UIScrollView *mainScrollView;
@property (strong,nonatomic) ZFBFuncGroupView *functionGroupView;
@property (strong,nonatomic) ZFBFirstFootTopFuncView *topFuncView;
@property (strong,nonatomic) SBCollectionView *collection;
@property (assign,nonatomic) NSInteger sbcount;
@end

@implementation ZFBFirstRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _naviBar = [[ZFBFirstFootNaviBarView alloc] init];
    _naviBar.frame = CGRectMake(0, 0, Screen_Width, 64);
    [self.view addSubnode:_naviBar];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.functionGroupView];
    [self.mainScrollView addSubview:self.topFuncView];
    
    _collection = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 250, Screen_Width, 200) itemCount:10 itemSize:CGSizeMake(100, 50) item:^UIView *(SBCollectionView *cv, NSIndexPath *indexPath) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize:15];
        //    label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        return label;
    } reloadItem:^UIView *(SBCollectionView *cv, UIView *item, NSIndexPath *indexPath) {
        int i = indexPath.row%3;
        UILabel *label = item;
        switch (i) {
            case 0:
                label.text = @"hello";
                break;
            case 1:
                label.text = @"world";
                break;
            case 2:
                label.text = @"!";
                break;
            default:
                break;
        }
        return label;
    } didSelectItem:^(SBCollectionView *cv, NSIndexPath *indexPath) {
        NSLog(@"%@",indexPath);
    }];
    _collection.contentInset = UIEdgeInsetsMake(0, 50, 0, 50);
//    _collection.allowClick = NO;
//    _collection.selectHighLight = NO;
    _collection.minHorizontalSpace = 5;
    _collection.verticalSpace = 5;
    [self.mainScrollView addSubview:_collection];
    [_collection reloadData];
}

- (UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.frame = CGRectMake(0, 64, Screen_Width, Screen_Height-64-49);
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
        _mainScrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height-64-49);
    }
    return _mainScrollView;
}
- (ZFBFirstFootTopFuncView *)topFuncView{
    if (_topFuncView == nil) {
        _topFuncView = [[ZFBFirstFootTopFuncView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 100) datas:[self topFuncModels]];
    }
    return _topFuncView;
}
- (ZFBFuncGroupView *)functionGroupView{
    
    if (_functionGroupView == nil) {
        __weak typeof(self) weak = self;
        _functionGroupView = [[ZFBFuncGroupView alloc]initWithFrame:CGRectMake(0, 100, Screen_Width, [ZFBFuncGrouItemModel tableHeightForItemCount:[self funcModels].count]) Items:[self funcModels] tapBlock:^(NSInteger index, NSString *title) {
            if (index == 0) {
                [weak.collection deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0]] animated:YES completion:nil];
//                [weak.collection deleteItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:YES completion:nil];
            }else{
                [weak.collection insertItemsOfCount:3 AtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:YES completion:nil];
//                [weak.collection reloadData];
            }
            
            
        }];
    }
    return _functionGroupView;
}

- (NSMutableArray <ZFBFuncGrouItemModel *> *)topFuncModels{
    NSArray *titles = @[@"扫一扫",@"付款",@"收款",@"卡券"];
    NSArray *imageNames = @[@"home_scan",@"home_pay",@"home_shoukuan",@"home_card"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        ZFBFuncGrouItemModel *model = [[ZFBFuncGrouItemModel alloc]init];
        model.imageUrl = [NSString stringWithFormat:@"%@",imageNames[i]];
        model.title = titles[i];
        [array addObject:model];
    }
    return  array;
}
- (NSMutableArray <ZFBFuncGrouItemModel *> *)funcModels{
    NSArray *titles = @[@"红包",@"转账",@"充值",@"机票",@"淘票票",@"滴滴出行",@"我的快递",@"全部"];
    NSArray *imageNames = @[@"function_red",@"function_zhuanzhang",@"function_chongzhi",@"function_jipiao",@"function_taopiao",@"function_chuxing",@"function_kuaidi",@"function_all"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        ZFBFuncGrouItemModel *model = [[ZFBFuncGrouItemModel alloc]init];
        model.imageUrl = [NSString stringWithFormat:@"%@",imageNames[i]];
        model.title = titles[i];
        [array addObject:model];
    }
    return  array;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
