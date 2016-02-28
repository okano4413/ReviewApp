//
//  RVProductCell.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/15.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "RVItem.h"
#import "RVGetImage.h"

@interface RVProductCell : UITableViewCell<RVGetImageDelegate>
{
    UILabel*        _titleLabel;
    UILabel*        _reviewLabel;
    UIImageView*    _reviewStarImageView;
    UIImageView*    _productImageView;
}

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UILabel* reviewLabel;
@property (nonatomic, retain) UIImageView *reviewStarImageView;
@property (nonatomic, retain) UIImageView *productImageView;

- (void)setCellDataFromItem:(RVItem *) item;
@end
