//
//  ZYUsersLikeCell.h
//  BeautyMall
//
//  Created by JayZY on 15/10/9.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYUsersLikeCell : UITableViewCell
/**
 *  粉丝头像的展示
 */
@property (nonatomic,strong) UIScrollView *userScrollView;
/**
 *  显示更多粉丝头像
 */
@property (nonatomic,strong) UIImageView *moreUsersView;

/**
 *  根据粉丝的多少创建粉丝头像个数
 *
 *  @param urlArray ZYUsersLikeModel,喜爱的用户头像
 */
- (void)setUpUsersIconViewWithUrlArray:(NSArray *)urlArray;


@end
