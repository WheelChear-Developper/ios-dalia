//
//  MPVideoChannelDetailViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPVideoChannelDetailViewController.h"
#import "MPVideoChannelHeaderView.h"

@interface MPVideoChannelDetailViewController ()
@end

@implementation MPVideoChannelDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    

    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bg.png"]];
    [view setFrame:CGRectMake(0, 0, 320, 32)];
    UILabel *title = [[UILabel alloc] initWithFrame:view.frame];
    CGRect titleFrame = title.frame;
    titleFrame.origin.x = TITLE_HEADER_LEFT;
    titleFrame.size.width = 280;
    titleFrame.size.height = 21;
    titleFrame.origin.y = (view.frame.size.height - titleFrame.size.height)/2;
    title.frame = titleFrame;
    [title setBackgroundColor:[UIColor clearColor]];
    [title setTextColor:[UIColor whiteColor]];
    [title setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    [title setText:self.videoObject.title];
    [view addSubview:title];
    
    [contentView addSubview:view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 32, contentView.frame.size.width - 10, contentView.frame.size.height - 32) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]]];
    //[_tableView setBackgroundColor:[UIColor redColor]];
    [contentView addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
   return [MPVideoChannelHeaderView heightForHeader:self.videoObject];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 4.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    MPVideoChannelHeaderView *headerView = (MPVideoChannelHeaderView*) [Utility viewInBundleWithName:@"MPVideoChannelHeaderView"];
    [headerView setData:self.videoObject];
    return headerView;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    return cell;
}

- (void)backButtonClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
