//
//  TextFieldCell.h
//  ReviewApp
//
//  Created by 岡野由尚 on 2016/03/06.
//  Copyright © 2016年 KS-N414-ONB. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TextFieldCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UITextField *textField;

+ (id)loadFromNib;
@end