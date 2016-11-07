//
//  MPShopDetaillView.h
//  Misepuri
//
//  Created by TUYENBQ on 3/6/14.
//  Copyright (c) 2014 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPShopDetaillView : UIView
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *contentLabel;
    IBOutlet UIView *lineView;
}
- (void) setData: (NSString*) title content: (NSString*) content;
+ (CGFloat) heightForRow: (NSString*) content;

@end
