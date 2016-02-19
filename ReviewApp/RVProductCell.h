//
//  RVProductCell.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/15.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVChannelManager.h"

@interface RVProductCell : UITableViewCell<RVChannelManagerDelegate>
{
    UILabel*        _titleLabel;
    UILabel*        _reviewLabel;
    UIImageView*    _productImageView;
}

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UILabel* reviewLabel;
-(void)setProductImageView:(NSString *)imageURL;

@end
