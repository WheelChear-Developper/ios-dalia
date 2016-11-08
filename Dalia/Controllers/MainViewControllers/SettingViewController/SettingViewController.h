//
//  SettingViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "UserSettingViewController.h"

@interface SettingViewController : MPBaseViewController <ManagerDownloadDelegate>
{
    IBOutlet UIButton *switchButton;
    int touchCount;
    IBOutlet UILabel *versionLabel;
}
@property (weak, nonatomic) IBOutlet UIView *view_title;

- (IBAction)btn_userset:(id)sender;

@end
