//
//  MPListMessageViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 12/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPListMessageViewController.h"
#import "MPTabBarViewController.h"
#import "MPNewHomeCell.h"
#import "MPNewDetailViewController.h"
#import "MPWpNewsDetailViewController.h"
#import "MPUIConfigObject.h"

@interface MPListMessageViewController ()
@end

@implementation MPListMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //🔴navigation表示
    [self setBasicNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];

    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bg.png"]];
    [view setFrame:CGRectMake(0, 0, 320, 30)];
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
    
        [title setText:[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"titleNewHeader"]];
    
    [view addSubview:title];
    [contentView addSubview:view];
    
    float heightForTableView = 0.0f;
    switch ([Utility deviceType]) {
        case DEVICE_TYPE_iPhone5Retina:
            heightForTableView = contentView.frame.size.height-40;
            break;
            
        case DEVICE_TYPE_iPhone4Retina:
        case DEVICE_TYPE_iPhone:
            heightForTableView = contentView.frame.size.height-3;
            break;
            
        default:
            break;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, view.frame.size.height + 5, contentView.frame.size.width - 10, heightForTableView) style:UITableViewStylePlain];
    [_tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [contentView addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"MPNewHomeCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"newHomeIdentifier"];
    [_tableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //TODO: GET list message
    [[ManagerDownload sharedInstance] getListMessage:[Utility getDeviceID] withAppID:[Utility getAppID] withLimit:@"-1" delegate:self];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param{
    
    switch (param.request_type) {
        case RequestType_GET_LIST_MESSAGES:
        {
            listObject  = param.listData;
            [_tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (listObject.count > 0) {
        return listObject.count;
    }
    if ([MPAppDelegate sharedMPAppDelegate].networkStatus) {
        if (!listObject) {
            return 0;
        }
    }
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 37;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (listObject.count > 0) {
        MPNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newHomeIdentifier"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPNewHomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell setData:[listObject objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
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
        [cell.textLabel setText:NO_LIST_NEWS];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    MPNewHomeObject* news = (MPNewHomeObject*)listObject[indexPath.row];

    if ( news.wp_flg == 0 ){
        MPNewDetailViewController *newDetailVC = [[MPNewDetailViewController alloc] initWithNibName:@"MPNewDetailViewController" bundle:nil];
        [newDetailVC setData:[listObject objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:newDetailVC animated:YES];
    }else{
        MPWpNewsDetailViewController *newDetailVC = [[MPWpNewsDetailViewController alloc] initWithNibName:@"MPWpNewsDetailViewController" bundle:nil];
        newDetailVC.contents = news;
        [self.navigationController pushViewController:newDetailVC animated:YES];
    }
}

- (void)backButtonClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
