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

#import "MPMenuListCollectionCell.h"

#import "TheUserInfoViewController.h"
#import "MPWebViewController.h"
#import "MPMenuTopinfoObject.h"
#import "MPMenuRecommend_menuObject.h"
#import "MPMenuRecommend_itemObject.h"
#import "MPMenuNewsObject.h"
#import "MPMenuRecommendMenuCell.h"
#import "MPMenuNewsCell.h"
#import "MPApnsObject.h"

@interface MPHomeViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate, MPTopImagesViewDelegate, UITableViewDelegate, UITableViewDataSource, TheUserInfoViewControllerDelegate ,UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UIView* _topimg_rootView;
    MPTopImagesView* _topImageView;

    __weak IBOutlet UIView *view_item;
    __weak IBOutlet UIButton* btn_block1;
    __weak IBOutlet UIButton* btn_block2;
    __weak IBOutlet UIButton* btn_block3;
    __weak IBOutlet UIButton* btn_block4;
    __weak IBOutlet UIButton* btn_block5;

    __weak IBOutlet UIImageView *img_notification_block1;
    __weak IBOutlet UIImageView *img_notification_block2;
        __weak IBOutlet UIImageView *img_notification_block3;
        __weak IBOutlet UIImageView *img_notification_block4;
        __weak IBOutlet UIImageView *img_notification_block5;

    __weak IBOutlet UICollectionView *_item_collectionView;

    __weak IBOutlet UIView *view_recommend;
    __weak IBOutlet UITableView* _RecommendMenuList_tableView;

    __weak IBOutlet UIView *view_news;
    __weak IBOutlet UITableView* _WhatsNew_tableView;

    NSMutableArray* list_RecommendItem;
    NSMutableArray* list_RecommendMenu;
    NSMutableArray* list_news;


}

- (IBAction)btn_block1:(id)sender;
- (IBAction)btn_block2:(id)sender;
- (IBAction)btn_block3:(id)sender;
- (IBAction)btn_block4:(id)sender;
- (IBAction)btn_block5:(id)sender;

- (IBAction)btn_Recomend1:(id)sender;
- (IBAction)btn_Recomend2:(id)sender;
- (IBAction)btn_Recomend3:(id)sender;
- (IBAction)btn_Recomend4:(id)sender;
- (IBAction)btn_Recomend5:(id)sender;
- (IBAction)btn_Recomend6:(id)sender;

- (IBAction)btn_Recommend_Menu_More:(id)sender;
- (IBAction)btn_WhatsNew_More:(id)sender;

@end
