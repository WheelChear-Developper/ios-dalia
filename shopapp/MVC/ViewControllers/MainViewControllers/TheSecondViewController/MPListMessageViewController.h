//
//  MPListMessageViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 12/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPBaseViewController.h"
#import "ManagerDownload.h"

@interface MPListMessageViewController : MPBaseViewController<UITableViewDataSource, UITableViewDelegate, ManagerDownloadDelegate>
{
    UITableView *_tableView;
    NSArray *listObject;
}
@end
