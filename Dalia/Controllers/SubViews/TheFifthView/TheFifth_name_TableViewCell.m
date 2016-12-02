//
//  TheFifth_name_TableViewCell.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/30.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "TheFifth_name_TableViewCell.h"

@implementation TheFifth_name_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.txt_field1 setTintColor:[UIColor lightGrayColor]];
    [self.txt_field2 setTintColor:[UIColor lightGrayColor]];

    UIColor *color = [UIColor colorWithRed:124/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    if(self.txt_field1.placeholder != nil){
        self.txt_field1.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txt_field1.placeholder
                                                                                attributes:@{ NSForegroundColorAttributeName:color }];
    }
    if(self.txt_field2.placeholder != nil){
        self.txt_field2.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txt_field2.placeholder
                                                                                attributes:@{ NSForegroundColorAttributeName:color }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
