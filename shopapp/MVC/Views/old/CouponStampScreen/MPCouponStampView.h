//
//  MPCouponStampView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/9/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerDownload.h"
#import "MPConfirmView.h"

@protocol MPCouponStampViewDelegate<NSObject>
- (void)backToCouponTab;
- (void)getCurponButtonClicked:(long)No;
- (void)setUserIDColor:(NSString*)colorNo;
- (void)setArertCurpon:(NSString*)no;
- (void)arert_StampErr;
- (void)setInfomation:(NSString*)comment;
- (void)arert_AllStamp:(NSString*)strFromInt UUID:(NSString*)uuid;
- (void)setNotStampForm;
@end

@interface MPCouponStampView : UIView<ManagerDownloadDelegate, MPConfirmViewDelegate>
{
    IBOutlet UIView *stampView;
    
    MPCouponObject *couponObject;
    long stampCount;
    long numberStampSelected;
}
@property (nonatomic, assign) id<MPCouponStampViewDelegate> delegate;

-(void)setTotalStamp:(NSString*)uuid;

@end
