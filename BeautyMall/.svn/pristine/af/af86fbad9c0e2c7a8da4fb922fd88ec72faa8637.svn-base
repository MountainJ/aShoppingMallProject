//
//  ZYUsersLikeCell.m
//  BeautyMall
//
//  Created by JayZY on 15/10/9.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYUsersLikeCell.h"
#import "UIView+jayzyQuickControl.h"
#import "ZYUsersLikeModel.h"

#define OriginX 15
#define UsersViewCount 7

#define ScrollViewWidth AppScreenWidth-OriginX*2
#define ScorllViewHeight 30
#define Margin  4.0
#define  IconViewWidth (ScrollViewWidth-Margin*UsersViewCount)/(UsersViewCount+1)

@implementation ZYUsersLikeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        
    }
    return self;

}

- (void)creatUI
{
    
    UILabel *placeHolderLabel  =[self .contentView addLabelWithFrame:CGRectMake(OriginX, 10, AppScreenWidth-2*OriginX, 30) text:@"她们也喜欢这件宝贝"];
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.font= [UIFont systemFontOfSize:12.0f];
    //创建1个uiscrollView  根据数据来创建View的个数;
    _userScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(OriginX, CGRectGetMaxY(placeHolderLabel.frame), ScrollViewWidth, IconViewWidth)];
    [self.contentView addSubview:_userScrollView];
    
    for (int i=0; i<UsersViewCount; i++) {
        UIImageView *userIconView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(IconViewWidth+Margin), 0, IconViewWidth, IconViewWidth)];
        userIconView.tag = i+78524;
        userIconView.layer.borderWidth = 0.5;
        userIconView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        userIconView.layer.cornerRadius =2.0;
        userIconView.layer.masksToBounds = YES;
        userIconView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap =[[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconClick:)];
        [userIconView addGestureRecognizer:tap];
        [_userScrollView addSubview:userIconView];
    }
    //
    _moreUsersView = [[UIImageView alloc] initWithFrame:CGRectMake(ScrollViewWidth-IconViewWidth, 0, IconViewWidth, IconViewWidth)];
    _moreUsersView.userInteractionEnabled = YES;
    _moreUsersView.image =[UIImage imageNamed:@"button_more_users"];
    UITapGestureRecognizer *tap =[[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreUserClick:)];
    [_moreUsersView addGestureRecognizer:tap];
    [_userScrollView addSubview:_moreUsersView];
    _userScrollView.contentSize = CGSizeMake((UsersViewCount+1)*(IconViewWidth+Margin), IconViewWidth);
    _userScrollView.showsHorizontalScrollIndicator = NO;
}
#pragma mark - 
- (void)userIconClick:(UITapGestureRecognizer *)sender
{
    NSLog(@"%d",sender.view.tag);
}

- (void)moreUserClick:(UITapGestureRecognizer *)sender
{
    NSLog(@"%@",sender.view);
}


- (void)setUpUsersIconViewWithUrlArray:(NSArray *)urlArray
{
        for (int i=0;i<urlArray.count;i++)
        {
            ZYUsersLikeModel *model = urlArray[i];
            UIImageView *iconView =(UIImageView *)[self.contentView viewWithTag:78524+i];
            [iconView sd_setImageWithURL:[NSURL URLWithString:model.user_image_url]];
        }
     if (urlArray.count<UsersViewCount)
         
     {//喜爱的粉丝少于7,隐藏后面的
        for (int i=urlArray.count;i<UsersViewCount;i++) {
            UIImageView *iconView =(UIImageView *)[self.contentView viewWithTag:78524+i];
            iconView.hidden = YES;
           
            
        }
#warning why 没有显示?
//         [UIView animateWithDuration:0.25 animations:^{
//             //
//             _moreUsersView.transform = CGAffineTransformMakeTranslation(-(UsersViewCount-urlArray.count)*(IconViewWidth+Margin), 0);

//         }];
         
          _moreUsersView.frame = CGRectMake(urlArray.count*(IconViewWidth+Margin), 0, IconViewWidth, IconViewWidth);
       
     }
  
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
