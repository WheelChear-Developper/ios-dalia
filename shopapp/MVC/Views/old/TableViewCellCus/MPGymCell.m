//
//  MPGymCell.m
//  Misepuri
//
//  Created by TUYENBQ on 12/13/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPGymCell.h"

@implementation MPGymCell

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

- (void)setData:(MPGymObject*)object {
    
    [dateLabel setText:[object.gym_date stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [weightLabel setText:[NSString stringWithFormat:@"月日 %@kg",object.gym_weight]];
    [bodyLabel setText:[NSString stringWithFormat:@"/ B %@cm W %@cm H %@cm",object.gym_check1,object.gym_check2,object.gym_check3]];
}

@end
