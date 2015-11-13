//
//  UIView+jayzyQuickControl.m
//
//
//  Created by jayzhang on 15-4-8.
//  Copyright (c) 2015年 jay张. All rights reserved.
//

#import "UIView+jayzyQuickControl.h"

@implementation UIView (jayzyQuickControl)
//添加系统按钮
-(UIButton *) addSystemButtonWithFrame: (CGRect )frame title:(NSString *)title action:(void (^)(UIButton *button))action{
    JayzyButton *button =[JayzyButton buttonWithType:UIButtonTypeSystem];
    button.frame =frame;
    [button setTitle:title forState:UIControlStateNormal];
    
    button.action =action;
    [self addSubview:button];
    return button;
}
//自定义button
-(UIButton *)addCustomButtonWithFrame:(CGRect)frame title:(NSString *)title action:(void (^)(UIButton *button))action
{
    JayzyButton *button =[JayzyButton buttonWithType:UIButtonTypeCustom];
    button.frame =frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    button.action =action;
    [self addSubview:button];
    return button;
    
}

//添加图片按钮
-(UIButton *) addImageButtonWithFrame: (CGRect )frame title:(NSString *)title background:(NSString *) background action:(void (^)(UIButton *button))action{

    JayzyButton *button =[JayzyButton buttonWithType:UIButtonTypeSystem];
    button.frame =frame;
    [button setTitle:title forState:UIControlStateNormal];
[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//
  [button setBackgroundImage:[UIImage imageNamed:background] forState:UIControlStateNormal];
      button.action =action;
    [self addSubview:button];
    return button;
    
}

//添加imageView
-(UIImageView*) addImageViewWithFrame: (CGRect )frame image:(NSString *)image{
    UIImageView *imageView =[[UIImageView alloc] initWithFrame:frame];
    imageView.image =[UIImage imageNamed:image];
    imageView.userInteractionEnabled =YES;
    [self addSubview:imageView];
    return imageView;

}
//添加标签
-(UILabel *) addLabelWithFrame: (CGRect )frame text:(NSString *)text{
    UILabel *label =[[UILabel alloc] initWithFrame:frame];
    label.text =text;
    [self addSubview:label];
    return label;
}

//改变图片的尺寸
-(UIImage*)scaleToSize:(UIImage *)image withSize:(CGSize)size
{
  
    UIGraphicsBeginImageContext(size);
    UIImage *originImage =image;
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}







@end
