//
//  ZYDetailHeaderView.h
//  BeautyMall
//
//  Created by JayZY on 15/10/14.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYDetailHeaderView;
@protocol ZYDetailHeaderViewDelegate <NSObject>
/**
 *  商品细节或者商品参数被点击
 *
 *  @param btn
 */
-(void)ZYDetailHeaderViewButtonClick:(UIButton *)btn;

@end

@interface ZYDetailHeaderView : UIView
/**
 *  商品图片
 */
@property (nonatomic,strong) UIButton *buttonPic;
/**
 *  商品文字
 */
@property (nonatomic,strong) UIButton *buttonText;
/**
 *  代理
 */
@property (nonatomic,assign) id<ZYDetailHeaderViewDelegate> delegate;
@end
