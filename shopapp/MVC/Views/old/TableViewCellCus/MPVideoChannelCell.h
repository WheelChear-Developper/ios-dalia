//
//  MPVideoChannelCell.h
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPVideoObject.h"

@interface MPVideoChannelCell : UITableViewCell
{
     IBOutlet UIImageView *myImageView;
     IBOutlet UILabel *titleLabel;
     IBOutlet UILabel *detailLabel;
     IBOutlet UILabel *timeLabel;
}

- (void)setData:(MPVideoObject*)object;

@end
