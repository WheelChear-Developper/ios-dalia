//
//  MPConfirmView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/9/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCouponObject.h"
#import "ManagerDownload.h"

@protocol MPConfirmViewDelegate<NSObject>
- (void) getStamp: (UIButton*) tag;
- (void)setArertCurponNo:(NSString*)no;
@end

@interface MPConfirmView : UIView<UITextFieldDelegate,ManagerDownloadDelegate>
{
    IBOutlet UITextField *secureTextField;
    MPCouponObject *couponObject;
    long amount ;//amount of stamp
    IBOutlet UILabel *lbMesager;
}
-(void)setData:(MPCouponObject*) object;
-(void)setAmount:(NSInteger) amount;
@property (nonatomic,strong) UIButton *tagStamp;
@property (nonatomic, assign) id<MPConfirmViewDelegate> delegate;

@end
