//
//  RVGenreTableController.m
//  ReviewApp
//
//  Created by okano on 2016/02/23.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVGenreTableController.h"

@implementation RVGenreTableController

@synthesize dataLabel = _dataLabel;
@synthesize dataResource = _dataResource;

- (void)viewDidLoad {
    [super viewDidLoad];
    [RVUserDefault sharedUserDefault];
    
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _dataResource = @[@000, @001, @002, @003, @004, @005, @006, @007];
    _dataLabel = @[@"指定なし", @"本", @"CD", @"DVD", @"PCソフト・周辺機器", @"洋書", @"ゲーム", @"雑誌"];
    // Do any additional setup after loading the view, typically from a nib.
    
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
   // NSLog(@"datacount: %@", _dataLabel);
    switch (section) {
        case 0:
            dataCount = _dataLabel.count;
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
    NSInteger checkedRow = [[RVUserDefault sharedUserDefault] getIntValueForKey:@"INT_GENREID"];
    //0番目のcellにチェックをつける
    if(indexPath.row == checkedRow){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    }
    switch (indexPath.section) {
     case 0:{
         cell.textLabel.text = _dataLabel[indexPath.row];
     }
     break;
     //case 1:
     //    cell.textLabel.text = self.dataSourceAndroid[indexPath.row];
     //    break;
     default:
     break;
     }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [[RVUserDefault sharedUserDefault] setIntValueForKey:indexPath.row forKey:@"INT_GENREID"];

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
