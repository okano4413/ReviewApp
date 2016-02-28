//
//  RVGetProductImage.h
//  ReviewApp
//
//  Created by okano on 2016/02/19.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RVGetProductImageDelegate <NSObject>

-(void)didCompleteGetUIImage:(UIImage *)image;

@end

@interface RVGetProductImage: NSObject <NSURLSessionDelegate>

@property(weak,nonatomic) id<RVGetProductImageDelegate> delegate;

-(void)getImageFromUrlWithString:(NSString *) url;

@end