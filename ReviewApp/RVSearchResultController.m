//
//  RVSearchResultController.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/15.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVSearchResultController.h"

@implementation RVSearchResultController

@synthesize keyword = _keyword;
@synthesize tableView = _tableView;
@synthesize rakuten = _rakuten;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [RVChannelManager sharedManager].delegate = self;
    [[RVChannelManager sharedManager] searchChannel:@"rakuten" keyword:self.keyword booksGenreId:000];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateView {
    //NSLog(@"test");

    [[RVChannelManager sharedManager] load];
    self.rakuten = [RVChannelManager sharedManager].channels[0];
   //RVItem *item = self.rakuten.items[0];
   // NSLog(@"rakuten %@", item.title);
    dispatch_async(dispatch_get_main_queue(), ^{
        // メインスレッドで処理をしたい内容、UIを変更など。
        [self.tableView reloadData];
      
    });
    
}

/**
 *  テーブルに表示するデータ件数を返します（実装必須）
 *
 *  @param tableView テーブルビュー
 *  @param section   対象セクション番号
 *
 *  @return データ件数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    
    switch (section) {
        case 0:
            //dataCount = self.dataSourceSearch.count;
            dataCount = 5;
            break;
            //case 1:
            //    dataCount = self.dataSourceAndroid.count;
            //    break;
        default:
            break;
    }
    return dataCount;
}

/**
 *  テーブルに表示するセクション（区切り）の件数を返します（任意実装）
 *
 *  @param  テーブルビュー
 *
 *  @return セクション件数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
/**
 *  テーブルに表示するセルを返します（実装必須）
 *
 *  @param tableView テーブルビュー
 *  @param indexPath セクション番号・行番号の組み合わせ
 *
 *  @return セル
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    RVProductCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[RVProductCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    RVItem *item = self.rakuten.items[indexPath.row];
    //NSLog(@"reviewaverage %f", item.reviewAverage);
    //NSLog(@"reviewaverage %@",[NSString stringWithFormat:@"%f",item.reviewAverage]);
        switch (indexPath.section) {
        case 0:
            //cell.titleLabel.text = self.rakuten.items[indexPath.row];
            cell.titleLabel.text = item.title;
            cell.reviewLabel.text = [NSString stringWithFormat:@"%f",item.reviewAverage];
            [cell setProductImageView:item.itemImageUrl];
            
            break;
            //case 1:
            //    cell.textLabel.text = self.dataSourceAndroid[indexPath.row];
            //    break;
        default:
            break;
    }
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    // View が別の View へ切り替わる直前に呼ばれる
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    NSLog(@"viewWillDisappear %@", topController);
}
- (void)viewDidDisappear:(BOOL)animated
{
    // View が別の View へ切り替わる直前に呼ばれる
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    NSLog(@"viewDidDisappear %@", topController);
}


@end