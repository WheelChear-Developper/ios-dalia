//
//  MPCouponBirthdayCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponBirthdayCell.h"

@implementation MPCouponBirthdayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (IBAction)setBirthDayButtonClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(setBirthDay)]) {
        [self.delegate setBirthDay];
    }
}

@end
