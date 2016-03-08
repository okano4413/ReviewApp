//
//  RVEditNGWordViewController.h
//  ReviewApp
//
//  Created by 岡野由尚 on 2016/03/06.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"
#import "RVUserDefault.h"

@interface RVEditNGWordViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
