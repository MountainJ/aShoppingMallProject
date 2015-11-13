//
//  ZYShareCell.m
//  BeautyMall
//
//  Created by JayZY on 15/10/10.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYShareCell.h"
#import "ZYShareTopImgView.h"

#import "ZYLikeShareView.h"

@interface ZYShareCell ()<ZYLikeShareViewDelegate>

@property (nonatomic,strong) ZYShareTopImgView *shareTopView;
@property (nonatomic,strong) ZYLikeShareView *likeShareView;

@end


@implementation ZYShareCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        
    }
    return self;
    
}

 -(void)creatUI
{
   //创建两个视图
    self.shareTopView = [[ZYShareTopImgView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, self.bounds.size.height)];
    [self.contentView addSubview:self.shareTopView];
    //
    self.likeShareView =[[ZYLikeShareView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareTopView.frame), AppScreenWidth, self.bounds.size.height)];
    self.likeShareView.delegate = self;
    [self.contentView addSubview:self.likeShareView];
    
}

- (void)clickedButton:(UIButton *)button
{
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(shareButtonClickedToShare:)]) {
        [self.delegate  shareButtonClickedToShare:button];
    }
}

- (void)setTopShareViewHidden:(BOOL)hideTopView
{
    _topViewHidden = hideTopView;
    if (_topViewHidden) {//不隐藏顶部的分享
        self.shareTopView.hidden = YES;
        self.likeShareView.frame =CGRectMake(0, 0, AppScreenWidth, self.bounds.size.height);
    }

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
