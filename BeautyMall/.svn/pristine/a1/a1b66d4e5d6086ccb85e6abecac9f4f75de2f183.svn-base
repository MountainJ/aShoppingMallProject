//
//  ZYPicDetailCell.m
//  BeautyMall
//
//  Created by JayZY on 15/10/14.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYPicDetailCell.h"
#import "ZYProudutDetailModel.h"
@interface ZYPicDetailCell ()
/**
 *  产品图片
 */
@property (nonatomic,strong)UIImageView *picImgView;


@end


@implementation ZYPicDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.picImgView =[[UIImageView alloc] init];
        [self.contentView addSubview:self.picImgView];
        
    }
    return self;
    
}
- (void)setPicture:(ZYProudutDetailModel *)model
{
    CGFloat height =model.picSize.height*(AppScreenWidth/model.picSize.width);
    self.picImgView.frame = CGRectMake(0, 0, AppScreenWidth, height);
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:model.contentURL]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
