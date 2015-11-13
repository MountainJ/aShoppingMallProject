//
//  ZYLikeShareView.h
//  BeautyMall
//
//  Created by JayZY on 15/10/10.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYLikeShareView;

@protocol  ZYLikeShareViewDelegate <NSObject>

-(void)clickedButton:(UIButton *)button;


@end

@interface ZYLikeShareView : UIImageView


@property (nonatomic,assign) id<ZYLikeShareViewDelegate> delegate;

@end
