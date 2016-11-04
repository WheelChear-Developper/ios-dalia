//
//  MPVideoChannelDetailViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPVideoObject.h"

@interface MPVideoChannelDetailViewController : MPBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, strong) MPVideoObject *videoObject;

@end
