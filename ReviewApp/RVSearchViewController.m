//
//  RVSearchViewController.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/01/26.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVSearchViewController.h"

@interface RVSearchViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong) NSArray *dataSourceSearch;

@end

@implementation RVSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // デリゲートメソッドをこのクラスで実装する(ちょっと何言ってるかわかんないです)
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSourceSearch = @[@"ジャンル",@"価格帯",@"除外キーワード"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            dataCount = self.dataSourceSearch.count;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.dataSourceSearch[indexPath.row];
            break;
        //case 1:
        //    cell.textLabel.text = self.dataSourceAndroid[indexPath.row];
        //    break;
        default:
            break;
    }
    
    return cell;
}


@end
