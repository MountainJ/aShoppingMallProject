//
//  ZYImageSizeByURL.h
//  BeautyMall
//
//  Created by JayZY on 15/10/15.
//  Copyright © 2015年 jayZY. All rights reserved.
//此工具类用来从图片的URL当中获取到图片的宽高

#import <Foundation/Foundation.h>

@interface ZYImageSizeByURL : NSObject


+(CGSize )imageSizeByImageUrl:(NSString *)imageUrl;


@end
