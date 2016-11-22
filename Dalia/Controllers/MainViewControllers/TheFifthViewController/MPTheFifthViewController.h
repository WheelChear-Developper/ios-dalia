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

@interface MPTheFifthViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UILabel *_lbl_version;

    __weak IBOutlet UISwitch *sw_newsNotification;
    __weak IBOutlet UISwitch *sw_recommended;
    __weak IBOutlet UISwitch *sw_recommendedMenu;
    __weak IBOutlet UISwitch *sw_catalog;
    __weak IBOutlet UISwitch *sw_curpon;
}
- (IBAction)sw_newsNotification:(id)sender;
- (IBAction)sw_recommended:(id)sender;
- (IBAction)sw_recommendedMenu:(id)sender;
- (IBAction)sw_catalog:(id)sender;
- (IBAction)sw_curpon:(id)sender;

- (IBAction)btn_transfer:(id)sender;
- (IBAction)btn_teams:(id)sender;
- (IBAction)btn_porisir:(id)sender;

@end

