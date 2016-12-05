//
//  MPFirstSetting_generation_TableViewCell.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/30.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPFirstSetting_generation_TableViewCell.h"

@implementation MPFirstSetting_generation_TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.txt_field setTintColor:UIColor.whiteColor];

    if(self.txt_field.placeholder != nil){
        UIColor *color = [UIColor colorWithRed:124/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
        self.txt_field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txt_field.placeholder
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];
    }

    self.txt_field.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
