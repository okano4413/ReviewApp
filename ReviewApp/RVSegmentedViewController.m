//
//  RVSegmentedViewController.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/01/25.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVSegmentedViewController.h"

@interface RVSegmentedViewController()
//SegmentedView用のプロパティ
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedViewControl;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIViewController *currentViewController;
//Search用のプロパティ
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *dataSourceSearchResults;
@property (weak, nonatomic) IBOutlet UIButton *SearchButton;

- (IBAction)segmentChange:(UISegmentedControl *)sender;
@end

@implementation RVSegmentedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITabBarController *tbc = self.tabBarController;
    UITabBarItem *tbi = [tbc.tabBar.items objectAtIndex:0];
    tbi.title = @"検索";
    tbi.image = [UIImage imageNamed:@"search.png"];
    // SegmentedControlの値により異なるControllerを取得する
    UIViewController *vc = [self viewControllerForSegmentIndex:self.segmentedViewControl.selectedSegmentIndex];
    // 取得したコントローラを子コントローラとして追加する
    [self addChildViewController:vc];
    
    // 子コントローラのViewを親コントローラのContent表示領域のサイズにする
    // スクロール対応していない場合などは画面から見切れる可能性があるので気をつけてください
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    self.currentViewController = vc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// SegmentedControlの値により異なるControllerを取得する
- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
            break;
        case 1:
            vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HistoryViewController"];
            break;
    }
    return vc;
}

// SegmentedControlの値を変更したときに呼ばれる
- (IBAction)segmentChange:(UISegmentedControl *)sender
{
    NSLog(@"clicked %ld", sender.selectedSegmentIndex);
    // SegmentedControlの値により異なるControllerを取得する
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    // 取得したコントローラを子コントローラとして追加する
    [self addChildViewController:vc];
    // ビューを変更する
    [self transitionFromViewController:self.currentViewController toViewController:vc duration:0.5
                               options:UIViewAnimationOptionTransitionCurlUp  // 変更するアニメーションを指定
                            animations:^{
                                [self.currentViewController.view removeFromSuperview];
                                vc.view.frame = self.contentView.bounds;
                                [self.contentView addSubview:vc.view];
                            } completion:^(BOOL finished) {
                                [vc didMoveToParentViewController:self];
                                [self.currentViewController removeFromParentViewController];
                                self.currentViewController = vc;
                            }];
}
//searchボタンが押された時によばれる
-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    [self performSegueWithIdentifier:@"SearchResult" sender:self.currentViewController];

}
- (IBAction)Search:(id)sender {
    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SegmentedViewController"];
    [self performSegueWithIdentifier:@"SearchResult" sender:self.currentViewController];
    [self presentViewController:self.currentViewController animated:YES completion:nil];
   // [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"SearchResult"] ) {
       // UINavigationController *navController = (UINavigationController*)[segue destinationViewController];
        RVSearchResultController *searchResultController = [segue destinationViewController];
        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
       // NSLog(@"searchbar: %@", self.searchBar.text);
        searchResultController.keyword = self.searchBar.text;
    }
}
@end
