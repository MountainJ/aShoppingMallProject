//
//  ZYShareCell.h
//  BeautyMall
//
//  Created by JayZY on 15/10/10.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYShareCellDelegate <NSObject>

- (void)shareButtonClickedToShare:(UIButton *)btn;

@end


@interface ZYShareCell : UITableViewCell


@property (nonatomic,assign) BOOL topViewHidden;

- (void)setTopShareViewHidden:(BOOL)hideTopView;

@property (nonatomic,assign) id<ZYShareCellDelegate> delegate;

@end
