//
//  MPTermsViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/29/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"

@interface MPTermsViewController : MPBaseViewController<ManagerDownloadDelegate>
{
    IBOutlet UITextView *termContent;
    NSArray *listCompany;
}

@property (weak, nonatomic) IBOutlet UIView *view_title;

@end
