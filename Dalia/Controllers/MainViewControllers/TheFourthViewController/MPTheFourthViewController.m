//
//  MPTheFourthViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheFourthViewController.h"
#import "MPDetailShopObject.h"
#import "MPDetailShopListObject.h"
#import "MyAnnotation.h"

@interface MPTheFourthViewController ()
{
    MPDetailShopObject* obj_shopinfo;
}
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
    UINib *nib = [UINib nibWithNibName:@"ShopListViewCell" bundle:nil];
    [_tbl_shopList registerNib:nib forCellReuseIdentifier:@"shopListIdentifier"];
    [_tbl_shopList reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:NO];
    [self setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_access.png"] imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    //選択タブ解除
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:3];

    [super viewWillAppear:animated];

    //店舗情報取得
    [[ManagerDownload sharedInstance] getListShop:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
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
}

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

    MPDetailShopListObject* dic_list = [_ary_shopTitle objectAtIndex:indexPath.row];

    cell.lbl_shopName.text = dic_list.shop_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPTheFourthSubViewController *vc = [[MPTheFourthSubViewController alloc] initWithNibName:@"MPTheFourthSubViewController" bundle:nil];
    MPDetailShopListObject* ary_shop = [_ary_shopTitle objectAtIndex:indexPath.row];
    vc.str_shop_id = ary_shop.id;
    [self.navigationController pushViewController:vc animated:YES];
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
        case RequestType_GET_LIST_SHOP:
        {
            _list_data = param.listData[0];

            obj_shopinfo = [_list_data objectForKey:@"shop_info"];

            //画像設定
            if(obj_shopinfo.image && [obj_shopinfo.image length] > 0 ) {

                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                dispatch_async(q_global, ^{

                    NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,obj_shopinfo.image];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                    dispatch_async(q_main, ^{
                        [_img_photo setImage:image];

                        if(image != nil){
                            float width = image.size.width;
                            float height = image.size.height;
                            float flt_whide = 320 / width;
                            float flt_heght = height * flt_whide;
                            _img_photo.translatesAutoresizingMaskIntoConstraints = YES;
                            CGRect rct = _img_photo.frame;
                            rct.size.height = flt_heght;
                            _img_photo.frame = rct;
                        }
                    });
                });
            }else{
                [_img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
            }

            _lbl_shopName.text = obj_shopinfo.shop_name;
            _lbl_subShopName.text = obj_shopinfo.shop_name_furi;

            if(obj_shopinfo.postcode1 == nil){

                _lbl_zipcode.text = @"";
            }else{

                _lbl_zipcode.text = [NSString stringWithFormat:@"%@ - %@", obj_shopinfo.postcode1, obj_shopinfo.postcode2];
            }
            if(obj_shopinfo.address2 == nil){

                _lbl_adress.text = [NSString stringWithFormat:@"%@", obj_shopinfo.address1];
            }else{

                _lbl_adress.text = [NSString stringWithFormat:@"%@\n%@", obj_shopinfo.address1, obj_shopinfo.address2];
            }
            _lbl_tel.text = [NSString stringWithFormat:@"%@ - %@ - %@", obj_shopinfo.phone1, obj_shopinfo.phone2, obj_shopinfo.phone3];
            _lbl_bisinessHour.text = obj_shopinfo.business_hour;
            _lbl_memo.text = obj_shopinfo.content;

            _str_instagram_url = obj_shopinfo.instagram_url;
            _str_facebook_url = obj_shopinfo.faebook_url;
            _str_twitter_url = obj_shopinfo.twitter_url;
            _str_shop_url = obj_shopinfo.shop_url;
            _str_reserve_url = obj_shopinfo.reserve_url;

            if([_str_reserve_url isEqualToString:@""]){

                _btn_reserve.translatesAutoresizingMaskIntoConstraints = YES;
                CGRect rct = _btn_reserve.frame;
                rct.size.width = 0;
                _btn_reserve.frame = rct;
            }



            CLLocationCoordinate2D co1;
            co1.latitude = [obj_shopinfo.latitude doubleValue]; // 経度
            co1.longitude = [obj_shopinfo.longitude doubleValue]; // 緯度
            MKCoordinateRegion cr1 = _map.region;
            cr1.center = co1;
            cr1.span.latitudeDelta = 0.01;
            cr1.span.longitudeDelta = 0.01;
            [_map setRegion:cr1 animated:NO];

            MyAnnotation *annotation1;
            CLLocationCoordinate2D location1;
            location1.latitude  = [obj_shopinfo.latitude doubleValue];
            location1.longitude = [obj_shopinfo.longitude doubleValue];
            annotation1 =[[MyAnnotation alloc] initWithCoordinate:location1];
            annotation1.title = obj_shopinfo.shop_name;
            [_map addAnnotation:annotation1];

            _ary_shopTitle = [_list_data objectForKey:@"shop_list"];
            [_tbl_shopList reloadData];

            [self resizeTable];
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

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_instagram_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_facebook:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_facebook_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_twitter:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_twitter_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_web:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_shop_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_webReservation:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = obj_shopinfo.reserve_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_tel:(id)sender {

    NSString *theCall = [NSString stringWithFormat:@"telprompt://%@",[NSString stringWithFormat:@"%@%@%@", obj_shopinfo.phone1, obj_shopinfo.phone2, obj_shopinfo.phone3]];

    NSString *theNewCall = [theCall stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theNewCall]];
}

- (IBAction)btn_map:(id)sender {

    //    add Google Map
    //    [NSString stringWithFormat:MAP_VIEW_IFRAME,[NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&output=embed&iwloc=0",shopObject.latitude,shopObject.longitude]];
    //    // https://www.google.com/maps/embed/v1/MODE?key=API_KEY&parameters
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&iwloc=0",shopObject.latitude,shopObject.longitude]]];
    //    add Apple Map
    [NSString stringWithFormat: MAP_VIEW_IFRAME,[NSString stringWithFormat:@"https://maps.apple.com/maps?q=%f,%f&output=embed&iwloc=0",[obj_shopinfo.latitude doubleValue],[obj_shopinfo.longitude doubleValue]]];
    // https://www.google.com/maps/embed/v1/MODE?key=API_KEY&parameters
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.apple.com/maps?q=%f,%f&iwloc=0",[obj_shopinfo.latitude doubleValue],[obj_shopinfo.longitude doubleValue]]]];
}

@end
