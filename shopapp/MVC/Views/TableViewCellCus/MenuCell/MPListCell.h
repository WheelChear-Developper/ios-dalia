//
//  MPListCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPItemObject.h"

@interface MPListCell : UITableViewCell
{
    
     IBOutlet UIImageView *imageButton;
     IBOutlet UILabel *titleLabel;
     IBOutlet UILabel *contentLabel;
    
     IBOutlet UILabel *priceLabel;
    
    MPItemObject *itemObject;
}

- (void) setData: (MPItemObject*) item;

@end
