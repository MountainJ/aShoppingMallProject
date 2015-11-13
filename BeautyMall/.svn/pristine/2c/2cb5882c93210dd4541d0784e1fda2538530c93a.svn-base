//
//  ZYTabbarController.m
//  BeautyMall
//
//  Created by JayZY on 15/9/6.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYTabbarController.h"
#import "ZYHomeViewController.h"
#import "ZYBrandViewController.h"
#import "ZYTopicViewController.h"
#import "ZYShoppingCarViewController.h"
#import "ZYProfileViewController.h"

@interface ZYTabbarController ()

@property (nonatomic,strong) NSArray *picArray ;
@property (nonatomic,strong) NSArray *picSelectedArray ;
//@property (nonatomic,strong) NSArray *textArray ;


#define iTemWidth AppScreenWidth/self.picArray.count


@end

@implementation ZYTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.picArray = @[@"yuike_maintab_home_nor",@"yuike_maintab_brand_nor",@"yuike_maintab_activity_nor",@"yuike_maintab_shopcart_nor",@"yuike_maintab_space_nor"];
     self.picSelectedArray = @[@"yuike_maintab_home_sel",@"yuike_maintab_brand_sel",@"yuike_maintab_activity_sel",@"yuike_maintab_shopcart_sel",@"yuike_maintab_space_sel"];
    ZYHomeViewController *homeVc= [[ZYHomeViewController alloc] init];
    UINavigationController *homeNV = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
    ZYBrandViewController *brandVc =[[ZYBrandViewController alloc] init];
    UINavigationController *brandnv =[[UINavigationController alloc] initWithRootViewController:brandVc];
    ZYTopicViewController *topicVC =[[ZYTopicViewController alloc] init];
    UINavigationController *topicNV = [[UINavigationController alloc] initWithRootViewController:topicVC];
    ZYShoppingCarViewController *shopVC =[[ZYShoppingCarViewController alloc] init];
    UINavigationController *shopNV = [[UINavigationController alloc] initWithRootViewController:shopVC];

    ZYProfileViewController *profVC =[[ZYProfileViewController alloc] init];
    UINavigationController *profNV  = [[UINavigationController alloc] initWithRootViewController:profVC];
    self.viewControllers =@[homeNV,brandnv,topicNV,shopNV,profNV];
    for (int i= 0; i<self.picArray.count; i++)
    {
    UIImage * normalImage = [[UIImage imageNamed:self.picArray[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[UIImage imageNamed:self.picSelectedArray[i]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:@"" image:normalImage selectedImage:selectImage];
        UINavigationController *nav =self.viewControllers[i];
        nav.tabBarItem = tabBarItem;
        nav.tabBarItem.imageInsets =UIEdgeInsetsMake(5, 0, -5, 0);
    }
    self.selectedIndex = 0;
    
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
