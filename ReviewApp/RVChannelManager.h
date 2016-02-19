//
//  RVChannelManager.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/08.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVChannel.h"
#import "RVRakutenChannel.h"

@class RVRakutenChannel;

@protocol RVChannelManagerDelegate <NSObject>

@optional
-(void)updateView;
-(void)updateProductImageView:(UIImage *)image;

@end

@interface RVChannelManager : NSObject<RVChannelDelegate>
{
    NSMutableArray* _channels;  // チャンネルの配列
}

// プロパティ
@property (nonatomic, readonly) NSArray* channels;
@property (nonatomic, strong) RVRakutenChannel* rakutenChannel;

@property(weak,nonatomic) id<RVChannelManagerDelegate> delegate;
// 初期化
+ (RVChannelManager*)sharedManager;

// チャンネルの操作
//- (void)addChannel:(RSSChannel*)channel;
//- (void)insertChannel:(RSSChannel*)channel atIndex:(unsigned int)index;
//- (void)removeChannelAtIndex:(unsigned int)index;
//- (void)moveChannelAtIndex:(unsigned int)fromIndex toIndex:(unsigned int)toIndex;

// 永続化
- (void)load;
- (void)save;

-(void)searchChannel:(NSString *)channel keyword:(NSString *)keyword booksGenreId:(NSInteger *)booksGenreId;
-(void)getImageFromUrlWithString:(NSString *) url;

@end
