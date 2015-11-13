//
//  ZYTopLikeView.m
//  BeautyMall
//
//  Created by JayZY on 15/9/16.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYTopLikeView.h"

#import "UIImageView+WebCache.h"

@interface ZYTopLikeView ()


@end


@implementation ZYTopLikeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {
        //
        self.userInteractionEnabled  = YES;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height/2)];
        self.upLabel.textAlignment = NSTextAlignmentCenter;
        self.upLabel.textColor  =[UIColor whiteColor];
        self.upLabel.font = [UIFont systemFontOfSize:14.0f];
        self.upLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.upLabel];
        
        self.downlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.upLabel.frame)-5, self.bounds.size.width, self.bounds.size.height/2)];
        self.downlabel.backgroundColor = [UIColor clearColor];
        self.downlabel.textColor  =[UIColor whiteColor];
        self.downlabel.font = [UIFont systemFontOfSize:14.0f];
        self.downlabel.textAlignment = NSTextAlignmentCenter;

        [self addSubview:self.downlabel];
        UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)setImageViewImage:(NSString *)imgString upLabelText:(NSString *)upText downLabelText:(NSString *)downLabelText
{
    [self sd_setImageWithURL:[NSURL URLWithString:imgString]];
    self.upLabel.text = upText;
    self.downlabel.text = downLabelText;
}
- (void)clickImageView :(UIGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TopLikeViewClick" object:sender.view userInfo:nil];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
