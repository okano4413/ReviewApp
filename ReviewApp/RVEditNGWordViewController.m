//
//  RVEditNGWordViewController.m
//  ReviewApp
//
//  Created by 岡野由尚 on 2016/03/06.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVEditNGWordViewController.h"

@implementation RVEditNGWordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.tableView.contentSize = CGSizeMake(self.tableView.), <#CGFloat height#>)();
    //NSLog(@"Height %f",self.tableView.);
    // デリゲートメソッドをこのクラスで実装する
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    TextFieldCell* cell = [[self.tableView visibleCells] objectAtIndex:0];
    NSString *ngword = cell.textField.text;
    [[RVUserDefault sharedUserDefault] setStringValueForKey:ngword forKey:@"STR_NGWORD"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TextFieldCell";
    // 再利用できるセルがあれば再利用する
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
       // cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleValue1
       //                               reuseIdentifier:CellIdentifier];
        cell = [TextFieldCell loadFromNib];
    }
    
    return cell;
}




@end