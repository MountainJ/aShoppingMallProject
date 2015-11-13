//
//  ZYShareTopImgView.m
//  BeautyMall
//
//  Created by JayZY on 15/10/10.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYShareTopImgView.h"

@implementation ZYShareTopImgView


 -(instancetype )initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.image = [UIImage imageNamed:@"image_share_gift_background"];
        UIImage *giftImg =[UIImage imageNamed:@"image_share_gift"];
        UIImageView *giftView =[[UIImageView alloc] initWithFrame:CGRectMake(10, (self.bounds.size.height-giftImg.size.height)/2, giftImg.size.width, giftImg.size.height)];
        giftView.image = giftImg;
        [self addSubview:giftView];
        //
        UILabel *shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(giftView.frame)+10, CGRectGetMidY(giftView.frame)-15, AppScreenWidth-CGRectGetMaxX(giftView.frame)+10, 30)];
        shareLabel.font = [UIFont systemFontOfSize:13.0f];
        shareLabel.text =@"亲,分享既可享受VIP最低价格哦!";
        shareLabel.textColor = [UIColor darkTextColor];
        
        shareLabel.backgroundColor = [UIColor clearColor];
//        [shareLabel sizeToFit];
        [self addSubview:shareLabel];
        //
        UIImage *shareImg =[UIImage imageNamed:@"image_share_gift_top"];
        UIImageView *shareView =[[UIImageView alloc] initWithFrame:CGRectMake(AppScreenWidth/2-shareImg.size.width, self.bounds.size.height, shareImg.size.width, shareImg.size.height)];
        shareView.image = shareImg;
        [self addSubview:shareView];
    }
    return self;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
