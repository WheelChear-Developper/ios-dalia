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

}
- (IBAction)btn_transfer:(id)sender;
- (IBAction)btn_teams:(id)sender;

@end

