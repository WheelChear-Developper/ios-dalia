//
//  MPAlertView.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPAlertViewDelegate<NSObject>
- (void) detailCoupon;
@end

@interface MPAlertView : UIView
{
    IBOutlet UILabel *titleMessage;
}
@property (strong, nonatomic) IBOutlet UIButton *btnOK;
@property (nonatomic, assign) id<MPAlertViewDelegate> delegate;

- (void)setData:(long)number;

@end
