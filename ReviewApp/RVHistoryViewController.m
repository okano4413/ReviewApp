//
//  RVHistoryViewController.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/01/26.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVHistoryViewController.h"


@interface RVHistoryViewController()
@property (weak, nonatomic) IBOutlet UILabel *Testlabel;
@property (strong, nonatomic) IBOutlet RVChannelManager *channelManager;

@end

@implementation RVHistoryViewController

@synthesize channelManager = _channelManager;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"didload historyView");
    [RVChannelManager sharedManager].delegate = self;
    [[RVChannelManager sharedManager] searchChannel:@"rakuten" keyword:@"%E6%9C%AC" booksGenreId:000];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateView {
    [[RVChannelManager sharedManager] load];
    RVRakutenChannel *rakuten = [RVChannelManager sharedManager].channels[0];
    NSLog(@"channel %@", rakuten.title);
    dispatch_async(dispatch_get_main_queue(), ^{
        // メインスレッドで処理をしたい内容、UIを変更など。
            self.Testlabel.text = rakuten.title;
    });

}

@end
