//
//  FirstSettingViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPMemberObject.h"
#import "Configuration.h"

@protocol FirstSettingViewControllerDelegate<NSObject>
@end

@interface FirstSettingViewController : MPBaseViewController <UITextFieldDelegate, ManagerDownloadDelegate, UIScrollViewDelegate>
{    
    id<FirstSettingViewControllerDelegate> _FirstSettingViewControllerDelegate;
    
    long lng_sexflag;
    NSString* str_ID;
    MPMemberObject* memberObj;
    UIDatePicker *datePicker_Birthday;
    UIDatePicker *datePicker_ChildeBirthday1;
    UIDatePicker *datePicker_ChildeBirthday2;
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;
}
@property (nonatomic) id<FirstSettingViewControllerDelegate> FirstSettingViewControllerDelegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scr_view;

@property (weak, nonatomic) IBOutlet UITextField *txt_farstName;
@property (weak, nonatomic) IBOutlet UITextField *txt_lastName;
@property (weak, nonatomic) IBOutlet UITextField *txt_nickName;
@property (weak, nonatomic) IBOutlet UITextField *txt_birthday;
@property (weak, nonatomic) IBOutlet UITextField *txt_zipCode;
@property (weak, nonatomic) IBOutlet UITextField *txt_introductionCode;
@property (weak, nonatomic) IBOutlet UITextField *txt_machineChengeCode;

@property (nonatomic) UIAlertController *alertController;  //アラートコントローラー本体
@property (nonatomic) UILabel *chkLbl;  //ラベル

- (IBAction)btn_start:(id)sender;
- (IBAction)btn_skip:(id)sender;

@end