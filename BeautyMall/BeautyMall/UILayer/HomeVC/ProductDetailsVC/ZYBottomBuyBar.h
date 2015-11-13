//
//  ZYBottomBuyBar.h
//  BeautyMall
//
//  Created by JayZY on 15/9/24.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYBottomBuyBar;

@protocol ZYBottomBuyBarDelegate <NSObject>
/**
 *  添加到购物车
 */
- (void)addToShopCart;

@end

@interface ZYBottomBuyBar : UIToolbar


@property (nonatomic,assign) id <ZYBottomBuyBarDelegate> buyDelegate;

@property (nonatomic,strong) UIButton *btnAddToCart;
@end
