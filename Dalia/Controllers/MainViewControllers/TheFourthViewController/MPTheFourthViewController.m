//
//  MPTheFourthViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheFourthViewController.h"

@interface MPTheFourthViewController ()
@end

@implementation MPTheFourthViewController

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

    //load cell xib and attach with collectionView
//    UINib *nib = [UINib nibWithNibName:@"ShopListViewCell" bundle:nil];
//    [_tbl_shopList registerNib:nib forCellReuseIdentifier:@"shopListIdentifier"];
//    [_tbl_shopList reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_access.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    MKCoordinateRegion cr = _map.region;
    // 東京スカイツリーの座標
    cr.center = CLLocationCoordinate2DMake(35.710063, 139.8107);
    // 縮尺　0.01
    cr.span = MKCoordinateSpanMake(0.01, 0.01);
    [_map setRegion:cr animated:NO];

    _ary_shopTitle = [@[@"Beauty Salon 大名店", @"Beauty Salon 新宮店", @"Beauty Salon 小倉店", @"Beauty Salon 門司店", @"Beauty Salon 柳川店"] mutableCopy];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];

    [_tbl_shopList reloadData];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - MapDevelop
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _ary_shopTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ShopListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopListIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShopListViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.lbl_shopName.text = [_ary_shopTitle objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_shopList.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_shopList.frame = CGRectMake(_tbl_shopList.frame.origin.x, _tbl_shopList.frame.origin.y, _tbl_shopList.frame.size.width, 0);
    _tbl_shopList.frame =
    CGRectMake(_tbl_shopList.frame.origin.x,
               _tbl_shopList.frame.origin.y,
               _tbl_shopList.contentSize.width,
               MAX(_tbl_shopList.contentSize.height,
                   _tbl_shopList.bounds.size.height));
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

- (void)backButtonClicked:(UIButton *)sender {
}

- (IBAction)btn_insta:(id)sender {
}

- (IBAction)btn_facebook:(id)sender {
}

- (IBAction)btn_twitter:(id)sender {
}

- (IBAction)btn_web:(id)sender {
}

- (IBAction)btn_webReservation:(id)sender {
}

- (IBAction)btn_tel:(id)sender {
}

- (IBAction)btn_map:(id)sender {

    
}
@end
