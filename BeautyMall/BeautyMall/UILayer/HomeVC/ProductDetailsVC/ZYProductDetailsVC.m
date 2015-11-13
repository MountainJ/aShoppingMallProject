//
//  ZYProductDetailsVC.m
//  BeautyMall
//
//  Created by JayZY on 15/9/24.
//  Copyright © 2015年 jayZY. All rights reserved.
//

#import "ZYProductDetailsVC.h"

#import "ZYBottomBuyBar.h"

#import "ZJLoopScrollView.h"
#import "ZYDescripView.h"
#import "ZYParametersModel.h"
#import "ZYProudutDetailModel.h"

#import "ZYUsersLikeCell.h"
#import "ZYShareCell.h"
#import "ZYLikeShareView.h"
#import "ZYServiceCell.h"
#import "ZYBrandStoreCell.h"
#import "ZYUsersLikeModel.h"
#import "ZYDetailHeaderView.h"
#import "ZYPicDetailCell.h"
#import "ZYImageSizeByURL.h"

#define kToolBarHeight (49)
#define kDescripLabelsH 85

@interface ZYProductDetailsVC ()<UITableViewDataSource,UITableViewDelegate,ZYShareCellDelegate,ZYDetailHeaderViewDelegate,ZYBottomBuyBarDelegate>
{
    NSMutableArray *_productDescripArray;
    NSMutableArray *_productDetailArray; //商品服务及商品图片等数据存储
    NSMutableArray *_usersDataArray;
    UIView *_backHeaderView;
    ZYProudutDetailModel *_productModel;
    BOOL  hideShareView;    //是否显示头部引导分享
    NSMutableArray *_servicePics;//售后服务图片
    NSMutableArray *_serviceTexts;//售后服务文字
    ZYDetailHeaderView *_detailHeaderView;//商品细节,商品参数
    UIButton *_rightBarButton;//右边的购物车
    //购物车物品数量
    NSUInteger shopCartNumber;

}

//底部工具条
@property (nonatomic,strong) ZYBottomBuyBar *bottomToolBar;

@property (nonatomic,strong) UITableView *tableView;
//轮播滚动图片
@property (nonatomic,strong) ZJLoopScrollView *loopScrollView;
//描述,价格等
@property (nonatomic,strong) ZYDescripView *descripView;
/**
 *  产品细节信息
 */
@property (nonatomic,strong) NSMutableArray *productDetails;
/**
 *  喜爱的粉丝
 */
@property (nonatomic ,strong) NSMutableArray *userLikes;
/**
 *  商品细节图片
 */
@property (nonatomic,strong) NSMutableArray *detailPictures;
/**
 *  商品参数文字
 */
@property (nonatomic ,strong) NSMutableArray *detailTexts;
/**
 *  加入购物车曲线
 */
@property (nonatomic,strong) UIBezierPath *shopBezierPath;




@end

@implementation ZYProductDetailsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //界面的架构实现
    /*
     1.导航栏的定制
     
     1.5.好像这里还是会有一块固定或者不固定的.暂时不考虑.
     2.顶部图片轮播视图以及描述视图是固定的.
     3.提示分享的工具条,不固定显示,高度跟下面的喜欢分享条目一样;(不固定)
     4.喜欢分享专辑条目是固定显示;
     5.品质保证等图标固定可见,高度也是固定的.
     6.品牌店铺的显示,固定可见;
     7.粉丝喜欢的栏目,不固定可见(不固定)
     8.商品细节,商品参数,固定
     */
  
    /* 设计思路:
     tableView进行展示;
     2,tableview 的头部视图;
     3,4,5,6,7(section 0 头部动态可见,cell1 3个button,cell2 3个图文label,cell3店铺可点击,footer根据数据设置动态可见);
     (修改下,将footer更改成一个cell,根据数据源的情况返回个数)
     8(section1,头部两个Buton,根据点击以及数据源,给出cell的数量及cell的创建显示);
    */
    
     /*
      用到的网络接口
      #define PRODUCT_DETAIL_URL @"http://api.yuike.com/beautymall/api/1.0/product/detail.php?sid=08d2083bb7cfc33a3217c490963857a5&taobao_num_iid=38515847646&yk_appid=1&yk_cbv=2.9.0.1&yk_pid=1&yk_user_id=2014899 "
      #define USERS_LIKE_URL @" http://api.yuike.com/beautymall/api/1.0/like/list.php?count=40&cursor=0&object_id=38515866302&sid=08d2083bb7cfc33a3217c490963857a5&type=product&yk_appid=1&yk_cbv=2.9.0.1&yk_pid=1&yk_user_id=2014899"
     */
    //  1.导航栏的定制
    [self configNav];
    self.view.backgroundColor = [UIColor lightGrayColor];
    //2.创建底部栏
    [self creatToolBar];
    //3.创建tableView
    [self tableView];
    //4.header
