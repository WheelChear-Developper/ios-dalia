//
//  MPVideoChannelView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerDownload.h"
#import "MPVideoObject.h"
#import "MPAppDelegate.h"

@protocol MPVideoChannelViewDelegate<NSObject>
- (void) detailVideoChannel: (MPVideoObject*) object;
@end

@interface MPVideoChannelView : UIView<UITableViewDataSource,UITableViewDelegate,ManagerDownloadDelegate>
{
    IBOutlet UITableView *_tableView;
    NSArray *listVideo;
}
@property (nonatomic, assign) id<MPVideoChannelViewDelegate> delegate;

@end
