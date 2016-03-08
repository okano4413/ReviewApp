//
//  RVSearchViewController.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/01/26.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVSearchViewController.h"
#import "RVEditNGWordViewController.h"

@interface RVSearchViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic,strong) NSArray *dataSourceSearch;
@property (weak, nonatomic) IBOutlet UIButton *SearchButton;

@end

@implementation RVSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITabBarController *tbc = self.tabBarController;
    UITabBarItem *tbi = [tbc.tabBar.items objectAtIndex:0];
    tbi.title = @"検索";
    tbi.image = [UIImage imageNamed:@"search.png"];
    
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataSourceSearch = @[@"ジャンル",@"価格帯",@"除外キーワード",@"検索履歴"];
    self.dataLabel = @[@"指定なし", @"本", @"CD", @"DVD", @"PCソフト・周辺機器", @"洋書", @"ゲーム", @"雑誌"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateVisibleCells];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.dataSourceSearch[indexPath.row];
            if(indexPath.row == 0){
                NSInteger userGenre = [[RVUserDefault sharedUserDefault] getIntValueForKey:@"INT_GENREID"];
                cell.detailTextLabel.text = self.dataLabel[userGenre];
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

//cellが選択された時に呼ばれる
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            [self performSegueWithIdentifier:@"GenreSelect" sender:self];
            NSLog(@"0 is selected");
            }
            break;
        case 2:{
            [self.navigationController pushViewController:[[RVEditNGWordViewController alloc] init] animated:YES];
            NSLog(@"2 is selected");
        }
        break;
        default:
            break;
    }
}

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            NSInteger userGenre = [[RVUserDefault sharedUserDefault] getIntValueForKey:@"INT_GENREID"];
            cell.detailTextLabel.text = self.dataLabel[userGenre];
            }
            break;
        case 2:{
            NSString *ngWord = [[RVUserDefault sharedUserDefault] getStringValueForKey:@"STR_NGWORD"];
            cell.detailTextLabel.text = ngWord;
        }
            break;
        default:
            break;
    }
    
}

// 画面上に見えているセルの表示更新
- (void)updateVisibleCells {
    NSLog(@"updateVisibleCells");
    for (UITableViewCell *cell in [self.tableView visibleCells]){
        [self updateCell:cell atIndexPath:[self.tableView indexPathForCell:cell]];
    }
}

//searchボタンが押された時によばれる
- (IBAction)Search:(id)sender {
    
    [self performSegueWithIdentifier:@"SearchResult" sender:self];
   
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"SearchResult"] ) {
        // UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        RVSearchResultController *searchResultController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
        searchResultController.keyword = self.searchBar.text;
        searchResultController.ngword = [[RVUserDefault sharedUserDefault] getStringValueForKey:@"STR_NGWORD"];
        searchResultController.genreId = [[RVUserDefault sharedUserDefault] getIntValueForKey:@"INT_GENREID"];
    }
}

@end
