//
//  RVItem.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/07.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVItem : NSObject <NSCoding>
{
    NSString*   _identifier;        // 識別子
    
    NSString*   _title;             // タイトル
    NSString*   _author;            // 著者
    NSString*   _publisherName;     // 出版社
    NSString*   _itemUrl;           // リンク
    NSString*   _itemImageUrl;      // サムネイルurl
    NSString*   _price;             // 値段
    NSString*   _itemDescription;   // 記事の記述
    NSString*   _pubDate;           // 発行された日付
    NSNumber  *_reviewAverage;     // review平均
    NSNumber  *_reviewCount;       // review数
}

// プロパティ
@property (nonatomic, readonly) NSString* identifier;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* author;
@property (nonatomic, retain) NSString* publisherName;
@property (nonatomic, retain) NSString* itemUrl;
@property (nonatomic, retain) NSString* itemImageUrl;
@property (nonatomic, retain) NSString* price;
@property (nonatomic, retain) NSString* itemDescription;
@property (nonatomic, retain) NSString* pubDate;
@property (nonatomic, retain) NSNumber* reviewAverage;
@property (nonatomic, retain) NSNumber* reviewCount;


@end