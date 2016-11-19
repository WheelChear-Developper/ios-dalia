//
//  MPTheThirdSumMenuViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/19.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPTheSubMenuCell.h"

@protocol MPTheThirdSumMenuViewControllerDelegate<NSObject>

@end

@interface MPTheThirdSumMenuViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UIImageView *_img_head;
    __weak IBOutlet UITableView *_tbl_menu;
}
@property (nonatomic, assign) id<MPTheThirdSumMenuViewControllerDelegate> delegate;

@property (nonatomic, assign) long menuCount;
@property (nonatomic, assign) NSArray* ary_infoImage;
@property (nonatomic, assign) NSMutableDictionary* dic_menu_data;

@end
