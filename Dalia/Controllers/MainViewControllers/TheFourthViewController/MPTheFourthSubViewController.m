//
//  MPTheFourthSubViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/01.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheFourthSubViewController.h"
#import "MPDetailShopObject.h"
#import "MPDetailShopListObject.h"
#import "MyAnnotation.h"

@interface MPTheFourthSubViewController ()
{
    MPDetailShopObject* obj_shopinfo;
}
@end

@implementation MPTheFourthSubViewController

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
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_access.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //店舗情報取得
    [[ManagerDownload sharedInstance] getDetailShop:[Utility getAppID] withShopID:self.str_shop_id withDeviceID:[Utility getDeviceID] delegate:self];
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
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        //        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

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
        //        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - MapDevelop
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_DETAIL_SHOP:
        {
            obj_shopinfo = param.listData[0];

            //画像設定
            if(obj_shopinfo.image && [obj_shopinfo.image length] > 0 ) {

                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                dispatch_async(q_global, ^{

                    NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,obj_shopinfo.image];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                    dispatch_async(q_main, ^{
                        [_img_photo setImage:image];
                    });
                });
            }else{
                [_img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
            }

            _lbl_shopName.text = obj_shopinfo.shop_name;
            _lbl_subShopName.text = obj_shopinfo.shop_name_furi;

            _lbl_zipcode.text = [NSString stringWithFormat:@"%@ - %@", obj_shopinfo.postcode1, obj_shopinfo.postcode2];
            _lbl_adress.text = [NSString stringWithFormat:@"%@\n%@", obj_shopinfo.address1, obj_shopinfo.address2];
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

        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
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
    [NSString stringWithFormat: MAP_VIEW_IFRAME,[NSString stringWithFormat:@"https://maps.apple.com/maps?q=%@,%@&output=embed&iwloc=0",[obj_shopinfo.latitude doubleValue],[obj_shopinfo.longitude doubleValue]]];
    // https://www.google.com/maps/embed/v1/MODE?key=API_KEY&parameters
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.apple.com/maps?q=%@,%@&iwloc=0",[obj_shopinfo.latitude doubleValue],[obj_shopinfo.longitude doubleValue]]]];
    
    
}
@end
