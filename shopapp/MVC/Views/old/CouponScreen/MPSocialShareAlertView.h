//
//  MPSocialShareAlertView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPSocialView.h"
#import "ManagerDownload.h"
#import "UIAlertView+Blocks.h"

@protocol MPSocialShareAlertViewDelegate<NSObject>
- (void) showViewTwitter: (NSString*) share_content;
- (void) shareWithFaceBookDone;
- (void) shareWithLinekDone;

@end

@interface MPSocialShareAlertView : UIView<UITextViewDelegate,ManagerDownloadDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextView *shareContentTextView;
    IBOutlet UILabel *titleHeaderLabel;
    SocialType socialType;
    MPCouponObject *couponObject;
}

@property (nonatomic,assign) id<MPSocialShareAlertViewDelegate> delegate;
- (void)setData:(MPCouponObject*)object withType:(SocialType)type;

@end
