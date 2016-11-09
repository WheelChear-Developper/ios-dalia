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
#import "MPMenuListHomeCell.h"
#import "MPNewHomeCell.h"
#import "TheUserInfoViewController.h"

//#import "DeployGateSDK/DeployGateSDK.h"

@interface MPHomeViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPTopImagesViewDelegate, UITableViewDelegate, UITableViewDataSource, TheUserInfoViewControllerDelegate>
{
    UIScrollView* _scr_rootview;
    UIView* _scr_inView;
    UIView* _cornerView;
    MPTopImagesView* _topImageView;
    CGPoint _scrollBeginingPoint;

    UIView* view_Recommend_Menu;
    UITableView* _RecommendMenuList_tableView;
    UIImageView* iv_Recommend_Menu_More;
    UIButton* btn_Recommend_Menu_More;

    UIView* view_WhatsNew;
    UITableView* _WhatsNew_tableView;
    UIImageView* iv_WhatsNew_More;
    UIButton *btn_WhatsNew_More;
}

@end
