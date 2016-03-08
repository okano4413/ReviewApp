//
//  RVRakutenChannel.h
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/08.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVChannel.h"

@interface RVRakutenChannel : RVChannel
{
    NSString *keyword;        //検索キーワード
    NSString *booksGenreId;   //ジャンルID
    NSString *ngword;         //NGWord
}

@property (nonatomic, weak) NSString* keyword;
@property (nonatomic, weak) NSString* booksGenreId;
@property (nonatomic, weak) NSString* ngword;

-(void)session:(NSString *)keyWord booksGenreId:(NSInteger)ganreId ngWord:(NSString *)ngWord;
-(id)setItemsFromJsonData:(NSData *)data;
@end