//
//  ZYHomeViewController.m
//  BeautyMall
//
//  Created by JayZY on 15/9/6.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYHomeViewController.h"

#import "ZYFirstViewController.h"
#import "MJExtension.h"
#import "ZYAdvertiseModel.h"
#import "ZYParametersModel.h"
#import "UIView+jayzyQuickControl.h"
//
#import "ZY_ContainerView.h"
#import "ZY_ContainerBar.h"
#import "MainHomeView.h"
#import "ZY_BadgeView.h"
#import "ZYMenuView.h"
#import "ZYTopLikeView.h"
#import "ZYProuductPicModel.h"
#import "ZYProductPicFrame.h"

#import "ZYProductDetailsVC.h"
#import "ZYRaffleViewController.h"
#import "ZYShakeViewController.h"

#import "lhScanQCodeViewController.h"


#define ItemWidth  (AppScreenWidth-3*PICMargin)/2

@interface ZYHomeViewController ()<ZY_ContainerViewDelegate,MainHomeViewDelegate>
{
    NSMutableArray  * _viewArr ;
    MainHomeView *_oneofView;
    ZY_ContainerView *_containerView;
    NSInteger headerNum;
    NSInteger footerNum;
    NSInteger cursorIndex;
    MainHomeView  * _mainHomeView;//collecitionView


}

@property  (nonatomic ,strong) NSMutableArray *recommonPicArray;//本周人气推荐
@property  (nonatomic ,strong) NSMutableArray *adPicArray;//广告轮播
@property  (nonatomic ,strong) NSMutableArray *picDataArray;//图片数据

@property  (nonatomic ,strong) NSMutableArray *picDataHeightArray;//图片数据

@property  (nonatomic ,strong) NSMutableArray *picArray;//图片

@property  (nonatomic ,strong) UIButton  *textButton;




@end

@implementation ZYHomeViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏的背景图片
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_header_bg"] forBarMetrics:UIBarMetricsDefault];
//
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor =[UIColor yellowColor];
    _viewArr = [[NSMutableArray alloc] init];
    _picDataArray = [[NSMutableArray alloc] init];
    _picDataHeightArray = [[NSMutableArray alloc] init];
    //创建导航栏
    [self configHomeNav];
    //顶部菜单栏
    [self creatMenuBar];
    //加载广告图片数据
    [self loadAdvertiseData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushFirst:) name:@"TopLikeViewClick" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signShake:) name:@"signShake" object:nil];
  
    
}

# pragma mark  -头部按钮点击
- (void)signShake:(NSNotification *)notification
{
    UIButton *btn =(UIButton *)notification.object;
#warning Todo ...
    if (btn.tag ==1234) { //签到,将签到改成扫描二维码
        lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc]init];
        UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
        [self presentViewController:nVC animated:YES completion:^{
            
        }];
    }
    else if (btn.tag ==1235) { //抽奖
        //
//       [self.view makeToast:[NSString stringWithFormat:@"%@",btn.titleLabel.text] duration:2.0 position:@"center" title:nil];
        //跳转到抽奖界面
        ZYRaffleViewController *rVC =[[ZYRaffleViewController alloc] init];
        [self.navigationController pushViewController:rVC animated:YES];
        
    }
   else if (btn.tag ==1236) { //热门
       [self.view makeToast:[NSString stringWithFormat:@"%@",btn.titleLabel.text] duration:2.0 position:@"center" title:nil];

    }
}

#pragma mark -二维码

//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        [picker removeFromParentViewController];
//    }];
//}

//- (void)loadResultWebviewURL:(NSString *)webUrl
//{
//    ZYShakeViewController *shakeVC =[[ZYShakeViewController alloc] init];
//    shakeVC.webUrlString = webUrl;
//    [self.navigationController pushViewController:shakeVC animated:YES];
////    NSURL *url = [NSURL URLWithString:webUrl];
////    UIWebView *resultWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, AppScreenWidth, AppScreenWidth-NavigationBarHeight)];
////    [resultWeb loadRequest:[NSURLRequest requestWithURL:url]];
////    [self.view addSubview: resultWeb];
//
//}


- (void)pushFirst:(NSNotification *)notif
{
   ZYTopLikeView *toplikeview = (ZYTopLikeView *)notif.object;
   NSLog(@"%@",toplikeview.upLabel.text);
}

