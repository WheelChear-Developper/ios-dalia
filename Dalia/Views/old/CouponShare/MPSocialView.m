//
//  MPSocialView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPSocialView.h"

@implementation MPSocialView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setData: (MPCouponObject*) object{
    
    [couponNameLabel setText:object.coupon_name];
    
    CGSize couponNameSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:280 value:object.coupon_name];
    CGRect couponNameFrame = couponNameLabel.frame;
    couponNameFrame.size.height = couponNameSize.height + 10;
    couponNameLabel.frame = couponNameFrame;
    
    CGRect socialViewFrame = socialView.frame;
    [socialView setBackgroundColor:[UIColor clearColor]];
    socialViewFrame.origin.y = couponNameFrame.origin.y + couponNameFrame.size.height + 10;
    // INSERT START 2015.01.16
    // INSERTED BY M.FUJII
    // ADD OPTION9 (LINE連携追加)
    [self.shareLines setHidden:![object.is_share_line boolValue]];
    // INSERT END 2015.01.16
    socialView.frame = socialViewFrame;
    socialView.frame = socialViewFrame;
}

+ (CGFloat) heightForHeader: (MPCouponObject*) object {
    
    CGSize couponNameSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:280 value:object.coupon_name];
    // REPLACE START 2015.01.16
    // REPLACED BY M.FUJII
    // ADD OPTION9 (LINE連携追加)
    //return (couponNameSize.height + 210);
    return (couponNameSize.height + 310);
    // REPLACE END 2015.01.16
}

- (IBAction)shareFacebookButtonClicked:(id)sender {
    
    /*
    if ([self.delegate respondsToSelector:@selector(invokeSocial:)]) {
        [self.delegate invokeSocial:SocialType_Facebook];
    }
     */
}

- (IBAction)shareTwitterButtonClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(invokeSocial:)]) {
        [self.delegate invokeSocial:SocialType_Twitter];
    }
}

// INSERT START 2015.01.16
// INSERTED BY M.FUJII
// ADD OPTION9 (LINE連携追加)
- (IBAction)shareLineButtonClicked:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(invokeSocial:)]) {
        [self.delegate invokeSocial:SocialType_Line];
    }
}

@end
