//
//  ZYProductPicFrame.h
//  BeautyMall
//
//  Created by JayZY on 15/9/21.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZYProuductPicModel.h"

@class ZYProductPicFrame;
@protocol ZYProductPicFrameDelegate <NSObject>

- (void)reloadDataWithModel;

@end

@interface ZYProductPicFrame : NSObject

/**
 *  模型
 */
@property (nonatomic,strong) ZYProuductPicModel *picModel;
/**
 *  产品图片的Frame
 */
@property (nonatomic,assign) CGRect backIMGViewFrame;

@property (nonatomic,assign) CGRect priceLabelFrame;

@property (nonatomic,assign) CGRect likeIMGViewFrame;

@property (nonatomic,assign) CGRect likeLabelFrame;

@property (nonatomic,assign) id<ZYProductPicFrameDelegate>delegate;

/**
 *  一款产品展示的总高度
 */
@property (nonatomic,assign) float totalItemHeight;
/**
 *  根据模型计算出各个控件的高度
 *
 *  @param model 
 */
- (void)setFrameWithModel :(ZYProuductPicModel *)model;




@end
