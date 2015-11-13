//
//  ZYProfileViewController.m
//  BeautyMall
//
//  Created by JayZY on 15/9/6.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYProfileViewController.h"

#import "UIView+jayzyQuickControl.h"

@interface ZYProfileViewController ()
{

    UILabel *_picSizeLabel;
}


@end


@implementation ZYProfileViewController

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    NSUInteger tmpSize = [[SDImageCache sharedImageCache] getSize] ;
//    NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"(%ud M)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%ud K)",tmpSize * 1024];
    float totalSize = tmpSize / 1024.0 / 1024.0;
    _picSizeLabel.text = [NSString stringWithFormat:@"%.3f M",totalSize];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor lightGrayColor];
    if (!_picSizeLabel) {
        _picSizeLabel = [self.view addLabelWithFrame:CGRectMake(100, 100, 100, 30) text:nil];
        _picSizeLabel.textColor = [UIColor redColor];
        _picSizeLabel.backgroundColor = [UIColor yellowColor];
    }
    
    [self.view addSystemButtonWithFrame:CGRectMake(100, 150, 100, 30) title:@"清除" action:^(UIButton *button) {
        //
        [[SDImageCache sharedImageCache] clearDisk];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
