//
//  RVChannel.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/07.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RVItem.h"

@protocol RVChannelDelegate <NSObject>

@optional
//各チャンネルで通信が完了した時に呼び出される
-(void)didCompleteSession:(NSData *)data;

@end

@interface RVChannel : NSObject <NSCoding,NSURLSessionDelegate>
{
    NSString*       _identifier;    // 識別子
    NSString*       _apiUrlString;  // apiURL(各サブクラスのベースURL)
    NSString*       _connectionUrlStrings; //sessionで利用するURL
    NSString*       _title;         // タイトル
    NSString*       _link;          // リンク
    
    NSMutableArray* _items;         // アイテムの配列
    
    NSURLRequest *request;          //リクエスト
}

// プロパティ
@property (nonatomic, readonly) NSString* identifier;
@property (nonatomic, retain) NSString* apiUrlString;
@property (nonatomic, retain) NSString* connectionUrlString;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* link;
@property (nonatomic, readonly) NSMutableArray* items;

@property(weak,nonatomic) NSURLRequest *request;

@property(weak,nonatomic) id<RVChannelDelegate> delegate;

-(void)session;

@end
