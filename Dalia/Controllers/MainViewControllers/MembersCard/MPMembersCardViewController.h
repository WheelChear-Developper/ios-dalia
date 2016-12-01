//
//  MPMembersCardViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/24.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"

@protocol MPMembersCardViewControllerDelegate<NSObject>
@end

@interface MPMembersCardViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    NSMutableDictionary* _list_data;
}
@property (nonatomic, assign) id<MPMembersCardViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

@end
