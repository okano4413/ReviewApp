//
//  RVGetProductImage.m
//  ReviewApp
//
//  Created by okano on 2016/02/19.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVGetProductImage.h"

@implementation RVGetProductImage

-(id)init
{
    self = [super init];
    if(self == nil){
        return nil;
    }
    return self;
}

-(void)getImageFromUrlWithString:(NSString *) url{
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:self
                                                     delegateQueue:nil];
    
    NSURLSessionDownloadTask* task =
    [session downloadTaskWithURL:[NSURL URLWithString:url]
           completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
               if(error != nil){
                   NSLog(@"error: %@",error);
                   return;
               }
               UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
               if ([self.delegate respondsToSelector:@selector(didCompleteGetUIImage:)]) {
                   [self.delegate didCompleteGetUIImage:image];
               }
               // NSString *str= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
               // NSLog(@"data %@", str);
               
           }];
    
    [task resume];

    
}
@end