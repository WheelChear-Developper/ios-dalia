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

#import "MPFirstSetting_nick_name_TableViewCell.h"
#import "MPFirstSetting_gender_TableViewCell.h"
#import "MPFirstSetting_mail_TableViewCell.h"
#import "MPFirstSetting_job_TableViewCell.h"
#import "MPFirstSetting_zipcode_TableViewCell.h"
#import "MPFirstSetting_address_TableViewCell.h"
#import "MPFirstSetting_name_TableViewCell.h"
#import "MPFirstSetting_furigana_TableViewCell.h"
#import "MPFirstSetting_tel_TableViewCell.h"
#import "MPFirstSetting_generation_TableViewCell.h"
#import "MPFirstSetting_shop_TableViewCell.h"
#import "MPFirstSetting_birthday_TableViewCell.h"

@protocol FirstSettingViewControllerDelegate<NSObject>
@end

@interface FirstSettingViewController : MPBaseViewController <UITextFieldDelegate, ManagerDownloadDelegate, UIScrollViewDelegate>
{    
    id<FirstSettingViewControllerDelegate> _FirstSettingViewControllerDelegate;

    __weak IBOutlet UITableView *_tbl_userSetting;
    
    long lng_sexflag;
    NSString* str_ID;
    MPMemberObject* memberObj;
    UIDatePicker *datePicker_Birthday;
    UIDatePicker *datePicker_ChildeBirthday1;
    UIDatePicker *datePicker_ChildeBirthday2;
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;

    NSDictionary* ary_field;
    NSMutableArray* ary_fieldValue;
    
}
@property (nonatomic) id<FirstSettingViewControllerDelegate> FirstSettingViewControllerDelegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scr_view;


@property (weak, nonatomic) IBOutlet UITextField *txt_introductionCode;


@property (nonatomic) UIAlertController *alertController;  //アラートコントローラー本体
@property (nonatomic) UILabel *chkLbl;  //ラベル

- (IBAction)btn_start:(id)sender;
- (IBAction)btn_skip:(id)sender;

@end