-  (void)creatMenuBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray         * titles = @[@"推荐",@"护肤",@"女鞋",@"配饰",@"老公"];
    NSMutableArray  * titlesArr = [titles mutableCopy];
    NSArray         * laterTitlesArr =  @[@"护肤",@"女鞋",@"配饰",@"老公",@"男孩",@"女孩",@"大码",@"青春",@"淑女",@"女包",@"泳装",@"内衣",@"婚礼",@"妈妈",@"爸爸",@"孕妇",@"生活"];
    if ( !_containerView)
    {
        _containerView = [[ZY_ContainerView alloc]initWithFrame:CGRectMake(0, NavigationBarHeight, AppScreenWidth, AppScreenHeight-NavigationBarHeight-49) param:[ZY_ContainerBarParam getZY_ContainerViewParamWithTitles:titlesArr laterTitlesArr:[laterTitlesArr mutableCopy]]];
    }
    [self.view addSubview:_containerView];
}

#pragma mark --recommendData
-(void)downloadRecommendData
{
    ZYParametersModel *model  =[[ZYParametersModel alloc] init];
    model.sid =@"8fe420e870a0412e0daaf97a1cdb1d6e";
    model.yk_pid = @"3";
    model.yk_cc = @"m360";
    model.yk_cvc =@"235";
    model.cursor =@"0";
    model.count =@"40";
    model.yk_appid =@"1";
    NSDictionary *parameter = [model keyValues];
    [ZYHttpDownloadTool GET:RECOMMEND_URL parameters:parameter success:^(id responseObject) {
        ZYAdvertiseModel *model = [ZYAdvertiseModel objectWithKeyValues:responseObject[@"data"]];
        _recommonPicArray=[ZYAdvertiseModel objectArrayWithKeyValuesArray:model.categories];
         for (ZYAdvertiseModel *model in _recommonPicArray) {
            model.title  = responseObject[@"data"][@"title"];
                }
        //加载图片主要数据
        [self loadMainData];
    } failure:^(NSError *error) {
        //
    }];

}

