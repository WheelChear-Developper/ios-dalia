//
//  SettingViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "UserSettingViewController.h"
#import "MPTermsViewController.h"
#import "MPTransferViewController.h"

@interface SettingViewController : MPBaseViewController <ManagerDownloadDelegate>
{
    IBOutlet UIButton *switchButton;
    int touchCount;
    IBOutlet UILabel *versionLabel;
}
@property (weak, nonatomic) IBOutlet UIView *view_title;

- (IBAction)btn_userset:(id)sender;

@end
