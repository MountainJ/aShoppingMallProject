//
//  ProductCollectionViewCell.m
//  BeautyMallProject
//
//  Created by jayzhang on 15-5-4.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ProductCollectionViewCell.h"

#import "UIView+jayzyQuickControl.h"

#define ProductImgHeight 150

#define PriceLabelHeight 30

@implementation ProductCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        //
        [self creatUI];
        
    }

    return self;

}

-(void)creatUI
{
    self.layer.cornerRadius =2.0f;
    self.layer.borderWidth=0.4;
    self.layer.borderColor =[UIColor lightGrayColor].CGColor;
    self.clipsToBounds =YES;
//产品图片

    _backImgView = [[UIImageView alloc] init];
    _backImgView.image = [UIImage imageNamed:@"yuike_item_bg_alphax_5p_sp"];
    [self.contentView addSubview:_backImgView];
    

//原价

    //原价
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor =[UIColor redColor];
    _priceLabel.font =[UIFont systemFontOfSize:13];
    [self.contentView addSubview:_priceLabel];
    //    _priceLabel.backgroundColor = [UIColor yellowColor];

    
    
    //喜欢数
    _likeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_likeLabel];
    _likeLabel.font =[UIFont systemFontOfSize:13];
    _likeLabel.textColor =[UIColor lightGrayColor];
    //喜欢的图标
    _likeImgView  =[[ UIImageView alloc] init];
    _likeImgView.image = [UIImage imageNamed:@"like_count.png"];
    [self.contentView addSubview:_likeImgView];
    
}


- (void)setCellFrame:(ZYProductPicFrame *)model
{
   
    _backImgView.frame =model.backIMGViewFrame;
    _priceLabel.frame =model.priceLabelFrame;
    _likeImgView.frame = model.likeIMGViewFrame;
    _likeLabel.frame = model.likeLabelFrame;
    
    [_backImgView sd_setImageWithURL:[NSURL URLWithString:model.picModel.taobao_pic_url]];
    _priceLabel.text =[NSString stringWithFormat:@"￥%.2f",[model.picModel.taobao_selling_price floatValue]];
    _likeLabel.text = model.picModel.likes_count?model.picModel.likes_count:@"0";
    
}






@end
