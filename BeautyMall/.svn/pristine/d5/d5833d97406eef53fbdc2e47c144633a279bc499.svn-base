//
//  ZYImageSizeByURL.m
//  BeautyMall
//
//  Created by JayZY on 15/10/15.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYImageSizeByURL.h"

@implementation ZYImageSizeByURL

+(CGSize)imageSizeByImageUrl:(NSString *)imageUrl
{
    NSArray *picWH = [imageUrl  componentsSeparatedByString:@"/"];
    CGSize imgSize =CGSizeZero ;
    if ([self allNumbers:[picWH lastObject]].length >0) {//最后一个不是全数字,需要重新获取宽高的值
        
        NSArray *pics = [imageUrl  componentsSeparatedByString:@"_"];
        if ([pics count]>1) {
            //截取字符串的前三个
            imgSize =CGSizeMake([[pics[[pics count]-2] substringToIndex:3] floatValue], [[[pics lastObject] substringToIndex:3] floatValue]);
        }else
        {
            imgSize =CGSizeMake(180, 180);
        }
    }else{ //全是数字格式,最后一个是返回的高度
        
        imgSize =CGSizeMake([picWH[[picWH count]-3] floatValue], [[picWH lastObject] floatValue]);
    }
    return imgSize;
}

/**
 *  把originstr字符串进行转化后判断新字符串是否是全数字
 *
 *  @param originStr
 *
 *  @return
 */
+(NSString *)allNumbers :(NSString *)originStr
{
    NSCharacterSet *characterSet =[NSCharacterSet decimalDigitCharacterSet];
    NSString *imgHeight = [originStr stringByTrimmingCharactersInSet:characterSet];
    return [imgHeight stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
