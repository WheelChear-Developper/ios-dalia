//
//  MPTheSecondViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"

@interface MPTheSecondViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate>
{
    UIScrollView* _scr_rootview;
    UIView *_scr_inView;
    UIView *_cornerView;

}


@end
