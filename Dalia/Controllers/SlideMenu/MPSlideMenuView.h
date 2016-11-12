//
//  MPSlideMenuView.h
//  shopapp
//
//  Created by M.Amatani on 2016/11/07.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "ManagerDownload.h"
#import "MPSlideMenuCell.h"
//#import "SettingViewController.h"

@protocol MPSlideMenuViewDelegate<NSObject>
- (void)setNavigationSetView:(long)count;
@end

@interface MPSlideMenuView : UIView <ManagerDownloadDelegate>
{
    IBOutlet UITableView* _menu_table;
}
@property (nonatomic, assign) id<MPSlideMenuViewDelegate> delegate;


@end
