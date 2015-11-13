//
//  ZYShakeViewController.m
//  BeautyMall
//
//  Created by JayZY on 15/10/28.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYShakeViewController.h"

@interface ZYShakeViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIWebView *resultWebView;

@end


@implementation ZYShakeViewController

- (UIWebView *)resultWebView
{
    if (!_resultWebView) {
        _resultWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, AppScreenHeight)];
        [self.view addSubview:_resultWebView];
    }
    return _resultWebView;

}

#pragma mark - webview滑动时隐藏导航栏
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView ==self.resultWebView.scrollView&&self.resultWebView.scrollView.contentOffset.y>0) {
        self.navigationController.navigationBar.hidden = YES;
    }else{
        self.navigationController.navigationBar.hidden = NO;
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:self.webUrlString];
    //http://tjcx.kkol.com.cn/#2
    [self.resultWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.resultWebView.delegate = self;
    self.resultWebView.scrollView.delegate = self;
    self.resultWebView.contentMode = UIViewContentModeScaleAspectFill;
    //
    self.navigationItem.leftBarButtonItem.title = @"返回";
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
