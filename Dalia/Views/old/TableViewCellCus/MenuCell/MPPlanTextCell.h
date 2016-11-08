//
//  MPPlanTextCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MPItemObject.h"
@interface MPPlanTextCell : UITableViewCell
{
    
     IBOutlet UILabel *titleMenu;
     IBOutlet UILabel *contentMenu;
        
    MPItemObject *itemObject;
}

- (void) setData: (MPItemObject*) item;
+ (CGFloat) heightForRow: (MPItemObject*) object;
@end
