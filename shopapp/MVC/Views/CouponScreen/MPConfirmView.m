//
//  MPConfirmView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/9/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPConfirmView.h"

#define UP_TO_VIEW_4 CGRectMake(15,30,290,231)
#define UP_TO_VIEW_5 CGRectMake(15,110,290,231)
#define DOWN_TO_VIEW CGRectMake(15,158,290,231)

@implementation MPConfirmView

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

- (void)setData:(MPCouponObject *)object {
    
    couponObject = object;
}

-(void)setAmount:(NSInteger)amountStamp {
    
    if ([couponObject.is_limit_stamp isEqualToString:@"1"]) {
        amount = 1;
    }else{
        amount = amountStamp;
    }
    
    if ([couponObject.is_limit_stamp isEqualToString:@"1"]) {
        [lbMesager setText:@"認証番号は店内スタッフにお問い合わせください。"];
    }else{
        NSString*msg = [NSString stringWithFormat:@"スタンプ数は %ld 個です。認証番号を 入力してください",amount];
        [lbMesager setText:msg];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [textField setText:@""];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1911] setFrame:DOWN_TO_VIEW];
    }];
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)yesButtonClicked:(id)sender {
    
    NSString *strFromInt = [NSString stringWithFormat:@"%ld",amount];
    // REPLACED BY ama 2016.10.05 START
    // iBeacon識別追加
    [[ManagerDownload sharedInstance] submitStamp:[Utility getDeviceID] withAppID:[Utility getAppID] withCoupon:couponObject withCode:secureTextField.text withAmount:strFromInt withUUID:@"" withMajor:@"0" withMinor:@"0" delegate:self];
    // REPLACED BY ama 2016.10.05 END
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1911] setFrame:DOWN_TO_VIEW];
    }];
    [secureTextField resignFirstResponder];
    
}

- (IBAction)noButtonClicked:(id)sender {
    
    [UIView animateWithDuration:0.5 animations:^{
        [[self viewWithTag:1911] setFrame:DOWN_TO_VIEW];
    }];
    [secureTextField resignFirstResponder];
    [self removeFromSuperview];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    //TODO: Coupon Stamp is up to once a day
    if (param.result_code == 205) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"来店スタンプは1日１回迄です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self removeFromSuperview];
        return;
    }
    // REPLACED BY M.ama 2016.10.08 START
    // クーポン件数取得用更新
    if ([[[param.listData lastObject] objectForKey:@"message"] isEqualToString:@"OK"]) {
        [self removeFromSuperview];
        
        [self.delegate setArertCurponNo:[[param.listData lastObject] objectForKey:@"count"]];
        
        if ([self.delegate respondsToSelector:@selector(getStamp:)]) {
            [self.delegate getStamp:self.tagStamp];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"認証番号が正しくありません。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        [self removeFromSuperview];
    }
    // REPLACED BY M.ama 2016.10.08 START
}

- (void)downloadDataFail:(DownloadParam *)param {
    
    [self removeFromSuperview];
}

@end
