//
//  MPSNSViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/04.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPSNSTableViewCell.h"
#import "MPCouponShareObject.h"
#import "MPSNSAreartView.h"
#import "MPAppDelegate.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>

@protocol MPSNSViewControllerDelegate<NSObject, MPSNSAreartViewDelegate>
@end

@interface MPSNSViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPSNSViewControllerDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    NSMutableArray* _list_data;

    __weak IBOutlet UITableView *_tbl_menulist;

    __weak IBOutlet UIImageView *img_mark;
}
@property (nonatomic, assign) id<MPSNSViewControllerDelegate> delegate;
@property (nonatomic, assign) long lng_snsType;


@end
