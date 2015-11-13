//
//  ZYTopLikeView.h
//  BeautyMall
//
//  Created by JayZY on 15/9/16.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//这个类创建一个imageView,根据网路的图片数据,以及文字数据,生成一个按钮

#import <UIKit/UIKit.h>

//@class ZYTopLikeView;
//@protocol ZYTopLikeViewDelegate <NSObject>
//
//- (void)ZYTopLikeView :(ZYTopLikeView *)ZYTopLikeView ;
//
//@end

@interface ZYTopLikeView : UIImageView


-(void)setImageViewImage :(NSString *)imgString upLabelText: (NSString *)upText downLabelText :(NSString *)downLabelText;

@property (nonatomic,strong)  UILabel *upLabel;

@property (nonatomic ,strong) UILabel *downlabel;

//@property (nonatomic,assign) id <ZYTopLikeViewDelegate> delegate;




@end
