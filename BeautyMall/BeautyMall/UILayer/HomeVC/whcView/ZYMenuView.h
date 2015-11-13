//
//  ZYMenuView.h
//  BeautyMall
//
//  Created by JayZY on 15/9/15.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//



@interface ZYMenuView : UIView

/**
 *  初始化
 *
 *  @param frame
 *  @param dataArr
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArr ;

/**
 *  刷新表格
 */
- (void)reloadView;

@end
