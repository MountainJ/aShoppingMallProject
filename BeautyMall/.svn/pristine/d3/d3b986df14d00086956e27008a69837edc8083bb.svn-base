//
//  ZYBottomBuyBar.m
//  BeautyMall
//
//  Created by JayZY on 15/9/24.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYBottomBuyBar.h"



@implementation ZYBottomBuyBar



 -(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        //
        [self creatToolBar];
    }
    return self;

}
- (void)creatToolBar
{
    
    WS(weakSelf);
//    [self setBarStyle:UIBarStyleDefault];
//    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    //联系卖家
    UIButton *btnC =[self addImageButtonWithFrame:CGRectMake(0, 0,40, 45) title:nil background:@"button_pdetail_chat" action:^(UIButton *button) {
        //
        NSLog(@"联系卖家");
    }];
    UIBarButtonItem *contact =[[UIBarButtonItem alloc] initWithCustomView:btnC];
    
    //添加到购物车
    _btnAddToCart =[self addImageButtonWithFrame:CGRectMake(0, 40,40, 45) title:nil background:@"button_pdetail_addshop" action:^(UIButton *button) {
        //
        if ([weakSelf.buyDelegate respondsToSelector:@selector(addToShopCart)]) {
            [weakSelf.buyDelegate addToShopCart];
        }
    }];
    UIBarButtonItem *addToShopcart =[[UIBarButtonItem alloc] initWithCustomView:_btnAddToCart];
   
    
    //立即购买
    UIButton *btn =[self addImageButtonWithFrame:CGRectMake(0, 0, 100, 30) title:@"立即购买" background:@"bg_btn" action:^(UIButton *button) {
        NSLog(@"立即购买");
    }];
    btn.layer.cornerRadius =1.0f;
    btn.clipsToBounds =YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *buy =[[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [self setItems:[NSArray arrayWithObjects:contact,addToShopcart,flexItem,buy, nil]];

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