#pragma mark -
//面向模型
- (void)loadMainData
{
    
//    WS(weakSelf);
    ZYParametersModel *model  =[[ZYParametersModel alloc] init];
//    ?yk_user_id=1906286&yk_appid=1&type=choice&yk_cbv=2.8.4.2&yk_pid=1&cursor=%d&sid=c06ca3249f8e3a2459c27ce2fb34ff13&count=40
    model.sid =@"8fe420e870a0412e0daaf97a1cdb1d6e";
    model.yk_pid = @"1";
    model.cursor =[NSString stringWithFormat:@"%d",cursorIndex];
    model.count =@"40";
    model.yk_user_id =@"1906286";
    model.yk_appid =@"1";
    model.type =@"choice";
    model.yk_cbv =@"2.8.4.2";
    if (cursorIndex==0) {
        [_picDataArray removeAllObjects];
    }
    NSDictionary *parameter = [model keyValues];
    [ZYHttpDownloadTool GET:PRODUCT_URL parameters:parameter success:^(id responseObject) {
        ZYAdvertiseModel *model = [ZYAdvertiseModel objectWithKeyValues:responseObject[@"data"]];
        if (cursorIndex==0) {
            NSMutableArray *modelArray = [ZYProuductPicModel objectArrayWithKeyValuesArray:model.products];
            for (ZYProuductPicModel *picModel in modelArray) {
                ZYProductPicFrame *modelFrame =[[ZYProductPicFrame alloc] init];
                [modelFrame setFrameWithModel:picModel];
                [_picDataArray addObject:modelFrame];
            }
        }
        else
        {
            NSMutableArray *modelArray = [[NSMutableArray alloc] init];
            for (ZYProuductPicModel *picModel in [ZYProuductPicModel objectArrayWithKeyValuesArray:model.products])
            {
                ZYProductPicFrame *modelFrame =[[ZYProductPicFrame alloc] init];
                [modelFrame setFrameWithModel:picModel];
                [modelArray addObject:modelFrame];
            }
            [_picDataArray addObjectsFromArray:modelArray];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (cursorIndex==0&&headerNum==0) {
            _containerView.delegate = self;
        }else{//加载,只需要刷新collectionView
            [self  reloadCollectionView:_mainHomeView];
        }
//        [self ZY_ContainerView:_containerView loadContentForCurrentView:_oneofView currentIndex:1];
//        for (ZYAdvertiseModel *model in _recommonPicArray) {
//            
//            NSLog(@"%@",model.background_pic_url);
//            NSLog(@"%@",model.taobao_title);
//        }
        //
     
    } failure:^(NSError *error) {
        //
        
    }];
}

#pragma mark -加载广告数据
- (void)loadAdvertiseData
{
    ZYParametersModel *model  =[[ZYParametersModel alloc] init];
    model.sid =@"8fe420e870a0412e0daaf97a1cdb1d6e";
    model.yk_pid = @"3";
    model.yk_cc = @"m360";
    model.yk_cvc =@"235";
    model.cursor =@"0";
    model.count =@"40";
    model.yk_appid =@"1";
    NSDictionary *parameter = [model keyValues];
    
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.detailsLabelText =@"正在加载...";
    hud.taskInProgress = YES;
    [ZYHttpDownloadTool GET:ADSCROLLVIEW_URL parameters:parameter success:^(id responseObject) {
        _adPicArray =[ZYAdvertiseModel objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //加载本周人气数据
        [self downloadRecommendData];
//        for (ZYAdvertiseModel *model in _adPicArray) {
//            
//            NSLog(@"%@",model.pic_url);
//            NSLog(@"%@",model.url);
//        }
        //
    } failure:^(NSError *error) {
        //
        hud.hidden = YES;
        [self.view makeToast:@"网络不给力" duration:2.0f position:@"center" title:nil];
    }];
  
}

#pragma mark - ZY_ContainerViewDelegate -
- (NSArray *)ZY_ContainerView:(ZY_ContainerView *)containerView updateContainerViewLayoutWithTitlesArr:(NSArray *)titlesArr
{
    for (NSInteger i = 0; i < _viewArr.count;) {
        MainHomeView  * view = _viewArr[i];
        [view removeFromSuperview];
        [_viewArr removeObject:view];
        view = nil;
    }
    CGRect  containerViewRC = {0,NavigationBarHeight,AppScreenWidth,AppScreenHeight - NavigationBarHeight};
    for (int i =0;i<[titlesArr count];i++)
    {
        if (i==0) {
            MainHomeView  * view = [[MainHomeView alloc]initWithFrame:containerViewRC dataArray:_picDataArray topAdData:_adPicArray topArrayData:_recommonPicArray];
            view.delegate = self;
            _mainHomeView= view;
            [_viewArr addObject:_mainHomeView];
        }
        else
        {
            ZYMenuView  * view = [[ZYMenuView alloc]initWithFrame:containerViewRC dataArray:_recommonPicArray];
            [_viewArr addObject:view];
            
        }
    }
    return _viewArr;
}

//- (void)ZY_ContainerView:(ZY_ContainerView *)containerView loadContentForCurrentView:(UIView *)currentView currentIndex:(NSInteger)index{
//    //切换pageView的时候这里会调用来更新currentview 的内容
//    [((MainHomeView*)currentView) reloadView];
//}

- (void)configHomeNav
{
    WS(weakSelf)
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    titleLabel.text =@"美丽衣橱";
    titleLabel.font =[ UIFont fontWithName:@"Helvetica Neue" size:25];
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *rightButton = [self.view addImageButtonWithFrame:CGRectMake(0, 0, 20, 20) title:nil background:@"chatting_toolbar_more" action:^(UIButton *button)
    {
        ZYFirstViewController *firstVC  =[[ZYFirstViewController alloc] init];
         weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:firstVC animated:YES];
    }];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    //
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

#pragma mark -头部视图代理
- (void)MainHomeView :(MainHomeView *)mainHomeView buttonClick:(UIButton *)button
{
    NSLog(@"%@",button.titleLabel.text);
    
}
#pragma mark -上拉下拉delegate
- (void)headerRefreshView
{
    cursorIndex =0;
    ++headerNum;
    [self loadMainData];
   
}

-  (void)footerRefreshView
{
    cursorIndex +=40;
    [self loadMainData];
  
}

-(void)reloadCollectionView:(MainHomeView *)mainView
{
    mainView.picdataArr = [NSMutableArray arrayWithArray:_picDataArray];
    [mainView reloadCollectionView];
}

- (void)itemCellClicked:(ZYProductPicFrame *)cellModel
{
//    NSLog(@"%@",cellModel.picModel.taobao_num_iid);
    ZYProductDetailsVC *dvc =[[ZYProductDetailsVC alloc] init];
    dvc.taobao_num_iid = cellModel.picModel.taobao_num_iid;
    dvc.object_id = cellModel.picModel.brand[@"id"];
    [self.navigationController pushViewController:dvc animated:YES];
//下面这段代码如果加上过后可以设置滑动返回的手势
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
