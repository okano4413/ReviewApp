//
//  RVSearchResultController.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/15.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVChannelManager.h"
#import "RVRakutenChannel.h"
#import "RVItem.h"
#import "RVProductCell.h"


@interface RVSearchResultController : UIViewController<RVChannelManagerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSString *keyword;
}

@property (strong, nonatomic) NSString *keyword;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *dataSourceSearch;
@property (nonatomic,weak) RVRakutenChannel *rakuten;

@end