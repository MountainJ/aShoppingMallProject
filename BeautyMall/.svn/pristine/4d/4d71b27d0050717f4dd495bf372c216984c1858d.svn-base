//
//  ZYProductPicFrame.m
//  BeautyMall
//
//  Created by JayZY on 15/9/21.
//  Copyright (c) 2015年 jayZY. All rights reserved.
//

#import "ZYProductPicFrame.h"

#import "ImageSize.h"

#define PriceLabelHeight 30 //价格标签的高度

#define ItemWidth  (AppScreenWidth-3*PICMargin)/2

//typedef NS_ENUM(NSUInteger, ImageType) {
//    PngImage = 1,
//    JpgImage,
//    GifImage,
//};
//
//@interface ZYProductPicFrame ()
//{
//   ImageType type;
//
//}
//
//@property (strong, nonatomic) NSMutableData *recieveData;
//
//@end

@implementation ZYProductPicFrame


-(void)setFrameWithModel:(ZYProuductPicModel *)model
{
    _picModel = model;
    _picModel.likes_count =model.likes_count?:@"0";
//    type = JpgImage;
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:model.taobao_pic_url]];
//    [request setValue:kJpgRangeValue forHTTPHeaderField:@"Range"];
//    [[NSURLConnection connectionWithRequest:request delegate:self] start];
    //图片展示
    //计算喜欢数的大小
    CGSize sizeLabel  =[_picModel.likes_count boundingRectWithSize:CGSizeMake(MAXFLOAT, PriceLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
    NSArray *picWH = [_picModel.taobao_pic_url  componentsSeparatedByString:@"/"];
    CGSize imgSize =CGSizeZero ;
    if ([self allNumbers:[picWH lastObject]].length >0) {//最后一个不是全数字,需要重新获取宽高的值
    
    NSArray *pics = [_picModel.taobao_pic_url  componentsSeparatedByString:@"_"];
       if ([pics count]>1) {
           //截取字符串的前三个
           imgSize =CGSizeMake([[pics[[pics count]-2] substringToIndex:3] floatValue], [[[pics lastObject] substringToIndex:3] floatValue]);
        }else
        {
            imgSize =CGSizeMake(180, 180);
        }
    }else{ //全是数字格式,最后一个是返回的高度
        
    imgSize =CGSizeMake([picWH[[picWH count]-3] floatValue], [[picWH lastObject] floatValue]);
    }
    _backIMGViewFrame =CGRectMake(0, 0, ItemWidth, imgSize.height*(ItemWidth/imgSize.width));
    _priceLabelFrame =CGRectMake(0, CGRectGetHeight(_backIMGViewFrame), 100, PriceLabelHeight);
    _likeLabelFrame =CGRectMake(ItemWidth-10-sizeLabel.width, CGRectGetHeight(_backIMGViewFrame), sizeLabel.width, PriceLabelHeight);
    _likeIMGViewFrame= CGRectMake(CGRectGetMinX(_likeLabelFrame)-15, CGRectGetHeight(_backIMGViewFrame)+CGRectGetHeight(_priceLabelFrame)/4, 15, 15);
    _totalItemHeight =  CGRectGetMaxY(_priceLabelFrame);
    
}
/**
 *  把originstr字符串进行转化后判断新字符串是否是全数字
 *
 *  @param originStr
 *
 *  @return
 */
-(NSString *)allNumbers :(NSString *)originStr
{
    NSCharacterSet *characterSet =[NSCharacterSet decimalDigitCharacterSet];
    NSString *imgHeight = [originStr stringByTrimmingCharactersInSet:characterSet];
    return [imgHeight stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//#pragma mark - NSURLConnectionDelegate
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    CGSize size;
//    switch (type) {
//        case PngImage:
//        {
//             size = pngImageSizeWithHeaderData(data);
//        }
//            break;
//            
//        case JpgImage:
//        {
//             size = jpgImageSizeWithHeaderData(data);
//        }
//            break;
//            
//        case GifImage:
//        {
//             size = gifImageSizeWithHeaderData(data);
//        }
//            break;
//            
//        default:
//            break;
//    }
//    //计算喜欢数的大小
//    CGSize sizeLabel  =[_picModel.likes_count boundingRectWithSize:CGSizeMake(MAXFLOAT, PriceLabelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]} context:nil].size;
//    if (size.width&&size.height) {
//        _backIMGViewFrame =CGRectMake(0, 0, ItemWidth, size.height*(ItemWidth/size.width));
//            }else{
//          _backIMGViewFrame =CGRectMake(0, 0, ItemWidth,ItemWidth);
//            }
//    
//    _priceLabelFrame =CGRectMake(0, CGRectGetHeight(_backIMGViewFrame), 100, PriceLabelHeight);
//    _likeLabelFrame =CGRectMake(ItemWidth-10-sizeLabel.width, CGRectGetHeight(_backIMGViewFrame), sizeLabel.width, PriceLabelHeight);
//    _likeIMGViewFrame= CGRectMake(CGRectGetMinX(_likeLabelFrame)-15, CGRectGetHeight(_backIMGViewFrame)+CGRectGetHeight(_priceLabelFrame)/4, 15, 15);
//    _totalItemHeight =  CGRectGetMaxY(_priceLabelFrame);
//}




@end
