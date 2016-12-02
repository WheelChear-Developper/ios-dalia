//
//  MPReservationViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPReservationViewController.h"

@interface MPReservationViewController ()

@end

@implementation MPReservationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [_contentView setHidden:YES];

    UINib *nib = [UINib nibWithNibName:@"MPReservationCell" bundle:nil];
    [_tbl_list registerNib:nib forCellReuseIdentifier:@"reservationIdentifier"];
    [_tbl_list reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_reserve.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    _ary_area = [@[@"Beauty Salon 大名店", @"Beauty Salon 大名店", @"Beauty Salon 大名店", @"Beauty Salon 大名店", @"Beauty Salon 大名店"] mutableCopy];
    [_tbl_list reloadData];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    _scr_rootview.delegate = nil;

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

    [self resizeTable];
}

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [self setFadeOut_CustomNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_COUPON:
        {


        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _ary_area.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reservationIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPReservationCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.lbl_title.text = [_ary_area objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_list.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_list.frame = CGRectMake(_tbl_list.frame.origin.x, _tbl_list.frame.origin.y, _tbl_list.frame.size.width, 0);
    _tbl_list.frame =
    CGRectMake(_tbl_list.frame.origin.x,
               _tbl_list.frame.origin.y,
               _tbl_list.contentSize.width,
               MAX(_tbl_list.contentSize.height,
                   _tbl_list.bounds.size.height));
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
