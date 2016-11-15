//
//  MPMenuNewsCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenuNewsObject.h"

@interface MPMenuNewsCell : UITableViewCell
{
    __weak IBOutlet UIImageView *_img_Photo;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_lbl_Message;
    __weak IBOutlet UILabel *_dateNewLabel;

    __weak IBOutlet UIImageView *newIcon;
}
- (void)setData:(MPMenuNewsObject*)object;

@end
