//
//  UserSettingViewController.h
//  Misepuri
//
//  Created by AMA on 2016/09/09.
//

#import <UIKit/UIKit.h>
#import "MPAppDelegate.h"
#import "MPBaseViewController.h"
#import "Configuration.h"
#import "MPMemberObject.h"
#import "MPSettingAlertView.h"
#import "ManagerDownload.h"

@interface UserSettingViewController : MPBaseViewController <UITextFieldDelegate, ManagerDownloadDelegate, MPSettingAlertViewDelegate>
{    
    long lng_sexflag;
    NSString* str_ID;
    MPMemberObject* memberObj;
    UIDatePicker *datePicker_Birthday;
    UIDatePicker *datePicker_ChildeBirthday1;
    UIDatePicker *datePicker_ChildeBirthday2;
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scr_view;
@property (weak, nonatomic) IBOutlet UIView *view_title;

@property (weak, nonatomic) IBOutlet UITextField *txt_nickname;
@property (weak, nonatomic) IBOutlet UITextField *txt_birthday;
@property (weak, nonatomic) IBOutlet UITextField *txt_zipcode;
@property (weak, nonatomic) IBOutlet UITextField *txt_childrenname1;
@property (weak, nonatomic) IBOutlet UITextField *txt_childrenBirthday1;
@property (weak, nonatomic) IBOutlet UITextField *txt_childrenname2;
@property (weak, nonatomic) IBOutlet UITextField *txt_childrenBirthday2;

@property (weak, nonatomic) IBOutlet UIButton *btnF_boy;
@property (weak, nonatomic) IBOutlet UIButton *btnF_girl;

- (IBAction)btn_boy:(id)sender;
- (IBAction)btn_girl:(id)sender;

- (IBAction)btn_save:(id)sender;
- (IBAction)btn_cancel:(id)sender;

@end
