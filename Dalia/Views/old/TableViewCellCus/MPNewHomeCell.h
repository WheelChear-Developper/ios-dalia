//
//  MPNewHomeCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPNewHomeObject.h"

@interface MPNewHomeCell : UITableViewCell
{
    __weak IBOutlet UIImageView *img_Photo;
    __weak IBOutlet UILabel *dateNewLabel;
    __weak IBOutlet UIImageView *newIcon;
    __weak IBOutlet UILabel *titleNewLabel;
    __weak IBOutlet UILabel *lbl_Message;
    // REPLACED BY ama 2016.10.04 START
    //文字位置調整
    __weak IBOutlet UITextView *txt_Message;
    // REPLACED BY ama 2016.10.04 END
}

- (void) setData: (MPNewHomeObject*) object;

@end
