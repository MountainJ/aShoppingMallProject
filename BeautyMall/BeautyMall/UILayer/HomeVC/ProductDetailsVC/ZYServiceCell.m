//
//  ZYServiceCell.m
//  BeautyMall
//
//  Created by JayZY on 15/10/12.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYServiceCell.h"
#import "PicTextTool.h"

#define kImageViewS 4

#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))


@implementation ZYServiceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpServiceView];
    }
    return self;
    
}

- (void)setUpServiceView
{
    for (int i=0; i<kImageViewS; i++)
    {
        UIButton *iconButton =[UIButton buttonWithType:UIButtonTypeCustom];
        iconButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        iconButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        //button的坐标位置,适配
//        CGFloat margin = 4;
        CGSize buttonSize =CGSizeMake(AppScreenWidth/kImageViewS, self.bounds.size.height);
        iconButton.frame = CGRectMake(i*(buttonSize.width), 5, buttonSize.width, buttonSize.height);
        iconButton.tag = 16524+i;
        [iconButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        iconButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:iconButton];

    }
    
    
}

- (void)setCellButtonPicText:(NSArray *)urlPicArr textString:(NSArray *)textArray
{
    //URL图片
    for (int i=0; i<urlPicArr.count; i++) {
        NSURL *imgURL  =[NSURL URLWithString:urlPicArr[i]];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imgURL options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            //
            if (!error) {
                //图片的大小进行显示
                CGSize imgSize = CGSizeMake(image.size.width/2, image.size.height/2);
                UIImage *newImg = [self scaleImage:image withSize:imgSize];
                UIButton *iconButton =(UIButton *)[self.contentView viewWithTag:16524+i];
                [iconButton setImage:newImg forState:UIControlStateNormal];
                [iconButton setTitle:textArray[i] forState:UIControlStateNormal];
                
                [iconButton addTarget:self action:@selector(buttonClickHere:) forControlEvents:UIControlEventTouchUpInside];
                iconButton.imageEdgeInsets = UIEdgeInsetsMake(0, iconButton.currentImage.size.width/2, 0, -iconButton.currentImage.size.width/2);
                
                iconButton.titleEdgeInsets = UIEdgeInsetsMake(iconButton.currentImage.size.height, -[self labelWidthWithStr:iconButton.titleLabel.text font:iconButton.titleLabel.font Height:30]/2,-iconButton.currentImage.size.height,0 );
                iconButton.frame = CGRectMake(iconButton.frame.origin.x, iconButton.frame.origin.y, CGRectGetWidth(iconButton.imageView.frame)+CGRectGetWidth(iconButton.titleLabel.frame),CGRectGetHeight(iconButton.imageView.frame)+CGRectGetHeight(iconButton.titleLabel.frame));
                iconButton.enabled = NO;
                
            }
            
        }];
    }
   


}


- (UIImage*)scaleImage:(UIImage *)image withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    UIImage *originImage =image;
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CGFloat)labelWidthWithStr:(NSString *)commentStr font:(UIFont *)font Height :(CGFloat)height
{
    CGSize retSize;
    if (IS_IOS_7)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        retSize = [commentStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                           options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    }
    else
    {
        retSize = [commentStr sizeWithFont:font
                         constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                             lineBreakMode:NSLineBreakByWordWrapping];
    }
    return retSize.width;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
