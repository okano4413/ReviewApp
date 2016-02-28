//
//  RVUserDefault.h
//  ReviewApp
//
//  Created by okano on 2016/02/25.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVUserDefault : NSObject
{
    // NSUserDefaultsオブジェクト
    NSUserDefaults *def;
}

@property (nonatomic,weak) NSUserDefaults *def;

+ (RVUserDefault*)sharedUserDefault;

- (void)setIntValueForKey:(NSInteger)value forKey:(NSString *)key;
- (void)setStringValueForKey:(NSString *)value forKey:(NSString *)key;
- (NSInteger) getIntValueForKey:(NSString *)key;
- (NSString *) getStringValueForKey:(NSString *)key;
@end

