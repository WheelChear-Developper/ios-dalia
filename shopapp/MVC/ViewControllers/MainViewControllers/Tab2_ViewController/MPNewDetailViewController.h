//
//  MPNewDetailViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/29/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPAppDelegate.h"
#import "MPNewHomeObject.h"
#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPHomeWebViewViewController.h"

@interface MPNewDetailViewController:MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, UITextViewDelegate>
{
    MPNewHomeObject *newHomeObject;
    __weak IBOutlet UIImageView *image_title;
    __weak IBOutlet UILabel *lbl_date;
    __weak IBOutlet UILabel *lbl_title;
    __weak IBOutlet UILabel *lbl_message;
    __weak IBOutlet UITextView *txt_message;
}
- (void)setData:(MPNewHomeObject*)newObject;

@end
