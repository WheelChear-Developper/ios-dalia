//
//  MPSocialView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPCouponObject.h"

typedef NS_ENUM(NSInteger, SocialType) {
    SocialType_Facebook,
    SocialType_Twitter,
    // INSERT START 2015.01.16
    // INSERTED BY M.FUJII
    // ADD OPTION9 (LINE連携追加)
    SocialType_Line
    // INSERT END 2015.01.16
};

@protocol MPSocialViewDelegate<NSObject>
- (void) invokeSocial:(SocialType) type;
@end

@interface MPSocialView : UIView
{
    IBOutlet UILabel *couponNameLabel;
    IBOutlet UIView *socialView;
}
@property (nonatomic, assign) id<MPSocialViewDelegate> delegate;
- (void) setData: (MPCouponObject*) object;
+ (CGFloat) heightForHeader: (MPCouponObject*) object;
@property (strong, nonatomic) IBOutlet UIButton *shareLines;
@property (nonatomic) BOOL isShareLine;

@end
