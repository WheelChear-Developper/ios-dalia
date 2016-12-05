//
//  MPTheFifthViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPTransferViewController.h"
#import "MPTermsViewController.h"

#import "MPMemberObject.h"

#import "TheFifth_nick_name_TableViewCell.h"
#import "TheFifth_gender_TableViewCell.h"
#import "TheFifth_mail_TableViewCell.h"
#import "TheFifth_job_TableViewCell.h"
#import "TheFifth_zipcode_TableViewCell.h"
#import "TheFifth_address_TableViewCell.h"
#import "TheFifth_name_TableViewCell.h"
#import "TheFifth_furigana_TableViewCell.h"
#import "TheFifth_tel_TableViewCell.h"
#import "TheFifth_generation_TableViewCell.h"
#import "TheFifth_shop_TableViewCell.h"
#import "TheFifth_birthday_TableViewCell.h"

@interface MPTheFifthViewController : MPBaseViewController<UITextFieldDelegate, ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;

    MPMemberObject* memberObj;

    TheFifth_nick_name_TableViewCell *cell_nick_name;
    TheFifth_gender_TableViewCell *cell_gender;
    TheFifth_mail_TableViewCell *cell_mail;
    TheFifth_job_TableViewCell *cell_job;
    TheFifth_zipcode_TableViewCell *cell_zipcode;
    TheFifth_address_TableViewCell *cell_address;
    TheFifth_name_TableViewCell *cell_name;
    TheFifth_furigana_TableViewCell *cell_furigana;
    TheFifth_tel_TableViewCell *cell_tel;
    TheFifth_generation_TableViewCell *cell_generation;
    TheFifth_shop_TableViewCell *cell_shop;
    TheFifth_birthday_TableViewCell *cell_birthday;

    long lng_sexflag;
    NSString* str_ID;
    UIDatePicker *datePicker_Birthday;

    __weak IBOutlet UITableView *_tbl_userSetting;
    __weak IBOutlet UITextField *txt_birthday;
    __weak IBOutlet UILabel *_lbl_version;
    __weak IBOutlet UISwitch *sw_newsNotification;
    __weak IBOutlet UISwitch *sw_curpon;
}
- (IBAction)sw_newsNotification:(id)sender;
- (IBAction)sw_curpon:(id)sender;

- (IBAction)btn_transfer:(id)sender;
- (IBAction)btn_teams:(id)sender;
- (IBAction)btn_porisir:(id)sender;

@end

