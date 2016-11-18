//
//  MPTermsViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"
#import "MPConfigObject.h"

@interface MPTermsViewController : MPBaseViewController<ManagerDownloadDelegate>
{
    IBOutlet UITextView *termContent;
    NSArray *listCompany;
}
@property (weak, nonatomic) IBOutlet UIView *view_title;

@end
