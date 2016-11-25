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
#import "HearCatalogCategoryCollectionCell.h"
#import "HearCatalogNewstyleCollectionCell.h"

@protocol MPHearCatalogViewControllerDelegate<NSObject>
@end

@interface MPHearCatalogViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UICollectionView *_col_category;
    __weak IBOutlet UICollectionView *_col_newstyle;

    long _lng_category;
    __weak IBOutlet UIImageView *_img_ladies;
    __weak IBOutlet UIImageView *_img_mens;
    __weak IBOutlet UIImageView *_img_favorite;

    NSMutableArray* _ary_selectCategory_off;
    NSMutableArray* _ary_selectCategory_on;
    NSMutableArray* _ary_ledies_off;
    NSMutableArray* _ary_ledies_on;
    NSMutableArray* _ary_mens_off;
    NSMutableArray* _ary_mens_on;
    NSMutableArray* _ary_colection_off;
    NSMutableArray* _ary_colection_on;

    NSMutableArray* _ary_news;
}
@property (nonatomic, assign) id<MPHearCatalogViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

- (IBAction)btn_ladies:(id)sender;
- (IBAction)btn_mens:(id)sender;
- (IBAction)btn_favorite:(id)sender;

@end
