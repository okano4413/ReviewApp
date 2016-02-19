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
    //UIImage*    image;
    //mage = [UIImage imageNamed:@"numberBackground.png"];
    //NSURL *url = [NSURL URLWithString:@"imageURL"];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    //UIImage *image = [UIImage imageWithData:data];
    //_productImageView = [[UIImageView alloc] initWithImage:image];
    _productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_productImageView];
    
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

-(void)setProductImageView:(NSString *)imageURL
{
    [self getThumbnailImageFromUrlWithString:imageURL];
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
    _productImageView.frame = rect;
    
    // numberLabelのレイアウト
   /* rect = _numberBackgroundImageView.frame;
    _numberLabel.frame = rect;
   */ 
    // titleLabelのレイアウト
    rect.origin.x = CGRectGetMaxX(_productImageView.frame) + 4.0f;
    rect.origin.y = CGRectGetMinY(bounds) + 4.0f;
    rect.size.width = CGRectGetWidth(bounds) - CGRectGetMinX(rect);
    rect.size.height = 22.0f;
    _titleLabel.frame = rect;
    
    // reviewLabelのレイアウト
    rect.origin.x = CGRectGetMinX(_titleLabel.frame);
    rect.origin.y = CGRectGetMaxY(_titleLabel.frame);
    rect.size.width = CGRectGetWidth(_titleLabel.frame);
    rect.size.height = 14.0f;
    _reviewLabel.frame = rect;
}

-(void)getThumbnailImageFromUrlWithString:(NSString *)url
{
    RVChannelManager *channelManager = [RVChannelManager sharedManager];
    channelManager.delegate = self;
    
    [channelManager getImageFromUrlWithString:url];
}

-(void)updateProductImageView:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // メインスレッドで処理をしたい内容、UIを変更など。
        _productImageView = [[UIImageView alloc] initWithImage:image];
        [self.contentView addSubview:_productImageView];
    });
    //NSLog(@"thmbnail_url: %@", imageURL);
}


@end
