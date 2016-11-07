//
//  MPBlankCell.m
//  Misepuri
//
//  Created by TUYENBQ on 1/15/14.
//  Copyright (c) 2014 3SI-TUYENBQ. All rights reserved.
//

#import "MPBlankCell.h"

@implementation MPBlankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
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

@end
