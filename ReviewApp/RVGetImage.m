//
//  RVGetImage.m
//  ReviewApp
//
//  Created by okano on 2016/02/22.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVGetImage.h"

@implementation RVGetImage


- (void)getUIImageFromUrlLWithString:(NSString *)url
{
    //NSURL* url = [NSURL URLWithString:@"http://localhost/test.png"];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* task =
    [session dataTaskWithURL:[NSURL URLWithString:url]
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               UIImage* image = [UIImage imageWithData:data];
               
               // UIImageVIewを更新する
               if ([self.delegate respondsToSelector:@selector(didCompleteGetImage:)]) {
                   [self.delegate didCompleteGetImage:image];
               }
           }];
    
    [task resume];
}

@end