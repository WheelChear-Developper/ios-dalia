//
//  MPMenuGridCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPItemObject.h"

@protocol MPMenuGridCellDelegate<NSObject>
- (void) selectProduct: (MPItemObject*) item;
@end

@interface MPMenuGridCell : UITableViewCell
{
    MPItemObject *itemObject;
    NSArray *_listItem;
}
@property (nonatomic, assign) id <MPMenuGridCellDelegate> delegate;
- (void)setData:(NSArray*)listItem;
+ (CGFloat)heightForRow:(NSArray*)listItem;

@end
