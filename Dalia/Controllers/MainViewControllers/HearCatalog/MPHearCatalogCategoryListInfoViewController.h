//
//  MPHearCatalogCategoryListInfoViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPQLPageView.h"
#import "HearCatalogCategoryListInfo_SlideView.h"

@protocol MPHearCatalogCategoryListInfoViewControllerDelegate<NSObject>
@end

@interface MPHearCatalogCategoryListInfoViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, MPQLPageViewDataSource, MPQLPageViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
}
@property (nonatomic, assign) id<MPHearCatalogCategoryListInfoViewControllerDelegate> delegate;
@property (nonatomic, strong) MPQLPageView *pageView;

@property (nonatomic, assign) long lng_categolyType;
@property (nonatomic, assign) long lng_categolyNo;
@property (nonatomic, assign) NSMutableArray* ary_photoList;

@end
