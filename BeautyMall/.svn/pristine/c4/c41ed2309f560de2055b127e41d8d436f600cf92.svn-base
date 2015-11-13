//
//  ZYDetailHeaderView.m
//  BeautyMall
//
//  Created by JayZY on 15/10/14.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYDetailHeaderView.h"

#import "UIView+jayzyQuickControl.h"

@implementation ZYDetailHeaderView

-(instancetype )initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yuike_item_bg_alphax_sp"]];
        [self configUI];//yuike_item_bg_alphax_5p_sp
    }
    
    return self;
    
}

#pragma mark - 创建商品细节及商品详情
- (void)configUI
{
    
    WS(weakSelf)
    _buttonPic = [self addCustomButtonWithFrame:CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height) title:@"商品细节" action:^(UIButton *button) {
        button.selected=YES;
        weakSelf.buttonText.selected = NO;
        
        if ([weakSelf.delegate respondsToSelector:@selector(ZYDetailHeaderViewButtonClick:)]) {
            [weakSelf.delegate ZYDetailHeaderViewButtonClick:button];
        }
    }];
    [_buttonPic setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_buttonPic setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    _buttonText = [self addCustomButtonWithFrame:CGRectMake(CGRectGetMaxX(_buttonPic.frame), 0, CGRectGetWidth(_buttonPic.frame), CGRectGetHeight(_buttonPic.frame)) title:@"商品参数" action:^(UIButton *button) {
        button.selected=YES;
        weakSelf.buttonPic.selected = NO;
        
        if ([weakSelf.delegate respondsToSelector:@selector(ZYDetailHeaderViewButtonClick:)]) {
            [weakSelf.delegate ZYDetailHeaderViewButtonClick:button];
        }
        
    }];
    [_buttonText setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_buttonText setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