//    [self configTableHeaderView];
    //5.数据下载,下载完成过后,更新tableView;
    [self loadProductData];
    //
    _servicePics = [[NSMutableArray alloc] init];
    _serviceTexts = [[NSMutableArray alloc] init];
    //下载粉丝头像数据
    [self loadUserLikesData];
}

- (NSMutableArray *)productDetails
{
    if (!_productDetails) {
        _productDetails = [NSMutableArray array];
    }
    return _productDetails;
}
- (NSMutableArray *)userLikes
{

    if (!_userLikes) {
        _userLikes = [NSMutableArray array];
    }
    return _userLikes;
}

- (NSMutableArray *)detailPictures
{

    if (!_detailPictures) {
        _detailPictures = [NSMutableArray array];
    }
    return _detailPictures;

}
- (NSMutableArray *)detailTexts
{
    
    if (!_detailTexts) {
        _detailTexts = [NSMutableArray array];
    }
    return _detailTexts;
}

#pragma mark 用户喜欢数据
- (void)loadUserLikesData
{
    
    ZYParametersModel *model  =[[ZYParametersModel alloc] init];
    model.count=@"40";
    model.cursor=@"0";
    model.object_id=self.taobao_num_iid;
    model.sid =@"08d2083bb7cfc33a3217c490963857a5";
    model.type =@"product";
    model.yk_appid =@"1";
    model.yk_cbv = @"2.9.0.1";
    model.yk_pid = @"1";
    model.yk_user_id =@"2014899";
    NSDictionary *parameter = [model keyValues];
    [ZYHttpDownloadTool GET:USERS_LIKE_URL parameters:parameter success:^(id responseObject) {
        NSDictionary *keyResponseDict =responseObject[@"data"];
        
         if ([keyResponseDict[@"users"] isKindOfClass:[NSArray class]]) {
         self.userLikes = [ZYUsersLikeModel objectArrayWithKeyValuesArray:keyResponseDict[@"users"]];
           
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        //
    }];
   
}

#pragma mark - 产品详情数据
- (void)loadProductData
{
   
    ZYParametersModel *model  =[[ZYParametersModel alloc] init];
    model.sid =@"08d2083bb7cfc33a3217c490963857a5";
    model.taobao_num_iid = self.taobao_num_iid;
    model.yk_appid =@"1";
    model.yk_cbv = @"2.9.0.1";
    model.yk_pid = @"1";
    model.yk_user_id =@"2014899";
    //count=40&cursor=0&object_id=38515866302&sid=08d2083bb7cfc33a3217c490963857a5&type=product&yk_appid=1&yk_cbv=2.9.0.1&yk_pid=1&yk_user_id=2014899
    NSDictionary *parameter = [model keyValues];
    [ZYHttpDownloadTool GET:PRODUCT_DETAIL_URL parameters:parameter success:^(id responseObject) {
        _productModel = [ZYProudutDetailModel objectWithKeyValues:responseObject[@"data"]];

        //是否显示分享引导条
        if ([_productModel.shares_count integerValue]) {
            hideShareView = YES;
        }
        for (NSDictionary *serviceKey in _productModel.service) {
            [_servicePics addObject:serviceKey[@"pic_url"]];
            [_serviceTexts addObject:serviceKey[@"title"]];
        }
        for (NSDictionary *detailsPic in _productModel.mobile_desc) {
            ZYProudutDetailModel *model =[[ZYProudutDetailModel alloc] init];
            model.contentURL =detailsPic[@"content"];
            model.picSize = [ZYImageSizeByURL imageSizeByImageUrl:detailsPic[@"content"]];
            [self.detailPictures addObject:model];
        }
        [self.detailTexts addObjectsFromArray:_productModel.props_name];
        [self configTableHeaderView];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        //
    }];

}

 -(void)configTableHeaderView
{
    
    if (!_backHeaderView) {
        _backHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, AppScreenWidth+kDescripLabelsH)];
        _backHeaderView.backgroundColor = [UIColor yellowColor];
    }
    //创建循环滚动视图
    ZJLoopScrollView *loopScrollView = [[ZJLoopScrollView alloc] init];
    loopScrollView.frame = CGRectMake(0, 0, AppScreenWidth, AppScreenWidth);
    //设置属性
    loopScrollView.autoScroll = NO;
    loopScrollView.showPageControl = YES;
    [loopScrollView setClickAction:^(UIImageView *imageView, int index) {
        NSLog(@"index = %d",index);
    }];
    self.loopScrollView =loopScrollView;
    [_backHeaderView addSubview:self.loopScrollView];
    if (_productModel) {
        self.loopScrollView.pageCount = _productModel.taobao_item_imgs.count;
        for (int i = 0; i<_productModel.taobao_item_imgs.count; i++) {
            NSDictionary *picKey =_productModel.taobao_item_imgs[i];
            [self.loopScrollView setImageWithUrlString:picKey[@"url"] atIndex:i];

        }
    }
    
    //中间的描述
    self.descripView =  [[[NSBundle mainBundle] loadNibNamed:@"ZYDescripView" owner:self options:nil] firstObject];
    self.descripView.frame = CGRectMake(0, CGRectGetMaxY(self.loopScrollView.frame), AppScreenWidth, kDescripLabelsH);
    [_backHeaderView addSubview:self.descripView];
   
    _backHeaderView.frame = CGRectMake(_backHeaderView.frame.origin.x, _backHeaderView.frame.origin.y, AppScreenWidth, CGRectGetHeight(self.loopScrollView.frame)+CGRectGetHeight(self.descripView.frame));
    _tableView.tableHeaderView = _backHeaderView;
    //中间的描述数据
    if (_productModel) {
        //描述
        self.descripView.descripLabel.text = _productModel.taobao_title;
        //促销价格
        self.descripView.proPriceLabel.text = [NSString stringWithFormat:@"%@%@",_productModel.money_symbol,_productModel.taobao_promo_price];
        //原价加入下划线
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",_productModel.money_symbol,_productModel.taobao_price]];
        NSRange strRange = {0,[str length]};
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [self.descripView.priceLabel setAttributedText:str];
       //折扣
        self.descripView.saleCountLabel.text =[NSString stringWithFormat:@"%@",_productModel.discount];
        //销量
        self.descripView.nunbersLabel.text =[NSString stringWithFormat:@"销量:%@",_productModel.taobao_volume];
    }


}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NavigationBarHeight, AppScreenWidth, AppScreenHeight-kToolBarHeight-NavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
    
}

