//
//  PicTextButton.m
//  TestPictureText
//
//  Created by JayZY on 15/9/7.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "PicTextTool.h"



#define IS_IOS_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define ButtonWidthNow (CGRectGetWidth(iconButton.imageView.frame)+CGRectGetWidth(iconButton.titleLabel.frame))

@implementation PicTextTool
//上图下文
+ (void)creatPictureTextClickButton :(NSArray *)pictureArray textArray:(NSArray *)textArray textFont:(CGFloat)fontSize addToView :(UIView *)parentView buttonSize: (CGSize )buttonSize  imgIconSize :(CGSize )iconSize  toTarget:(id)target buttonFirstTag:(NSInteger)firstTag
{
    for (int i=0; i<[pictureArray count]; i++)
    {
        UIButton *iconButton =[UIButton buttonWithType:UIButtonTypeCustom];
        iconButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        iconButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        //button的坐标位置,适配
        CGFloat margin = (CGRectGetWidth(parentView.frame)-buttonSize.width*pictureArray.count)/(pictureArray.count+1);
        iconButton.frame = CGRectMake(margin+i*(buttonSize.width+margin), 5, buttonSize.width, buttonSize.height);
        //图片的大小进行显示
        UIImage *newImg = [PicTextTool scaleImage:[ UIImage imageNamed:pictureArray[i]] withSize:iconSize];
        [iconButton setImage:newImg forState:UIControlStateNormal];
        [iconButton setTitle:textArray[i] forState:UIControlStateNormal];
        [iconButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        iconButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];

        [iconButton addTarget:target action:@selector(buttonClickHere:) forControlEvents:UIControlEventTouchUpInside];
        iconButton.tag = firstTag+i;

        iconButton.imageEdgeInsets = UIEdgeInsetsMake(0, iconButton.currentImage.size.width/2, 0, -iconButton.currentImage.size.width/2);
        iconButton.titleEdgeInsets = UIEdgeInsetsMake(iconButton.currentImage.size.height, -[PicTextTool labelWidthWithStr:iconButton.titleLabel.text font:iconButton.titleLabel.font Height:30]/2,-iconButton.currentImage.size.height, [PicTextTool labelWidthWithStr:iconButton.titleLabel.text font:iconButton.titleLabel.font Height:30]/2 );
        [parentView addSubview:iconButton];
        iconButton.frame = CGRectMake(iconButton.frame.origin.x, iconButton.frame.origin.y, CGRectGetWidth(iconButton.imageView.frame)+CGRectGetWidth(iconButton.titleLabel.frame),CGRectGetHeight(iconButton.imageView.frame)+CGRectGetHeight(iconButton.titleLabel.frame));
    }
}
//左图右文
+(void)creatLeftPictureRightTextPicture:(NSArray *)pictureArray textArray:(NSArray *)textArray textFont:(CGFloat)fontSize addToView:(UIView *)parentView buttonSize:(CGSize)buttonSize imgIconSize:(CGSize)iconSize toTarget:(id)target buttonFirstTag:(NSInteger)firstTag
{
    for (int i=0; i<[pictureArray count]; i++)
    {
        UIButton *iconButton =[UIButton buttonWithType:UIButtonTypeCustom];
        //button的坐标位置,适配
     CGFloat margin = (CGRectGetWidth(parentView.frame)-buttonSize.width*pictureArray.count)/(pictureArray.count+1);
        iconButton.frame = CGRectMake(margin+i*(buttonSize.width+margin), 5, buttonSize.width, buttonSize.height);
        //图片的大小进行显示
        UIImage *newImg = [PicTextTool scaleImage:[ UIImage imageNamed:pictureArray[i]] withSize:iconSize];
        [iconButton setImage:newImg forState:UIControlStateNormal];
        [iconButton setTitle:textArray[i] forState:UIControlStateNormal];
        [iconButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        iconButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        
        [iconButton addTarget:target action:@selector(buttonClickHere:) forControlEvents:UIControlEventTouchUpInside];
        iconButton.tag = firstTag+i;
        [parentView addSubview:iconButton];
         CGFloat marginNow = ((CGRectGetWidth(parentView.frame)-ButtonWidthNow*pictureArray.count))/(pictureArray.count+1);
        iconButton.frame = CGRectMake(iconButton.frame.origin.x+(marginNow-margin)/2, iconButton.frame.origin.y,ButtonWidthNow,MAX(CGRectGetHeight(iconButton.imageView.frame), CGRectGetHeight(iconButton.titleLabel.frame)));
    }

}
//利用URL添加上图下文
+(void)creatPictureTextClickButtonWithURL:(NSArray *)pictureArrayURL textArray:(NSArray *)textArray textFont:(CGFloat)fontSize addToView:(UIView *)parentView buttonSize:(CGSize)buttonSize imgIconSize:(CGSize)iconSize toTarget:(id)target buttonFirstTag:(NSInteger)firstTag
{
   
    for (int i=0; i<[pictureArrayURL count]; i++)
    {
        UIButton *iconButton =[UIButton buttonWithType:UIButtonTypeCustom];
        iconButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        iconButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        //button的坐标位置,适配
        CGFloat margin = (CGRectGetWidth(parentView.frame)-buttonSize.width*pictureArrayURL.count)/(pictureArrayURL.count+1);
        iconButton.frame = CGRectMake(margin+i*(buttonSize.width+margin), 5, buttonSize.width, buttonSize.height);
        //URL图片
        NSURL *imgURL  =[NSURL URLWithString:pictureArrayURL[i]];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imgURL options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            //
            if (!error) {

                CGSize imgSize = CGSizeMake(iconSize.width, image.size.height*(iconSize.width/image.size.width));
                //图片的大小进行显示
                UIImage *newImg = [PicTextTool scaleImage:image withSize:imgSize];
                [iconButton setImage:newImg forState:UIControlStateNormal];
                [iconButton setTitle:textArray[i] forState:UIControlStateNormal];
                [iconButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                iconButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
                
                [iconButton addTarget:target action:@selector(buttonClickHere:) forControlEvents:UIControlEventTouchUpInside];
                iconButton.tag = firstTag+i;
//                iconButton.backgroundColor = [UIColor lightGrayColor];
                iconButton.imageEdgeInsets = UIEdgeInsetsMake(0, iconButton.currentImage.size.width/2, 0, -iconButton.currentImage.size.width/2);
                iconButton.titleEdgeInsets = UIEdgeInsetsMake(iconButton.currentImage.size.height, -[PicTextTool labelWidthWithStr:iconButton.titleLabel.text font:iconButton.titleLabel.font Height:30]/2,-iconButton.currentImage.size.height,0 );
                [parentView addSubview:iconButton];
//                iconButton.titleLabel.backgroundColor = [UIColor greenColor];
                iconButton.frame = CGRectMake(iconButton.frame.origin.x, iconButton.frame.origin.y, CGRectGetWidth(iconButton.imageView.frame)+CGRectGetWidth(iconButton.titleLabel.frame),CGRectGetHeight(iconButton.imageView.frame)+CGRectGetHeight(iconButton.titleLabel.frame));
                iconButton.enabled = NO;
            }

        }];
       
    }


}

+ (UIImage*)scaleImage:(UIImage *)image withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    UIImage *originImage =image;
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (CGFloat)labelWidthWithStr:(NSString *)commentStr font:(UIFont *)font Height :(CGFloat)height
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

@end
