//
//  MPCouponShareViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPSocialView.h"
#import "MPSocialShareAlertView.h"
#import "FHSTwitterEngine.h"
#import "ManagerDownload.h"

@interface MPCouponShareViewController : MPBaseViewController<UITableViewDataSource,UITableViewDelegate,MPSocialViewDelegate,MPSocialShareAlertViewDelegate,FHSTwitterEngineAccessTokenDelegate,ManagerDownloadDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    MPCouponObject *couponObject;
    BOOL isShareTwitterOkay;
    BOOL isShareLineDone;
}
- (void) setData: (MPCouponObject*) object;
@end
