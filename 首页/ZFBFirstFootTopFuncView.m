//
//  ZFBFirstFootTopFuncView.m
//  AliPay
//
//  Created by qyb on 2017/5/2.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ZFBFirstFootTopFuncView.h"
#import "ZFBFuncGroupView.h"
@implementation ZFBFirstFootTopFuncView
{
    NSMutableArray *_datas;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame datas:(NSMutableArray *)datas{
    if (self = [super initWithFrame:frame]) {
        _datas = datas;
        self.backgroundColor = kColor_Blue;
        [self setup];
    }
    return self;
}
- (void)setup{
    float width = self.frame.size.width/4;
    for (int i = 0; i < _datas.count; i ++) {
        ZFBFuncGrouItemModel *model = _datas[i];
        [self addSubview:[self itemButtonWithFrame:CGRectMake(i*width, 0, width, width) image:model.imageUrl title:model.title]];
    }
}

/**
 按需求新建button

 @param frame frame
 @param imageUrl imageurl
 @param title title
 @return button
 */
- (UIButton *)itemButtonWithFrame:(CGRect)frame image:(NSString *)imageUrl title:(NSString *)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    UIImageView *image = [[UIImageView alloc] init];
    float width = frame.size.width;
    image.image = [UIImage imageNamed:imageUrl];
    image.frame = CGRectMake(width/7*2, width/5, width/7*3, width/7*3);
    image.tag = 11;
    [btn addSubview:image];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.tag = 12;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, width/5+width/7*3+4, width, 20);
    [btn addSubview:titleLabel];
    
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)click:(UIButton *)btn{
    
}
@end
