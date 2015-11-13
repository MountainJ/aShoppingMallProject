//
//  ZYheadReusableView.h
//  BeautyMall
//
//  Created by JayZY on 15/9/17.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZJLoopScrollView.h"

//@class ZYheadReusableView;
//@class ZYTopLikeView;
//
//@protocol ZYheadReusableViewDelegate <NSObject>
//
//- (void)ZYheadReusableView :(ZYheadReusableView *)ZYheadReusableView ZYTopLikeViewClicked:(ZYTopLikeView *)ZYTopLikeView;
//
//
//@end

@interface ZYheadReusableView : UICollectionReusableView


@property (nonatomic,assign) CGFloat  totalHeight;

//@property (nonatomic,assign) id<ZYheadReusableViewDelegate>delegate;

-(void)setFrameAdArray:(NSArray *)adArray topArray:(NSArray *)topArray;

@property (nonatomic,strong)  ZJLoopScrollView *loopScrollView;//广告滚动

@property (nonatomic,strong) UILabel *topLabel;//本周人气top




@end
