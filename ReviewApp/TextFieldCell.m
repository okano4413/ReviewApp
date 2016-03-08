//
//  TextFieldCell.m
//  ReviewApp
//
//  Created by 岡野由尚 on 2016/03/06.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

@synthesize textField = _textField;

- (void)awakeFromNib {
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.placeholder = @"NG Word";
}

+ (id)loadFromNib
{
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
}
@end