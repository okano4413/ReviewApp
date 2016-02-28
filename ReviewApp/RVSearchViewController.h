//
//  RVSearchViewController.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/01/26.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVSearchResultController.h"
#import "RVUserDefault.h"
#import "RVGenreTableController.h"

@interface RVSearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>
    @property (nonatomic,strong) NSArray *dataLabel;
@end
