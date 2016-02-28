//
//  RVUserDefault.m
//  ReviewApp
//
//  Created by okano on 2016/02/25.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "RVUserDefault.h"

@implementation RVUserDefault

@synthesize def = _def;

static RVUserDefault*  _sharedInstance = nil;

- (id)init{
    self = [super init];
    if(self == nil){
        return nil;
    }
    
    [self doReady];
    return self;
}

+ (RVUserDefault*)sharedUserDefault{
    // インスタンスを作成する
    if (!_sharedInstance) {
        _sharedInstance = [[RVUserDefault alloc] init];
    }
    
    return _sharedInstance;
}

// 準備処理
- (void)doReady {
    
    // NSUserDefaultsオブジェクト生成
    _def = [NSUserDefaults standardUserDefaults];
    
    // 初期値の設定
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"0" forKey:@"INT_GENREID"];
    [_def registerDefaults:dic];
    
}

- (void)setIntValueForKey:(NSInteger)value forKey:(NSString *)key{
    [self.def setInteger:value forKey:key];
   
}

- (void)setStringValueForKey:(NSString *)value forKey:(NSString *)key{
    [self.def setObject:value forKey:key];
    
}

- (NSInteger) getIntValueForKey:(NSString *)key{
    return [self.def integerForKey:key];
    
}

- (NSString *) getStringValueForKey:(NSString *)key{
    return [self.def stringForKey:key];
    
}

@end
