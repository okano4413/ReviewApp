//
//  RVChannelManager.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/08.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVChannelManager.h"

@implementation RVChannelManager

// プロパティ
@synthesize channels = _channels;
@synthesize rakutenChannel = _rakutenChannel;

//--------------------------------------------------------------//
#pragma mark -- 初期化 --
//--------------------------------------------------------------//

static RVChannelManager*  _sharedInstance = nil;

+ (RVChannelManager*)sharedManager
{
    // インスタンスを作成する
    if (!_sharedInstance) {
        _sharedInstance = [[RVChannelManager alloc] init];
    }
    
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // _channelsを初期化する
    _channels = [NSMutableArray array];
    
    return self;
}

/*- (void)dealloc
{
    // インスタンス変数を解放する
    [_channels release], _channels = nil;
    
    // 親クラスのdeallocを呼び出す
    [super dealloc];
}
*/
//--------------------------------------------------------------//
#pragma mark -- チャンネルの操作 --
//--------------------------------------------------------------//

/*- (void)addChannel:(RSSChannel*)channel
{
    // 引数を確認する
    if (!channel) {
        return;
    }
    
    // チャンネルを追加する
    [_channels addObject:channel];
}

- (void)insertChannel:(RSSChannel*)channel atIndex:(unsigned int)index
{
    // 引数を確認する
    if (!channel) {
        return;
    }
    if (index < 0 || index > [_channels count]) {
        return;
    }
    
    // チャンネルを挿入する
    [_channels insertObject:channel atIndex:index];
}

- (void)removeChannelAtIndex:(unsigned int)index
{
    // 引数を確認する
    if (index < 0 || index > [_channels count] - 1) {
        return;
    }
    
    // チャンネルを削除する
    [_channels removeObjectAtIndex:index];
}

- (void)moveChannelAtIndex:(unsigned int)fromIndex toIndex:(unsigned int)toIndex
{
    // 引数を確認する
    if (fromIndex < 0 || fromIndex > [_channels count] - 1) {
        return;
    }
    if (toIndex < 0 || toIndex > [_channels count]) {
        return;
    }
    
    // チャンネルを移動する
    RSSChannel* channel;
    channel = [_channels objectAtIndex:fromIndex];
    [channel retain];
    [_channels removeObject:channel];
    [_channels insertObject:channel atIndex:toIndex];
    [channel release];
}
 */

//--------------------------------------------------------------//
#pragma mark -- 永続化 --
//--------------------------------------------------------------//

- (NSString*)_channelDir
{
    // ドキュメントパスを取得する
    NSArray*    paths;
    NSString*   path;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] < 1) {
        return nil;
    }
    path = [paths objectAtIndex:0];
    
    // .channelディレクトリを作成する
    path = [path stringByAppendingPathComponent:@".channel"];
    return path;
}

- (NSString*)_channelPath
{
    // channel.datパスを作成する
    NSString*   path;
    path = [[self _channelDir] stringByAppendingPathComponent:@"channel.dat"];
    return path;
}

- (void)load
{
    // ファイルパスを取得する
    NSString*   channelPath;
    channelPath = [self _channelPath];
    if (!channelPath || ![[NSFileManager defaultManager] fileExistsAtPath:channelPath]) {
        return;
    }
    
    // チャンネルの配列を読み込む
    NSArray*    channels;
    channels = [NSKeyedUnarchiver unarchiveObjectWithFile:channelPath];
    if (!channels) {
        return;
    }
    
    // チャンネルの配列を設定する
    [_channels setArray:channels];
}

- (void)save
{
    // ファイルマネージャを取得する
    NSFileManager*  fileMgr;
    fileMgr = [NSFileManager defaultManager];
    
    // .channelディレクトリを作成する
    NSString*   channelDir;
    channelDir = [self _channelDir];
    if (![fileMgr fileExistsAtPath:channelDir]) {
        NSError*    error;
        [fileMgr createDirectoryAtPath:channelDir
           withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    // チャンネルの配列を保存する
    NSString*   channelPath;
    channelPath = [self _channelPath];
    [NSKeyedArchiver archiveRootObject:_channels toFile:channelPath];
}

-(void)searchChannel:(NSString *)channel keyword:(NSString *)keyword booksGenreId:(NSInteger *)booksGenreId
{
    //channelに応じて実行するsessionを変更する（未実装）
    [self doRakutenSession:keyword booksGenreId:booksGenreId];
    
}

-(void)doRakutenSession:(NSString *)keyword booksGenreId:(NSInteger *)booksGanreId
{
    self.rakutenChannel = [[RVRakutenChannel alloc] init];
    self.rakutenChannel.delegate = self;
    
    [self.rakutenChannel session:keyword booksGenreId:booksGanreId];
    
}

-(void)didCompleteSession:(NSData *)data
{
    [_channels addObject:[self.rakutenChannel setItemsFromJsonData:data]];
    [self save];
    
    if ([self.delegate respondsToSelector:@selector(updateView)]) {
        [self.delegate updateView];
    }

    
}

@end

