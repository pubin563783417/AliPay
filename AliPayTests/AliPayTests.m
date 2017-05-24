//
//  AliPayTests.m
//  AliPayTests
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZFBFuncGroupView.h"
@interface AliPayTests : XCTestCase
{
    int _index;
}
@property (strong,nonatomic) ZFBFuncGroupView *view;
@property (strong,nonatomic) NSMutableSet *set;
@property (strong,nonatomic) NSMutableArray *items;
@property (strong,nonatomic) NSMutableDictionary *keys;
@end

@implementation AliPayTests

- (void)setUp {
    [super setUp];
    _index = 6;
    _view = [[ZFBFuncGroupView alloc]init];
    _set = [_view valueForKey:@"subSet"];
    _items = [_view valueForKey:@"items"];
    _keys = [_view valueForKey:@"keys"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (NSMutableArray *)items{
    return [_view valueForKey:@"items"];
    
}
- (void)beginFuncGroup1{
    _index = 6;
    
    [_view reload:[self funcModels]];
    
    XCTAssert(_set.count == 0,@"缓存出错");
    XCTAssert(self.items.count == _index,@"数据源出错");
    XCTAssert(_keys.count == _index,@"索引出错");
}

- (void)beginFuncGroup2{
    _index = 3;
    
    [_view reload:[self funcModels]];
     XCTAssert(_set.count == 3,@"缓存出错");
    XCTAssert(self.items.count == _index,@"数据源出错");
    XCTAssert(_keys.count == _index,@"索引出错");
}
- (void)beginFuncGroup3{
    _index = 8;
    
    [_view reload:[self funcModels]];
    XCTAssert(_set.count == 0,@"缓存出错");
    XCTAssert(self.items.count == _index,@"数据源出错");
    XCTAssert(_keys.count == _index,@"索引出错");
}
- (void)beginFuncGroup4{
    _index = 4;
    
    [_view reload:[self funcModels]];
    XCTAssert(_set.count == 4,@"缓存出错");
    XCTAssert(self.items.count == _index,@"数据源出错");
    XCTAssert(_keys.count == _index,@"索引出错");
}
- (NSMutableArray <ZFBFuncGrouItemModel *> *)funcModels{
    NSArray *titles = @[@"红包",@"转账",@"充值",@"机票",@"淘票票",@"滴滴出行",@"我的快递",@"全部"];
    NSArray *imageNames = @[@"function_red",@"function_zhuanzhang",@"function_chongzhi",@"function_jipiao",@"function_taopiao",@"function_chuxing",@"function_kuaidi",@"function_all"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        ZFBFuncGrouItemModel *model = [[ZFBFuncGrouItemModel alloc]init];
        model.imageUrl = [NSString stringWithFormat:@"OpenPlatform.bundle/%@",imageNames[i]];
        model.title = titles[i];
        [array addObject:model];
    }
    return  array;
}

- (void)testExample {
    [self beginFuncGroup1];
    [self beginFuncGroup2];
    [self beginFuncGroup3];
    [self beginFuncGroup4];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
