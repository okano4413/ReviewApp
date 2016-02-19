//
//  RVRakutenChannel.m
//  ReviewApp
//
//  Created by KS-N414-ONB on 2016/02/08.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVRakutenChannel.h"

@implementation RVRakutenChannel

@synthesize keyword = _keyword;
@synthesize booksGenreId = _booksGanreId;

-(id)init
{
    
    self = [super init];
    if(self == nil){
        return nil;
    }
    //接続先APIURLを初期化する
    self.apiUrlString = @"https://app.rakuten.co.jp/services/api/BooksTotal/Search/20130522?format=json&applicationId=1003379390583072246";
    
    return self;
}

-(void)session:(NSString*)keyWord booksGenreId:(NSInteger *)genreId
{
    self.booksGenreId = [NSString stringWithFormat:@"%@%03zd",@"&booksGenreId=",genreId];
    if([keyWord length] != 0){
        self.keyword = [NSString stringWithFormat:@"%@%@",@"&keyword=",[keyWord stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]]];
        self.connectionUrlString = [NSString stringWithFormat:@"%@%@%@",self.apiUrlString, self.keyword, self.booksGenreId];
    }else{
        self.connectionUrlString = [NSString stringWithFormat:@"%@%@",self.apiUrlString, self.booksGenreId];
    }
    NSLog(@"connectionURLString= %@",self.connectionUrlString);
    
     
    [super session];
}

-(id)setItemsFromJsonData:(NSData *)data
{
    NSArray *array = [[NSJSONSerialization JSONObjectWithData:data
                                                      options:NSJSONReadingAllowFragments
                                                        error:nil] valueForKey:@"Items"];
  // NSLog(@"array= %@",[array[0] valueForKeyPath:@"Item"]);
    NSUInteger count = array.count;
    for(int i=0; i < count; i++){
        RVItem *item = [[RVItem alloc] init];
        item.title = [array[i] valueForKeyPath:@"Item.title"];
        item.author = [array[i] valueForKeyPath:@"Item.author"];
        item.publisherName = [array[i] valueForKeyPath:@"Item.publisherName"];
        item.itemUrl = [array[i] valueForKeyPath:@"Item.itemUrl"];
        item.itemImageUrl = [array[i] valueForKeyPath:@"Item.smallImageUrl"];
        item.itemDescription = [array[i] valueForKeyPath:@"Item.itemCaption"];
        item.pubDate = [array[i] valueForKeyPath:@"Item.salesDate"];
        item.reviewAverage = [array[i] valueForKeyPath:@"Item.reviewAverage"];
        item.reviewCount = [array[i] valueForKeyPath:@"Item.reviewCount"];
        //NSLog(@"smallImageUrl= %@",item.itemImageUrl);
        //NSLog(@"reviewaverage= %@",[array[i] valueForKeyPath:@"Item.reviewAverage"]);
        [self.items addObject:item];
    }
   // self.title =[array[0] valueForKeyPath:@"Item.title"];
   // NSLog(@"title= %@",self.title);
    return self;
    
}
@end
