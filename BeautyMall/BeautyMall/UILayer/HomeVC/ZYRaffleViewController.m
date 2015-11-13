//
//  ZYRaffleViewController.m
//  BeautyMall
//
//  Created by JayZY on 15/10/23.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYRaffleViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZYRaffleViewController ()

@end

@implementation ZYRaffleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"摇一摇";
#warning i am doing here

}


- (BOOL)canBecomeFirstResponder
{
    return  YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    UIAlertView *yaoyiyao = [[UIAlertView alloc]initWithTitle:@"温馨提示：" message:@"您摇动了手机，想干嘛？" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles: nil];
    [yaoyiyao show];
    
}


-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"取消");
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
