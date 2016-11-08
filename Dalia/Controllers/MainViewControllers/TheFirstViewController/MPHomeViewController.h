//
//  MPHomeViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPTopImagesView.h"
#import "MPConfigObject.h"
#import "Configuration.h"

//#import "DeployGateSDK/DeployGateSDK.h"

@interface MPHomeViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, MPTopImagesViewDelegate>
{
    UIScrollView* _scr_rootview;
    UIView *_scr_inView;
    UIView *_cornerView;
    MPTopImagesView *topImageView;
    CGPoint scrollBeginingPoint;
}

@end
