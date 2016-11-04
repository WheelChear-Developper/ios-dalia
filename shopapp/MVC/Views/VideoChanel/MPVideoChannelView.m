//
//  MPVideoChannelView.m
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPVideoChannelView.h"
#import "MPVideoChannelCell.h"

@implementation MPVideoChannelView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {

    [super awakeFromNib];
    
    UINib *nib = [UINib nibWithNibName:@"MPVideoChannelCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"videoChannelIdentifier"];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView reloadData];
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
    [[ManagerDownload sharedInstance] getListVideo:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    listVideo = param.listData;
    [_tableView reloadData];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (listVideo.count > 0) {
         return listVideo.count;
    }
    if ([MPAppDelegate sharedMPAppDelegate].networkStatus) {
        if (!listVideo) {
            return 0;
        }
    }
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (listVideo.count > 0) {
        return 114.0f;
    }
    return 50.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 4.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 4.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (listVideo.count > 0) {
        MPVideoChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoChannelIdentifier"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPVideoChannelCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setData:[listVideo objectAtIndex:indexPath.row]];
        CGRect tableFrame = _tableView.frame;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        tableFrame.origin.x = 0;
        tableFrame.size.width = 310;
        _tableView.frame = tableFrame;
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
            CGRect tableFrame = _tableView.frame;
            tableFrame.origin.x = -5;
            tableFrame.size.width += 5;
            _tableView.frame = tableFrame;
            
        }
        [cell.textLabel setText:NO_VIDEO_CHANNEL_MESSAGE];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MPVideoObject *object = [listVideo objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(detailVideoChannel:)]) {
        [self.delegate detailVideoChannel:object];
    }
}

@end
