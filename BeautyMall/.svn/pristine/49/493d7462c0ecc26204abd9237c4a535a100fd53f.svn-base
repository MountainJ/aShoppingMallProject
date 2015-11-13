//
//  ZYBrandStoreCell.m
//  BeautyMall
//
//  Created by JayZY on 15/10/13.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYBrandStoreCell.h"

#import "UIView+jayzyQuickControl.h"

@implementation ZYBrandStoreCell

- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        [self setUpUI];
        
    }
    return self;


}

- (void)setUpUI
{
    UIImage *logoImg =[UIImage imageNamed:@"product_detail_brand_logo"];
   UIImageView *logoStoreView =[self.contentView addImageViewWithFrame:CGRectMake(15, 15, logoImg.size.width, logoImg.size.height) image:@"product_detail_brand_logo"];
    _storeLabel = [self.contentView addLabelWithFrame:CGRectMake(CGRectGetMaxX(logoStoreView.frame)+10, CGRectGetMinY(logoStoreView.frame)-10, 200, 30) text:nil];
    _storeLabel.font = [UIFont systemFontOfSize:12.0f];
    _storeLabel.textColor = [UIColor redColor];
    
    UIImageView *moreView = [self.contentView addImageViewWithFrame:CGRectMake(AppScreenWidth-30, CGRectGetMinY(logoStoreView.frame), 10, 10) image:@"yuike_pdetail_arrow"];
    UILabel *moreLabel =[self.contentView addLabelWithFrame:CGRectMake(CGRectGetMinX(moreView.frame)-80, CGRectGetMinY(_storeLabel.frame), 80, 30) text:@"更多热销宝贝"];
    moreLabel.font = [UIFont systemFontOfSize:12.0f];
    
}

-(void)setStoreName:(NSString *)nameStr
{
    _storeLabel.text = nameStr;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
