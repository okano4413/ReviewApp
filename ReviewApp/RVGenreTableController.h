//
//  RVGenreTableController.h
//  ReviewApp
//
//  Created by okano on 2016/02/23.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVUserDefault.h"

@interface RVGenreTableController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dataResource;
    NSArray *dataLabel;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *dataResource;
@property (nonatomic,strong) NSArray *dataLabel;

@end
