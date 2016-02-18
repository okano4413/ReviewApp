//
//  RVItem.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/07.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//
#import "RVItem.h"

@implementation RVItem

// プロパティ
@synthesize identifier = _identifier;
@synthesize title = _title;
@synthesize author = _author;
@synthesize publisherName = _publisherName;
@synthesize itemUrl = _itemUrl;
@synthesize itemImageUrl = _itemImageUrl;
@synthesize price = _price;
@synthesize itemDescription = _itemDescription;
@synthesize pubDate = _pubDate;
@synthesize reviewAverage = _reviewAverage;
@synthesize reviewCount = _reviewCount;

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
    
    return self;
}
//オブジェクトのプロパティをデシリアライズする際に呼ばれる
- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // インスタンス変数をデコードする
    _identifier = [decoder decodeObjectForKey:@"identifier"];
    _title = [decoder decodeObjectForKey:@"title"];
    _author = [decoder decodeObjectForKey:@"author"];
    _publisherName = [decoder decodeObjectForKey:@"publisherName"];
    _itemUrl= [decoder decodeObjectForKey:@"itemUrl"];
    _price = [decoder decodeObjectForKey:@"price"];
    _itemDescription = [decoder decodeObjectForKey:@"itemDescription"];
    _pubDate = [decoder decodeObjectForKey:@"pubDate"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    // インスタンス変数をエンコードする
    [encoder encodeObject:_identifier forKey:@"identifier"];
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_author forKey:@"author"];
    [encoder encodeObject:_publisherName forKey:@"publisherName"];
    [encoder encodeObject:_itemUrl forKey:@"itemUrl"];
    [encoder encodeObject:_price forKey:@"price"];
    [encoder encodeObject:_itemDescription forKey:@"itemDescription"];
    [encoder encodeObject:_pubDate forKey:@"pubDate"];
}

//ARCにより明示的にdeallocを呼び出さなくても良くなった
/*
- (void)dealloc
{
    // インスタンス変数を解放する
    _identifier = nil;
    _title = nil;
    _itemUrl = nil;
    _itemDescription = nil;
    _pubDate = nil;
    
    // 親クラスのdeallocを呼び出す
    //[super dealloc];
}
*/
@end

