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

@interface FirstSettingViewController : MPBaseViewController <UITextFieldDelegate, ManagerDownloadDelegate, UIScrollViewDelegate, MPFirstSetting_nick_name_TableViewCellDelegate, MPFirstSetting_birthday_TableViewCellDelegate>
{    
    id<FirstSettingViewControllerDelegate> _FirstSettingViewControllerDelegate;

    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;

    MPMemberObject* memberObj;

    MPFirstSetting_nick_name_TableViewCell *cell_nick_name;
    MPFirstSetting_gender_TableViewCell *cell_gender;
    MPFirstSetting_mail_TableViewCell *cell_mail;
    MPFirstSetting_job_TableViewCell *cell_job;
    MPFirstSetting_zipcode_TableViewCell *cell_zipcode;
    MPFirstSetting_address_TableViewCell *cell_address;
    MPFirstSetting_name_TableViewCell *cell_name;
    MPFirstSetting_furigana_TableViewCell *cell_furigana;
    MPFirstSetting_tel_TableViewCell *cell_tel;
    MPFirstSetting_generation_TableViewCell *cell_generation;
    MPFirstSetting_shop_TableViewCell *cell_shop;
    MPFirstSetting_birthday_TableViewCell *cell_birthday;

    long lng_sexflag;
    NSString* str_ID;
    UIDatePicker *datePicker_Birthday;
    UIDatePicker *datePicker_ChildeBirthday1;
    UIDatePicker *datePicker_ChildeBirthday2;

    __weak IBOutlet UITableView *_tbl_userSetting;

    __weak IBOutlet UIView *view_privacepolice;
}
@property (nonatomic) id<FirstSettingViewControllerDelegate> FirstSettingViewControllerDelegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scr_view;
@property (weak, nonatomic) IBOutlet UITextField *txt_introductionCode;

@property (nonatomic) UIAlertController *alertController;  //アラートコントローラー本体
@property (nonatomic) UILabel *chkLbl;  //ラベル

- (IBAction)btn_start:(id)sender;
- (IBAction)btn_skip:(id)sender;

@end