#pragma mark-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return self.userLikes.count?4:3;
    }
    //section1根据数据源返回不同个数cell
    else
    {
        if (_detailHeaderView.buttonPic.selected) {
            return self.detailPictures.count;
        }else{
            return self.detailTexts.count;
        }
    }
}
#pragma mark - 设置段头

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //是否有引导分享
    if (indexPath.section==0&&indexPath.row==0) {
        return  hideShareView?AppScreenHeight-NavigationBarHeight-AppScreenWidth-kToolBarHeight-kDescripLabelsH:(AppScreenHeight-NavigationBarHeight-AppScreenWidth-kToolBarHeight-kDescripLabelsH)*2;
    }
    //有粉丝喜欢的数据才返回这个高度
    if (self.userLikes.count&&indexPath.section==0&&indexPath.row==3)
    {
        return    kDescripLabelsH;
    }
    //店铺
    if (indexPath.section==0&&indexPath.row==1) {
        return 60;
    }
    if (_detailHeaderView.buttonPic.selected&&indexPath.section==1) {
        ZYProudutDetailModel *model =self.detailPictures[indexPath.row];
        CGFloat height =model.picSize.height*(AppScreenWidth/model.picSize.width);
        return height;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section ==1) {
        return AppScreenHeight-NavigationBarHeight-AppScreenWidth-kToolBarHeight-kDescripLabelsH;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        if (!_detailHeaderView) {
            _detailHeaderView =[[ZYDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, AppScreenWidth, AppScreenHeight-NavigationBarHeight-AppScreenWidth-kToolBarHeight-kDescripLabelsH)];
            _detailHeaderView.delegate = self;
            _detailHeaderView.buttonPic.selected = YES;
        }
        return _detailHeaderView;
    }
    else
        return nil;
}


