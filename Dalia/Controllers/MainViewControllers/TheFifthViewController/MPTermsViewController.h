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

@interface MPTermsViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    IBOutlet UITextView *termContent;
    NSArray *listCompany;
}
@property (weak, nonatomic) IBOutlet UIView *view_title;

@end
