//
//  ZYProductDetailsVC.h
//  BeautyMall
//
//  Created by JayZY on 15/9/24.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYRootViewController.h"

@interface ZYProductDetailsVC : ZYRootViewController
/**
 *  产品图片的ID
 */
@property (nonatomic,copy) NSString *taobao_num_iid;
/**
 *  粉丝喜爱的数据
 */
@property (nonatomic,copy) NSString *object_id;
@end
