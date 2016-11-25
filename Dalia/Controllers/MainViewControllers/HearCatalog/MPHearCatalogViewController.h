//
//  MPHearCatalogViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/25.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "HearCatalogCollectionCell.h"

@protocol MPHearCatalogViewControllerDelegate<NSObject>
@end

@interface MPHearCatalogViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    __weak IBOutlet UICollectionView *_col_catalog;

    long _lng_category;
    __weak IBOutlet UIImageView *_img_ladies;
    __weak IBOutlet UIImageView *_img_mens;
    __weak IBOutlet UIImageView *_img_favorite;

    __weak IBOutlet UIView *_view_ladies;
    __weak IBOutlet UIView *_view_ladies1;
    __weak IBOutlet UIView *_view_ladies2;
    __weak IBOutlet UIView *_view_ladies3;
    __weak IBOutlet UIButton *_btn_lady_short;
    __weak IBOutlet UIButton *_btn_lady_bob;
    __weak IBOutlet UIButton *_btn_lady_medium;
    __weak IBOutlet UIButton *_btn_lady_semilong;
    __weak IBOutlet UIButton *_btn_lady_long;
    __weak IBOutlet UIButton *_btn_lady_arenge;

    __weak IBOutlet UIView *_view_mens;
    __weak IBOutlet UIView *_view_mens1;
    __weak IBOutlet UIView *_view_mens2;
    __weak IBOutlet UIButton *_btn_mens_short;
    __weak IBOutlet UIButton *_btn_mens_medium;
    __weak IBOutlet UIButton *_btn_mens_long;
}
@property (nonatomic, assign) id<MPHearCatalogViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

- (IBAction)btn_ladies:(id)sender;
- (IBAction)btn_mens:(id)sender;
- (IBAction)btn_favorite:(id)sender;

- (IBAction)btn_lady_short:(id)sender;
- (IBAction)btn_lady_bob:(id)sender;
- (IBAction)btn_lady_medium:(id)sender;
- (IBAction)btn_lady_semilong:(id)sender;
- (IBAction)btn_lady_long:(id)sender;
- (IBAction)btn_lady_arenge:(id)sender;

- (IBAction)btn_mens_short:(id)sender;
- (IBAction)btn_mens_medium:(id)sender;
- (IBAction)btn_mens_long:(id)sender;

@end
