//
//  ZYLikeShareView.m
//  BeautyMall
//
//  Created by JayZY on 15/10/10.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYLikeShareView.h"

#import "PicTextTool.h"

@interface ZYLikeShareView ()<PicTextToolDelegate>
{

}

@end

@implementation ZYLikeShareView
-(instancetype )initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"yuike_item_bg_alphax_5p_sp"];
        NSArray *picArray = @[@"button_like_text_right",@"button_share_right_gitf",@"button_collect_album_right"];
        
        
//        if (_topViewHidden)
//        {
//      picArray=@[@"button_like_text_right",@"button_share_right",@"button_collect_album_right"];
//        }
        [PicTextTool creatLeftPictureRightTextPicture:picArray textArray:nil textFont:0 addToView:self buttonSize:CGSizeMake(AppScreenWidth/picArray.count, self.bounds.size.height) imgIconSize:CGSizeMake(AppScreenWidth/(2*picArray.count), self.bounds.size.height-10) toTarget:self.delegate buttonFirstTag:3251 ];
    }
    
    return self;
    
}
- (void)buttonClickHere:(UIButton *)btn
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(clickedButton:)]) {
        [self.delegate  clickedButton:btn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
