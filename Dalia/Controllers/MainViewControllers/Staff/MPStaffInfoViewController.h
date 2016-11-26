//
//  MPStaffInfoViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPStaffCollectionCell.h"

@protocol MPStaffInfoViewControllerDelegate<NSObject>
@end

@interface MPStaffInfoViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UICollectionView *_col_photolist;

    NSMutableArray* _ary_photoList;
}
@property (nonatomic, assign) id<MPStaffInfoViewControllerDelegate> delegate;

@end
