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
    __weak IBOutlet UIImageView *img_Photo;
    __weak IBOutlet UILabel *dateNewLabel;
    __weak IBOutlet UIImageView *newIcon;
    __weak IBOutlet UILabel *titleNewLabel;
    __weak IBOutlet UILabel *lbl_Message;
    __weak IBOutlet UITextView *txt_Message;
}
- (void)setData:(MPMenuNewsObject*)object;

@end
