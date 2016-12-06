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

// INSERTED BY M.FUJII 2016.12.06 START
extern NSString *const SOME_CONSTANT_ARRAY[];
extern NSUInteger const SIZE_OF_SOME_CONSTANT_ARRAY;
// INSERTED BY M.FUJII 2016.12.06 END

@protocol MPMembersCardViewControllerDelegate<NSObject>
@end

@interface MPMembersCardViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    // DELETED BY M.FUJII 2016.12.06 START
    //NSMutableDictionary* _list_data;
    // DELETED BY M.FUJII 2016.12.06 END
}
@property (nonatomic, assign) id<MPMembersCardViewControllerDelegate> delegate;
@property (nonatomic) long lng_tabNo;

@end
