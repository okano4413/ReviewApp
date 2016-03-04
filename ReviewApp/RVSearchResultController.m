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
@synthesize genreId = _genreId;

@synthesize tableView = _tableView;
@synthesize rakuten = _rakuten;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.tableView.contentSize = CGSizeMake(self.tableView.), <#CGFloat height#>)();
    //NSLog(@"Height %f",self.tableView.);
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [RVChannelManager sharedManager].delegate = self;
    [[RVChannelManager sharedManager] searchChannel:@"rakuten" keyword:self.keyword booksGenreId:self.genreId];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateView{
    //NSLog(@"test");

    //[[RVChannelManager sharedManager] load];
    self.rakuten = [RVChannelManager sharedManager].channels[0];
   //RVItem *item = self.rakuten.items[0];
   // NSLog(@"rakuten %@", item.title);
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    dispatch_async(dispatch_get_main_queue(), ^{
        // メインスレッドで処理をしたい内容、UIを変更など。
        //NSLog(@"現在の処理：reloadData");
        //[self.tableView reloadData];
        [self updateVisibleCells];
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
            dataCount = 10;
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
  /*      switch (indexPath.section) {
            case 0:{
            //cell.titleLabel.text = self.rakuten.items[indexPath.row];
            cell.titleLabel.text = item.title;
            cell.reviewLabel.text = [NSString stringWithFormat:@"%@",item.reviewAverage];
                //NSLog(@"itemImageUrl %@", item.itemImageUrl);
            dispatch_async(queue, ^{
            [cell setProductImageView:@"http://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/9610/9784056109610.jpg?_ex=64x64"];
            });
            }
            break;
            //case 1:
            //    cell.textLabel.text = self.dataSourceAndroid[indexPath.row];
            //    break;
        default:
            break;
    }
   */ 
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
}

- (void)updateCell:(RVProductCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RVItem *item = self.rakuten.items[indexPath.row];
    //NSLog(@"indexpath.row %ld",(long)indexPath.row);
    [cell setCellDataFromItem:item];
    
}

// 画面上に見えているセルの表示更新
- (void)updateVisibleCells {
    for (RVProductCell *cell in [self.tableView visibleCells]){
        [self updateCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
    }
}

- (IBAction)cancel:(id)sender {
    
   /* dispatch_async(dispatch_get_main_queue(), ^{
        // メインスレッドで処理をしたい内容、UIを変更など。
        NSLog(@"現在の処理：reloadData");
        [self.tableView reloadData];
        
    });*/
    [[RVChannelManager sharedManager] removeChannelInfo:0];
    [self dismissViewControllerAnimated:YES completion:NULL];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RVProductCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *urlString = cell.url;
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
    
}

@end