#pragma mark cell设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建1个cell,是否显示引导分享的界面
    if (indexPath.section ==0&&indexPath.row ==0) {
        static NSString *cellID = @"cellLikeShare";
                    ZYShareCell *likeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    if (likeCell==nil) {
                        likeCell = [[ZYShareCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                    }
                   likeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                   [likeCell setTopShareViewHidden:hideShareView];
        likeCell.delegate = self;
                    return likeCell;
    }
    //售后服务
  else  if (indexPath.section ==0&&indexPath.row ==1) {
      static NSString *cellID = @"serviceCell";
        ZYServiceCell *serviceCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (serviceCell==nil) {
            serviceCell = [[ZYServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
      serviceCell.separatorInset = UIEdgeInsetsMake(0, -10, 0, 10);
      serviceCell.selectionStyle = UITableViewCellSelectionStyleNone;
      [serviceCell setCellButtonPicText:_servicePics textString:_serviceTexts];
        return serviceCell;
    }
  //品牌店铺
  else  if (indexPath.section ==0&&indexPath.row ==2) {
      static NSString *cellID = @"storeCell";
        ZYBrandStoreCell *storeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (storeCell==nil) {
            storeCell = [[ZYBrandStoreCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
       [storeCell setStoreName:[NSString stringWithFormat:@"品牌店铺:%@",_productModel.brand[@"title"]]];
        return storeCell;
    }
    //粉丝喜爱
   else if(self.userLikes.count &&indexPath.section ==0&&indexPath.row==3)
   {
       static NSString *cellID = @"fansCell";
       ZYUsersLikeCell *likeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
       if (likeCell==nil) {
           likeCell = [[ZYUsersLikeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
       }
       likeCell.selectionStyle = UITableViewCellSelectionStyleNone;
       [likeCell setUpUsersIconViewWithUrlArray:self.userLikes];
       return likeCell;
   }
    else  if (_detailHeaderView.buttonPic.selected&&indexPath.section ==1) {//展示图片
            //设置商品的图片文字展示
            static NSString *cellID = @"picCell";
            ZYPicDetailCell *minecell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(minecell == nil){
                minecell = [[ZYPicDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
           minecell.selectionStyle = UITableViewCellSelectionStyleNone;
           minecell.separatorInset = UIEdgeInsetsMake(0, AppScreenWidth*2, 0, -AppScreenWidth*2);
           [minecell setPicture:self.detailPictures[indexPath.row]];
            return minecell;
        }
        else {
        
            //设置商品的图片文字展示
            static NSString *cellID = @"textCell";
            UITableViewCell *minecell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(minecell == nil){
                minecell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
            }
            minecell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *textDict =_detailTexts[indexPath.row];
            minecell.textLabel.text = [NSString stringWithFormat:@"%@",textDict[@"pname"]];
            minecell.detailTextLabel.text = [NSString stringWithFormat:@"%@",textDict[@"vname"]];
            return minecell;
        }


        
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //品牌店铺
    if (indexPath.section==0&&indexPath.row==2) {
        //
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"品牌店铺");
    }
    if(indexPath.section ==0&&indexPath.row==3)
    {
        
    }


}

#pragma mark--ToolBar  ////////////========正在编辑加入数据库
-(void)creatToolBar
{
    self.bottomToolBar = [[ZYBottomBuyBar alloc] initWithFrame:CGRectMake(0.0, AppScreenHeight-kToolBarHeight, AppScreenWidth, kToolBarHeight)];
    self.bottomToolBar.buyDelegate = self;
    [self.view addSubview:self.bottomToolBar];

}

-(void)addToShopCart
{
//贝塞尔曲线,直接进入购物车曲线
//    CGPoint startPoint = [self.view convertPoint:self.bottomToolBar.btnAddToCart.center fromView:self.bottomToolBar];
    
    CGPoint startPoint = self.view.center;//换成中点
    //设置动画图片
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ani_addShopCart"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, 35, 35);
    imageView.hidden = YES;
    imageView.center = startPoint;
    //动画 终点 都以self.view为参考系
    CGPoint endpoint = [self.view convertPoint:_rightBarButton.center fromView:self.navigationController.navigationBar];
    self.shopBezierPath =[UIBezierPath bezierPath];
    //动画起点
    [self.shopBezierPath  moveToPoint:startPoint];

    //贝塞尔曲线控制点
    float sx = startPoint.x;
    float sy = startPoint.y;
    float ex = endpoint.x;
    float ey = endpoint.y;
    float x = sx + (ex - sx) / 3.0;
    float y = sy + (ey - sy) * 0.5;
    CGPoint centerPoint=CGPointMake(x, y);

    [self.shopBezierPath  addQuadCurveToPoint:endpoint controlPoint:centerPoint];
    
    //创建图层
    CALayer *layer = [[CALayer alloc]init];
    layer.contents = imageView.layer.contents;
    layer.frame = imageView.frame;
    layer.opacity = 1;
    [self.view.layer addSublayer:layer];
    //旋转
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 5.0f;
    rotationAnimation.fillMode  =kCAFillModeForwards;
    [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat: 1.0 ];
    scaleAnimation.toValue = [NSNumber numberWithFloat: 2.0 ];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = 0;
    scaleAnimation.duration = 0.5;//不设置时候的话，有一个默认的缩放时间.
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    //贝塞尔曲线路径
//    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.path = self.shopBezierPath .CGPath;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.duration = 3.0;
//    animation.delegate = self;
//    animation.autoreverses = NO;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [layer addAnimation:animation forKey:@"buy"];
//
    [self performSelector:@selector(removeFromLayer:) withObject:layer afterDelay:1.0f];//增加

}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    CGPoint startPoint = self.view.center;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ani_addShopCart"]];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.frame = CGRectMake(0, 0, 35, 35);
    imageView.hidden = YES;
    imageView.center = startPoint;
    layerAnimation.contents = imageView.layer.contents;
    layerAnimation.frame = imageView.frame;
    layerAnimation.opacity = 1;
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = self.shopBezierPath .CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 2.0;
    animation.delegate = self;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layerAnimation addAnimation:animation forKey:@"buy"];
    [self.view.layer addSublayer:layerAnimation];

//    [layerAnimation removeFromSuperlayer];
}
#pragma mark -添加购物车动画完成
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    shopCartNumber ++;
    [self navBadgeView:NO showNum:[NSString stringWithFormat:@"%u",shopCartNumber]];
}

- (UILabel *)navBadgeView:(BOOL)isHidden showNum:(NSString *)numberString
{
    UILabel *badgeLabel =[[ UILabel alloc] initWithFrame:CGRectMake(30, 0, 20, 20)];
    badgeLabel.backgroundColor = [UIColor redColor];
    badgeLabel.layer.cornerRadius = 10.0;
    badgeLabel.layer.masksToBounds = YES;
    badgeLabel.text= numberString;
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.font = [UIFont systemFontOfSize:12.0f];
    [_rightBarButton addSubview:badgeLabel];
    badgeLabel.hidden = isHidden;
    return badgeLabel;
}


-(void)dealloc
{
    NSLog(@"%s",__func__);

}


#pragma mark -导航栏
- (void)configNav
{
     WS(weakSelf)
    self.title = @"宝贝详情";
    UIButton *btnLeft =[self.view addImageButtonWithFrame:CGRectMake(0, 0, 50, 50) title:nil background:@"button_back-iOS7" action:^(UIButton *button) {
        //;
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.leftBarButtonItem =backItem;
    
    UIButton *btnRight =[self.view addImageButtonWithFrame:CGRectMake(0, 0, 50, 50) title:nil background:@"button_titleBar_shopcart" action:^(UIButton *button) {
        //;
        NSLog(@"购物车");
        
    }];
    _rightBarButton = btnRight;
    UIBarButtonItem *shopCart =[[UIBarButtonItem alloc] initWithCustomView:_rightBarButton];

    self.navigationItem.rightBarButtonItem =shopCart;
   
}


#pragma mark -喜欢分享专辑点击
 -(void)shareButtonClickedToShare:(UIButton *)btn
{
    switch (btn.tag) {
           case 3251://喜欢
            [self.view makeToast:@"喜欢" duration:2 position:@"center" title:nil];
            NSLog(@"%d",btn.tag);
            break;
            case 3252://分享
            [self.view makeToast:@"分享" duration:2 position:@"center" title:nil];
            NSLog(@"%d",btn.tag);

            
            break;
            case 3253://专辑
            [self.view makeToast:@"专辑" duration:2 position:@"center" title:nil];
            NSLog(@"%d",btn.tag);

            break;
        default:
            break;
    }
    

}
#pragma mark - 点击切换商品图片文字详情
-(void)ZYDetailHeaderViewButtonClick:(UIButton *)btn
{
    [self.tableView  reloadData];
    
}

#warning //根据字典生成model代码
-(void)createModelCodeWithDictionary:(NSDictionary *)dict name:(NSString *)name
{
    printf("\n@interface %s : NSObject\n",name.UTF8String);
    for (NSString *key in dict) {
        printf("@property (copy,nonatomic) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
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
