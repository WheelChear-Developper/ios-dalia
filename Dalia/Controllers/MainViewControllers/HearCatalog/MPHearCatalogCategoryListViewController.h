//
//  MPHearCatalogCategoryListViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "HearCatalogCategoryListViewControllerCell.h"

@protocol MPHearCatalogCategoryListViewControllerDelegate<NSObject>
@end

@interface MPHearCatalogCategoryListViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    long _lng_category;
    __weak IBOutlet UIImageView *_img_ladies;
    __weak IBOutlet UIImageView *_img_mens;
    __weak IBOutlet UIImageView *_img_favorite;

    __weak IBOutlet UIImageView *_img_photo;

    __weak IBOutlet UICollectionView *_col_photolist;

    NSMutableArray* _ary_photoList;
}
@property (nonatomic, assign) id<MPHearCatalogCategoryListViewControllerDelegate> delegate;
@property (nonatomic, assign) long lng_categolyType;
@property (nonatomic, assign) long lng_categolyNo;

- (IBAction)btn_ladies:(id)sender;
- (IBAction)btn_mens:(id)sender;
- (IBAction)btn_favorite:(id)sender;

@end
