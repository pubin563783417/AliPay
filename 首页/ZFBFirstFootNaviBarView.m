//
//  ZFBFirstFootNaviBarView.m
//  AliPay
//
//  Created by qyb on 2017/4/28.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ZFBFirstFootNaviBarView.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
@interface ZFBFirstFootNaviBarView()
{
    BOOL _isFirst;
}
@property (strong,nonatomic) ASButtonNode *SeacherBar;
@property (strong,nonatomic) ASButtonNode *HeadBtn;
@property (strong,nonatomic) ASButtonNode *MoreBtn;
@property (strong,nonatomic) NSMutableArray *Nomals;

@property (strong,nonatomic) ASButtonNode *oneBtn;
@property (strong,nonatomic) ASButtonNode *twoBtn;
@property (strong,nonatomic) ASButtonNode *threeBtn;
@property (strong,nonatomic) ASButtonNode *fourBtn;
@end
@implementation ZFBFirstFootNaviBarView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kColor_Blue;
        __weak typeof(self) weak = self;
        _SeacherBar = [[ASButtonNode alloc] initWithViewBlock:^UIView * _Nonnull{
            UIView *content = [[UIView alloc]initWithFrame:weak.SeacherBar.bounds];
            UIImageView *seacher = [[UIImageView alloc]initWithFrame:CGRectMake(8, 5, 20, 20)];
            seacher.image = [UIImage imageNamed:@"home_search"];
            [content addSubview:seacher];
            UILabel *titleTabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(seacher.frame)+3, 5, 70, 20)];
            titleTabel.font = [UIFont systemFontOfSize:14];
            titleTabel.textColor = [UIColor whiteColor];
            titleTabel.text = @"共享单车";
            [content addSubview:titleTabel];
            return content;
        }];
        _SeacherBar.layer.cornerRadius = 3;
        _SeacherBar.layer.masksToBounds = YES;
        _SeacherBar.backgroundColor = [UIColor colorWithRed:23/255.f green:92/255.f blue:171/255.f alpha:0.6];
//        _SeacherBar.alpha = 0.3;
        _SeacherBar.frame = CGRectMake(15, 32, Screen_Width/10*7, 30);
        [self addSubnode:_SeacherBar];
        
        _HeadBtn = [[ASButtonNode alloc]init];
        [_HeadBtn setImage:[UIImage imageNamed:@"nav_person"] forState:ASControlStateNormal];
        _HeadBtn.frame = CGRectMake(Screen_Width-80, 32, 30, 30);
        [self addSubnode:_HeadBtn];
        
        _MoreBtn = [[ASButtonNode alloc] init];
        _MoreBtn.frame = CGRectMake(Screen_Width-40, 32, 30, 30);
        [_MoreBtn setImage:[UIImage imageNamed:@"ap_more"] forState:ASControlStateNormal];
        [self addSubnode:_MoreBtn];
        
        [self addSubnode:self.oneBtn];
        [self addSubnode:self.twoBtn];
        [self addSubnode:self.threeBtn];
        [self addSubnode:self.fourBtn];
        
    }
    return self;
}
- (ASButtonNode *)oneBtn{
    if (_oneBtn == nil) {
        _oneBtn = [[ASButtonNode alloc]init];
        _oneBtn.frame = CGRectMake(15, 32, 20, 20);
        _oneBtn.alpha = 0;
        [_oneBtn setImage:[UIImage imageNamed:@"ap_scan"] forState:ASControlStateNormal];
    }
    return _oneBtn;
}
- (ASButtonNode *)twoBtn{
    if (_twoBtn == nil) {
        _twoBtn = [[ASButtonNode alloc]init];
        _twoBtn.frame = CGRectMake(50, 32, 20, 20);
        _twoBtn.alpha = 0;
        [_twoBtn setImage:[UIImage imageNamed:@"ap_scan"] forState:ASControlStateNormal];
    }
    return _twoBtn;
}
- (ASButtonNode *)threeBtn{
    if (_threeBtn == nil) {
        _threeBtn = [[ASButtonNode alloc]init];
        _threeBtn.frame = CGRectMake(85, 32, 20, 20);
        _threeBtn.alpha = 0;
        [_threeBtn setImage:[UIImage imageNamed:@"ap_scan"] forState:ASControlStateNormal];
    }
    return _threeBtn;
}
- (ASButtonNode *)fourBtn{
    if (_fourBtn == nil) {
        _fourBtn = [[ASButtonNode alloc]init];
        _fourBtn.frame = _MoreBtn.frame;
        _fourBtn.alpha = 0;
        [_fourBtn setImage:[UIImage imageNamed:@"ap_scan"] forState:ASControlStateNormal];
    }
    return _fourBtn;
}

- (void)aboutBarAlpta:(float)alpha{
    
    float otherAlpha = 1-alpha;
    _SeacherBar.alpha = alpha;
    _HeadBtn.alpha = alpha;
    _MoreBtn.alpha = alpha;
    _oneBtn.alpha = otherAlpha;
    _twoBtn.alpha = otherAlpha;
    _threeBtn.alpha = otherAlpha;
    _threeBtn.alpha = otherAlpha;
}

@end
