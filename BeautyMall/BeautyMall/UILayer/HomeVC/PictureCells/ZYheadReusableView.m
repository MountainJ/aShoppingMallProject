//
//  ZYheadReusableView.m
//  BeautyMall
//
//  Created by JayZY on 15/9/17.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYheadReusableView.h"

//#import "ZJLoopScrollView.h"

#import "ZYAdvertiseModel.h"

#import "PicTextTool.h"

#import "ZYTopLikeView.h"

#define  TopWidth  70 //人气推荐按钮宽度

#define  TopHeight 50 //人气推荐按钮高度

#define  Margin  ((AppScreenWidth -TopWidth*4)/5.0) //间隔

@interface ZYheadReusableView ()<PicTextToolDelegate>
{

    NSArray *_adsDataArray;//广告轮播
    NSArray *_topDataArray;//人气推荐
    UIView *_backView;//签到,抽奖,热门背景;
    UIView *_topLikeView;//人气推荐
}

@end

@implementation ZYheadReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if (self) {
        self.userInteractionEnabled =YES;
        //添加一个表头,需要进行数据下载
        [self creatHeaderAdView];
    }
    return self;
    
}


- (void)creatHeaderAdView
{
    //创建循环滚动视图
    ZJLoopScrollView *loopScrollView = [[ZJLoopScrollView alloc] init];
    loopScrollView.frame = CGRectMake(0, 0, AppScreenWidth, 180);
    //设置属性
//    loopScrollView.pageCount =_adsDataArray.count;
    loopScrollView.autoScroll = YES;
    loopScrollView.showPageControl = YES;
    [loopScrollView setClickAction:^(UIImageView *imageView, int index) {
        NSLog(@"index = %d",index);
    }];
    
    _loopScrollView =loopScrollView;
    [self addSubview:_loopScrollView];
    //创建签到,抽奖,热门等视图
    [self setupButtonView];
    //创建本周人气等视图;
    [self setupThisWeekTopView];
    
}

//创建签到,抽奖,热门按钮
- (void)setupButtonView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_loopScrollView.frame), AppScreenWidth, 50)];
        [self addSubview:_backView];
    }
    NSArray *pictureArr = @[@"image_homepage_sign",@"image_homepage_shake",@"image_homepage_hotlist"];
    NSArray *textArr = @[@"扫一扫",@"抽奖",@"热门"];
    [PicTextTool creatLeftPictureRightTextPicture:pictureArr textArray:textArr textFont:14 addToView:_backView buttonSize:CGSizeMake(100, 40) imgIconSize:CGSizeMake(35, 35) toTarget:self buttonFirstTag:1234];
    [self addSubview:_backView];
}

- (void)setupThisWeekTopView
{
    if (!_topLikeView) {
        _topLikeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_backView.frame), AppScreenWidth, 100)];
        _topLikeView.userInteractionEnabled = YES;
        UIImage *backImg =[[UIImage imageNamed:@"yuike_item_bg_alphax_5p_sp"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
        _topLikeView.backgroundColor = [UIColor colorWithPatternImage:backImg];
//        _topLikeView.backgroundColor = [UIColor blueColor];
        [self addSubview:_topLikeView];
    }
    //本周人气推荐
    _topLabel= [[UILabel alloc] initWithFrame:CGRectMake(Margin, 0, AppScreenWidth-Margin, 30)];
    _topLabel.backgroundColor = [UIColor clearColor];
    [_topLikeView addSubview:_topLabel];
    //添加推荐Label+八个imageView;
    CGRect rect;
    for (int i=0; i<8; i++) {
    ZYTopLikeView *topImageView = [[ZYTopLikeView alloc] initWithFrame:CGRectMake(Margin+(i%4)*(TopWidth+Margin),CGRectGetMaxY(_topLabel.frame)+(i/4)*(TopHeight+Margin), TopWidth, TopHeight)];
//        topImageView.backgroundColor = [UIColor purpleColor];
        topImageView.tag = 6666+i;
        [_topLikeView addSubview:topImageView];
        if (i==8-1) {
            rect = topImageView.frame;
        }
    }
    _topLikeView.frame = CGRectMake(_topLikeView.frame.origin.x, _topLikeView.frame.origin.y, _topLikeView.frame.size.width, CGRectGetMaxY(rect)+20);
    
    self.frame  = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_topLikeView.frame));
    self.totalHeight = CGRectGetMaxY(_topLikeView.frame);
}

- (void)setFrameAdArray:(NSArray *)adArray topArray:(NSArray *)topArray
{
    _adsDataArray = [NSArray arrayWithArray:adArray];
    _topDataArray = [NSArray arrayWithArray:topArray];
    _loopScrollView.pageCount =_adsDataArray.count;
    //设置网络图片
    //注意: 添加网络图片之前, 需要先设置显示的页数
    for (int i=0; i<_adsDataArray.count; i++) {
        ZYAdvertiseModel *model = _adsDataArray[i];
        [_loopScrollView setImageWithUrlString:model.pic_url atIndex:i];
    }
    ZYAdvertiseModel *model =[_topDataArray firstObject];
    _topLabel.text = model.title;
    for (int i=0; i<_topDataArray.count; i++)
    {
        ZYAdvertiseModel *model =_topDataArray[i];
        ZYTopLikeView *topImageView =(ZYTopLikeView *)[self viewWithTag:6666+i];
        [topImageView setImageViewImage:model.background_pic_url upLabelText:model.taobao_title downLabelText:model.en_taobao_title];
    }
}

- (void)buttonClickHere:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"signShake" object:btn];
}

@end
