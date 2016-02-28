//
//  RVGetImage.h
//  ReviewApp
//
//  Created by okano on 2016/02/22.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RVGetImageDelegate <NSObject>

@optional
- (void) didCompleteGetImage:(UIImage *) image;

@end

@interface RVGetImage : NSObject
{
    NSString *_url;
}

@property(weak,nonatomic) id<RVGetImageDelegate> delegate;

- (void) getUIImageFromUrlLWithString:(NSString *) url;

@end