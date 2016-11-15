//
//  MPMenuRecommendMenuCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenuRecommend_menuObject.h"

@interface MPMenuRecommendMenuCell : UITableViewCell
{
    __weak IBOutlet UIImageView *_img_Photo;
    __weak IBOutlet UILabel *_titleNewLabel;
    __weak IBOutlet UILabel *_lbl_Message;
    __weak IBOutlet UILabel *_dateNewLabel;
}
- (void)setData:(MPMenuRecommend_menuObject*)object;

@end
