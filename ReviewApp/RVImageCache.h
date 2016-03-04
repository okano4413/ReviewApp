//
//  RVImageCache.h
//  ReviewApp
//
//  Created by okano on 2016/02/29.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVImageCache : NSObject
{
    NSMutableDictionary *thumbnailCache;
}
@property (strong, nonatomic) NSMutableDictionary *thumbnailCache;


+ (RVImageCache*) sharedImageCache;

- (void)save:(NSString *) url thumbnailImage:(NSData *)thumbnailImage;
- (NSData *)load:(NSString *)url;


@end
