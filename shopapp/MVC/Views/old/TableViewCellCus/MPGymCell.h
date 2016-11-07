//
//  MPGymCell.h
//  Misepuri
//
//  Created by TUYENBQ on 12/13/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGymObject.h"

@interface MPGymCell : UITableViewCell
{
    IBOutlet UILabel *bodyLabel;
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *dateLabel;
}
- (void) setData: (MPGymObject*) object;

@end
