//
//  RVChannel.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/07.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVChannel.h"

@implementation RVChannel

// プロパティ
@synthesize identifier = _identifier;
@synthesize apiUrlString = _apiUrlString;
@synthesize connectionUrlString = _connectionUrlString;
@synthesize title = _title;
@synthesize link = _link;
@synthesize items = _items;

@synthesize request = _request;

//--------------------------------------------------------------//
#pragma mark -- 初期化 --
//--------------------------------------------------------------//

- (id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // 識別子を作成する
    CFUUIDRef   uuid;
    uuid = CFUUIDCreate(NULL);
    _identifier = (NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
    CFRelease(uuid);
    
    _items = [NSMutableArray array];
    
    return self;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // インスタンス変数をデコードする
    _identifier = [decoder decodeObjectForKey:@"identifier"];
    _apiUrlString = [decoder decodeObjectForKey:@"apiUrlString"];
    _title = [decoder decodeObjectForKey:@"title"];
    _link = [decoder decodeObjectForKey:@"link"];
    _items = [decoder decodeObjectForKey:@"items"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    // インスタンス変数をエンコードする
    [encoder encodeObject:_identifier forKey:@"identifier"];
    [encoder encodeObject:_apiUrlString forKey:@"apiUrlString"];
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_link forKey:@"link"];
    [encoder encodeObject:_items forKey:@"items"];
}

- (void)session
{
    //NSURLConnectionと同様の通信を行うためのデフォルト設定（後で調べてください）
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:self
                                                     delegateQueue:nil];
    
    NSURLSessionDataTask* task =
    [session dataTaskWithURL:[NSURL URLWithString:self.connectionUrlString]
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
               if(error != nil){
                   NSLog(@"error: %@",error);
                   return;
               }
               if ([self.delegate respondsToSelector:@selector(didCompleteSession:)]) {
                   [self.delegate didCompleteSession:data];
               }
              // NSString *str= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              // NSLog(@"data %@", str);
               
           }];
    
    [task resume];
}

@end
