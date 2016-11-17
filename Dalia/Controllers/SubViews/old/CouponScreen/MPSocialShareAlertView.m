//
//  MPSocialShareAlertView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPSocialShareAlertView.h"

#define UP_TO_VIEW_4 CGRectMake(15,1,290,262)
#define UP_TO_VIEW_5 CGRectMake(15,80,290,262)
#define DOWN_TO_VIEW CGRectMake(15,138,290,262)

@implementation MPSocialShareAlertView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f]];
}

- (void)setData:(MPCouponObject *)object withType:(SocialType)type {
    
    socialType = type;
    couponObject = object;
    NSString *title = @"";
    switch (type) {
        case SocialType_Facebook:
            title = @"Facebookにシェア";
            break;
            
        case SocialType_Twitter:
            title = @"Twitterにシェア";
            break;
            
        case SocialType_Line:
            title = @"Lineにシェア";
            break;

        default:
            break;
    }
    
    [titleHeaderLabel setText:title];
//    [shareContentTextView setText:object.share_content];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [UIView animateWithDuration:0.5 animations:^{
        switch ([Utility deviceType]) {
            case DEVICE_TYPE_iPhone5Retina:
                [[self viewWithTag:1911] setFrame:UP_TO_VIEW_5];
                break;
                
            case DEVICE_TYPE_iPhone4Retina:
                [[self viewWithTag:1911] setFrame:UP_TO_VIEW_4];
                break;
                
            case DEVICE_TYPE_iPhone:
                [[self viewWithTag:1911] setFrame:UP_TO_VIEW_4];
                break;
                
            default:
                break;
        }
        
    }];
    return YES;
}

- (IBAction)shareButtonClicked:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1911] setFrame:DOWN_TO_VIEW];
    }];
    [self removeFromSuperview];
    
    switch (socialType) {
        case SocialType_Facebook:
        {
            /*
            [FBManager instance].delegate = self;
            [[FBManager instance] postStatusUpdateClick:shareContentTextView.text andWithObject:couponObject];
             */
        }
            
            break;
            
        case SocialType_Twitter:
        {
            if ([self.delegate respondsToSelector:@selector(showViewTwitter:)]) {
                [self.delegate showViewTwitter:shareContentTextView.text];
            }
        }
            break;
        // INSERT START 2015.01.16
        // INSERTED BY M.FUJII
        // ADD OPTION9 (LINE連携追加)
        case SocialType_Line:
        {
            //if ([self.delegate respondsToSelector:@selector(showViewLine:)]) {
            
            
            //                [self.delegate showViewLine:shareContentTextView.text];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"line://msg/text/%@",[shareContentTextView.text  stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]]];
            BOOL isShareLine =  [[UIApplication sharedApplication] openURL:url];
            if (!isShareLine) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:TITLE_MESSAGE_SHARE_LINE message:MESSAGE_SHARE_SOCIAL_LINE_ERROR delegate:nil cancelButtonTitle:@"キャンセル" otherButtonTitles:@"インストール", nil];
                [alertView show];
                
                
                [alertView showWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    
                    if (buttonIndex == [alertView cancelButtonIndex]) {
                        
                    } else {
//                        MPCouponShareViewController *share =[[MPCouponShareViewController alloc]init];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/jp/app/line/id443904275?ls=1&mt=8"]];
                        
                    }
                }];
                
            }else{
                if (self.delegate) {
                    if ([self.delegate respondsToSelector:@selector(shareWithLinekDone)]) {
                        [self.delegate shareWithLinekDone];
                    }
                }
            }
            //                NSString *stringURL = @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=294409923&mt=8";
            //                NSURL *url = [NSURL URLWithString:stringURL];
            //                [[UIApplication sharedApplication] openURL:url];
            // }
            
            
        }
            break;
        // INSERT END 2015.01.16
        default:
            break;
    }
}

#pragma mark - FaceBookDelegate

- (void)postStatusComplete:(NSError *)error {
    
//    // type = 2 with share thank coupon
//    couponObject.coupon_type = 2;
//    [[ManagerDownload sharedInstance] submitRegistCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponObject delegate:self];
    
    if ([self.delegate respondsToSelector:@selector(shareWithFaceBookDone)]) {
        [self.delegate shareWithFaceBookDone];
    }
}

- (void)getSuccessInfoUser:(NSDictionary *)info {
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (IBAction)cancelButtonClicked:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1911] setFrame:DOWN_TO_VIEW];
    }];
    [self removeFromSuperview];
}

@end
