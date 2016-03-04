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
    NSData *cacheImageData = [[RVImageCache sharedImageCache] load:url];
    if(cacheImageData != nil){
        NSLog(@"cachefile is exist");
        UIImage* cacheImage = [UIImage imageWithData:cacheImageData];

        if ([self.delegate respondsToSelector:@selector(didCompleteGetImage:)]) {
            [self.delegate didCompleteGetImage:cacheImage];
        }
    }else{
        NSLog(@"cachefile is not exist");
        //NSURL* url = [NSURL URLWithString:@"http://localhost/test.png"];
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
        
        NSURLSessionDataTask* task =
        [session dataTaskWithURL:[NSURL URLWithString:url]
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   NSLog(@"save thumbnail");
                   UIImage* image = [UIImage imageWithData:data];
                   // UIImageVIewを更新する
                   if ([self.delegate respondsToSelector:@selector(didCompleteGetImage:)]) {
                       [self.delegate didCompleteGetImage:image];
                   }
                   [[RVImageCache sharedImageCache]  save:url thumbnailImage:data];

               }];
        
        [task resume];
    }
}


//--------------------------------------------------------------//
#pragma mark -- 永続化 --
//--------------------------------------------------------------//

- (NSString*)_imagesDir
{
    // ドキュメントパスを取得する
    NSArray*    paths;
    NSString*   path;
    // paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([paths count] < 1) {
        return nil;
    }
    path = [paths objectAtIndex:0];
    
    // .imagesディレクトリを作成する
    path = [path stringByAppendingPathComponent:@".images"];
    return path;
}

- (NSString*)_thumbnailPath:(NSString *)thumbnailUrl
{
    // thumbnails.datパスを作成する
    NSString*   path;
    path = [[self _imagesDir] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", thumbnailUrl, @".dat"]];
    return path;
}

/*- (void)load
{
    // ファイルパスを取得する
    NSString*   thumbnailPath;
    thumbnailPath = [self _thumbnailPath];
    if (!thumbnailPath || ![[NSFileManager defaultManager] fileExistsAtPath:thumbnailPath]) {
        return;
    }
    
    // thumbnailの配列を読み込む
    NSArray* thumbnails;
    thumbnails = [NSKeyedUnarchiver unarchiveObjectWithFile:thumbnailPath];
    if (!thumbnails) {
        return;
    }
    
    // チャンネルの配列を設定する
    [thumbnails setArray:channels];
}*/


/*- (void)save
{
    // ファイルマネージャを取得する
    NSFileManager*  fileMgr;
    fileMgr = [NSFileManager defaultManager];
    
    // .imagesディレクトリを作成する
    NSString*   imageDir;
    imageDir = [self _imagesDir];
    if (![fileMgr fileExistsAtPath:imageDir]) {
        NSError*    error;
        [fileMgr createDirectoryAtPath:imageDir
           withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    // thumbnailの配列を保存する
    NSString*  thumbnailPath;
    thumbnailPath = [self _thumbnailPath];
    [NSKeyedArchiver archiveRootObject:thumbnails toFile:thumbnailPath];
}*/


@end