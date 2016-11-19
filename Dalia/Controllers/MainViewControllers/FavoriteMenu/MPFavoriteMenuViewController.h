//
//  MPFavoriteMenuViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "MPMenuRecommendMenuCell.h"
#import "MPMenuRecommend_menuObject.h"

@protocol MPFavoriteMenuViewControllerDelegate<NSObject>
@end

@interface MPFavoriteMenuViewController : MPBaseViewController <ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    __weak IBOutlet UITableView *_RecommendMenuList_tableView;

    NSMutableArray* list_RecommendMenu;
}
@property (nonatomic, assign) id<MPFavoriteMenuViewControllerDelegate> delegate;

@end
