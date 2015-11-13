//
//  ZYHomeTimeCell.m
//  BeautyMall
//
//  Created by JayZY on 15/9/24.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYHomeTimeCell.h"

@implementation ZYHomeTimeCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        //
        [self creatUI];
        
    }
    
    return self;
    
}

-(void)creatUI
{
    _backImgView =[[UIImageView alloc] initWithFrame:self.bounds];
    _backImgView.image = [[UIImage imageNamed:@"yuike_waterfallv2_datebg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    [self.contentView addSubview:_backImgView];
    
    _starImgView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuike_waterfallv2_star"]];
    _starImgView.frame = CGRectMake(CGRectGetMaxX(self.bounds)-15, CGRectGetMinX(self.bounds)-5, 20, 20);
    [self.contentView addSubview:_starImgView];
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height/2)];
    _descLabel.text = @"精选单品";
    _descLabel.textColor = [UIColor whiteColor];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_descLabel];
    
    _dateLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_descLabel.frame)-5, self.bounds.size.width, self.bounds.size.height/2)];
    _dateLabel.textColor = [UIColor whiteColor];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_dateLabel];
    
}

- (void)setCellTime:(NSDate *)nowDate
{
    NSDateFormatter *format =[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM月dd日"];
    NSString *timeStr =[format stringFromDate:nowDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps= [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal) fromDate:nowDate];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    switch (weekday) {
        case 1:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期日",timeStr];
            break;
        case 2:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期一",timeStr];
            break;
        case 3:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期二",timeStr];

            break;
        case 4:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期三",timeStr];

            break;
        case 5:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期四",timeStr];

            break;
        case 6:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期五",timeStr];

            break;
        case 7:
            _dateLabel.text= [NSString stringWithFormat:@"%@ 星期六",timeStr];

            break;
        default:
            break;
    }
}
@end
