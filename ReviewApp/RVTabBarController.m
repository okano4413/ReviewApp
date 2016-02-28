//
//  RVTabBarController.m
//  ReviewApp
//
//  Created by okano on 2016/02/23.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVTabBarController.h"

@implementation RVTabBarController

- (id)init{
    self = [super init];
    if(self == nil){
        
        return nil;
    }
    UITabBarItem *tbi = [self.tabBarController.tabBar.items objectAtIndex:0];
    //tbi.image = [[UIImage imageNamed:@"tab_feed.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    NSLog(@"title %@",tbi.title );
    return self;
}

@end
