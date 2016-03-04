//
//  RVImageCache.m
//  ReviewApp
//
//  Created by okano on 2016/02/29.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVImageCache.h"

@implementation RVImageCache

static RVImageCache*  _sharedInstance = nil;
@synthesize thumbnailCache = _thumbnailCache;

- (id) init {
    self = [super init];
    if(self == nil){
        return nil;
    }
    self.thumbnailCache = [NSMutableDictionary dictionary];
    return self;
    
}

+ (RVImageCache *)sharedImageCache
{
    // インスタンスを作成する
    if (!_sharedInstance) {
        _sharedInstance = [[RVImageCache alloc] init];
    }
    return _sharedInstance;
    
}

- (void)save:(NSString *) url thumbnailImage:(NSData *)thumbnailImage
{
       [_thumbnailCache setObject:thumbnailImage forKey:url];
}

- (NSData *)load:(NSString *)url
{
    NSData *thumbnail = [self.thumbnailCache objectForKey:url];
    if(!thumbnail) {
        return nil;
    }
    return thumbnail;
}

@end