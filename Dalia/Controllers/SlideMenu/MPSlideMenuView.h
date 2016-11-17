//
//  MPSlideMenuView.h
//  shopapp
//
//  Created by M.Amatani on 2016/11/07.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPSlideMenuCell.h"

@protocol MPSlideMenuViewDelegate<NSObject>
- (void)setNavigationSetView:(long)count;
@end

@interface MPSlideMenuView : UIView
{
    IBOutlet UITableView* _menu_table;
    NSArray* _ary_menuData;
}
@property (nonatomic, assign) id<MPSlideMenuViewDelegate> delegate;


@end
