//
//  MPCouponShareView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponShareView.h"

@implementation MPCouponShareView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UINib *nib = [UINib nibWithNibName:@"MPCouponShareCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"couponShareIdentifier"];
    [_tableView reloadData];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[ManagerDownload sharedInstance] getListCouponShare:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    listCouponShare = param.listData;
    [_tableView reloadData];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (listCouponShare.count > 0) {
        return listCouponShare.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (listCouponShare.count > 0) {
        MPCouponObject *object = [listCouponShare objectAtIndex:indexPath.row];
        return [MPCouponShareCell heightForRow:object];
    }
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 33;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [Utility viewInBundleWithName:@"CouponShareHeaderView"];
    
    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![MPAppDelegate sharedMPAppDelegate].networkStatus) {
        
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            [cell setUserInteractionEnabled:NO];
        }
        [cell.textLabel setText:NO_LIST_SHARE_THANK_COUPON_MESSAGE];
        
        return cell;
    }
    
    if (listCouponShare.count > 0) {
        MPCouponShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponShareIdentifier"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPCouponShareCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        MPCouponObject *object = [listCouponShare objectAtIndex:indexPath.row];
        [cell setData:object];
        return cell;
    }else{
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            [cell setUserInteractionEnabled:NO];
        }
        if (listCouponShare) {
            [cell.textLabel setText:NO_LIST_SHARE_THANK_COUPON_MESSAGE];
        }
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MPCouponObject *object = [listCouponShare objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(getCouponShare:)]) {
        [self.delegate getCouponShare:object];
    }
}

@end
