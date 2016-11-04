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
// REPLACED BY ama 2016.10.05 START
// レイアウト更新
@property (weak, nonatomic) IBOutlet UIView *view_title;
// REPLACED BY ama 2016.10.05 END

@end
