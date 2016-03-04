//
//  RVProductCell.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/15.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVProductCell.h"

@implementation RVProductCell

@synthesize titleLabel = _titleLabel;
@synthesize reviewLabel = _reviewLabel;
@synthesize reviewStarImageView = _reviewStarImageView;
@synthesize productImageView = _productImageView;
@synthesize url = _url;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    // 親クラスの初期化メソッドを呼び出す
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }

    // titleラベルの作成
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    
    // reviewラベルの作成
    _reviewLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _reviewLabel.font = [UIFont systemFontOfSize:12.0f];
    _reviewLabel.textColor = [UIColor grayColor];
    _reviewLabel.highlightedTextColor = [UIColor whiteColor];
    [self.contentView addSubview:_reviewLabel];
    
    // UIImageViewの作成
    UIImage*    image;
    image = [UIImage imageNamed:@"loading_throbber.png"];
    //NSURL *url = [NSURL URLWithString:@"imageURL"];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    //UIImage *image = [UIImage imageWithData:data];
    _productImageView = [[UIImageView alloc] initWithImage:image];
    //_productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    //_productImageView.tag = 10;
    //NSLog(@"_productImageView path %p", &_productImageView);
    [self.contentView addSubview:_productImageView];
    
    //評価スター
    UIImage *star = [UIImage imageNamed:@"ico_grade6_0.gif"];
    _reviewStarImageView = [[UIImageView alloc] initWithImage:star];
    [self.contentView addSubview:_reviewStarImageView];
    // 数字のためのラベルの作成
    /*_numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _numberLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.backgroundColor = [UIColor clearColor];
    _numberLabel.textAlignment = UITextAlignmentCenter;
    [self.contentView addSubview:_numberLabel];
    */
    return self;
}

- (void)setCellDataFromItem:(RVItem *)item{
    _titleLabel.text = item.title;
    _reviewLabel.text = [NSString stringWithFormat:@"%@",item.reviewAverage];
    _url = item.itemUrl;
    //NSLog(@"_productImageView path %p", &_productImageView);

    float reviewValue = [item.reviewAverage floatValue];
    //NSLog(@"review %f", reviewValue);

    if (reviewValue ==  0.0f) {
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_0.gif"];
    }else if( 0.0f < reviewValue && reviewValue <= 0.5f){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_h.gif"];
    }else if((float) 0.5 < reviewValue  && reviewValue <= (float) 1.0){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_1.gif"];
    }else if((float) 1.0 < reviewValue  && reviewValue <= (float) 1.5){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_1h.gif"];
    }else if((float) 1.5 < reviewValue  && reviewValue <= (float) 2.0){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_2.gif"];
    }else if((float) 2.0 < reviewValue  && reviewValue <= (float) 2.5){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_2h.gif"];
    }else if((float) 2.5 < reviewValue  && reviewValue <= (float) 3.0){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_3.gif"];
    }else if((float) 3.0 < reviewValue  && reviewValue <= (float) 3.5){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_3h.gif"];
    }else if((float) 3.5 < reviewValue  && reviewValue <= (float) 4.0){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_4.gif"];
    }else if(4.0f < reviewValue  && reviewValue <= 4.5f){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_4h.gif"];
    }else if(4.5f < reviewValue  && reviewValue <= 5.0f){
        _reviewStarImageView.image = [UIImage imageNamed:@"ico_grade6_5.gif"];
    }
    
    RVGetImage *rvgetimage = [[RVGetImage alloc]init];
    rvgetimage.delegate = self;
    [rvgetimage getUIImageFromUrlLWithString:item.itemImageUrl];
}

- (void)didCompleteGetImage:(UIImage *) image{
    NSLog(@"didCompleteGetImage");
    _productImageView.image = image;

}

- (void)layoutSubviews
{
    CGRect  rect;
    
    // 親クラスのメソッドを呼び出す
    [super layoutSubviews];
    
    // contentViewの大きさを取得する
    CGRect  bounds;
    bounds = self.contentView.bounds;
    
    // productImageViewのレイアウト
    rect.origin = CGPointZero;
    rect.size = _productImageView.frame.size;
    rect.size = CGSizeMake(70,70);
    _productImageView.frame = rect;
    
    // numberLabelのレイアウト
   /* rect = _numberBackgroundImageView.frame;
    _numberLabel.frame = rect;
   */ 
    // titleLabelのレイアウト
    rect.origin.x = CGRectGetMaxX(_productImageView.frame) + 4.0f;
    //rect.origin.x = 70.0f;
    rect.origin.y = CGRectGetMinY(bounds) + 4.0f;
    rect.size.width = CGRectGetWidth(bounds) - CGRectGetMinX(rect);
    rect.size.height = 22.0f;
    _titleLabel.frame = rect;
    
    // reviewLabelのレイアウト
    rect.origin.x = CGRectGetMinX(_titleLabel.frame);
    rect.origin.y = CGRectGetMaxY(_titleLabel.frame);
    rect.size.width = CGRectGetWidth(_titleLabel.frame)/3;
    rect.size.height = 20.0f;
    _reviewLabel.frame = rect;
    
    // reviewStarのレイアウト
    rect.origin.x = CGRectGetMaxX(_reviewLabel.frame) + 4.0f;
    rect.origin.y = CGRectGetMaxY(_titleLabel.frame);
    rect.size.width = CGRectGetWidth(_titleLabel.frame)/3;
    rect.size.height = 20.0f;
    _reviewStarImageView.frame = rect;

}


-(void)updateProductImageView:(UIImage *)image
{
            NSLog(@"現在の処理：updateProductImageView");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // メインスレッドで処理をしたい内容、UIを変更など。
      //  _productImageView = [[UIImageView alloc] initWithImage:image];
      //  UIImageView *uiImageView = (UIImageView*)[self.contentView viewWithTag:10];
       
       self->_productImageView.image = image;
    });
    //NSLog(@"thmbnail_url: %@", imageURL);
}


@end
