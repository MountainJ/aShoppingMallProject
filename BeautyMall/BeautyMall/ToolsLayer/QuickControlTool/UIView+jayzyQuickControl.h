//
//  UIView+jayzyQuickControl.h
//  
//
//  Created by jayzhang on 15-4-8.
//  Copyright (c) 2015年 jay张. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JayzyButton.h"


@interface UIView (jayzyQuickControl)
//添加系统按钮

-(UIButton *) addSystemButtonWithFrame: (CGRect )frame title:(NSString *)title action:(void (^)(UIButton *button))action;

//添加自定义按钮

-(UIButton *) addCustomButtonWithFrame: (CGRect )frame title:(NSString *)title action:(void (^)(UIButton *button))action;
//添加图片按钮
-(UIButton *) addImageButtonWithFrame: (CGRect )frame title:(NSString *)title background:(NSString *) background action:(void (^)(UIButton *button))action;

//添加imageView
-(UIImageView *) addImageViewWithFrame: (CGRect )frame image:(NSString *)image;
//添加标签
-(UILabel *) addLabelWithFrame: (CGRect )frame text:(NSString *)text;

//设置更改图片的尺寸然后显示
-(UIImage*)scaleToSize:(NSString *)image withSize:(CGSize)size;




@end
