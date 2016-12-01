//
//  MPTheFourthSubViewController.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/01.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "ShopListViewCell.h"
#import "MPWebViewController.h"
#import "MPDetailShopObject.h"
#import "MPDetailShopListObject.h"

@interface MPTheFourthSubViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, MKMapViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UIImageView *_img_photo;
    __weak IBOutlet UILabel *_lbl_shopName;
    __weak IBOutlet UILabel *_lbl_subShopName;

    __weak IBOutlet UILabel *_lbl_zipcode;
    __weak IBOutlet UILabel *_lbl_adress;
    __weak IBOutlet UILabel *_lbl_tel;
    __weak IBOutlet UILabel *_lbl_bisinessHour;
    __weak IBOutlet UILabel *_lbl_memo;
    __weak IBOutlet MKMapView *_map;

    __weak IBOutlet UIView *_view_sns;
    __weak IBOutlet UIView *_view_insta;
    __weak IBOutlet UIView *_view_facebook;
    __weak IBOutlet UIView *_view_twitter;
    __weak IBOutlet UIView *_view_web;

    __weak IBOutlet UIButton *_btn_reserve;
    __weak IBOutlet UIButton *_btn_tel;
    __weak IBOutlet UIButton *_btn_map;

    NSMutableDictionary* _list_data;

    NSMutableArray *_ary_shopTitle;

    NSString* _str_instagram_url;
    NSString* _str_facebook_url;
    NSString* _str_twitter_url;
    NSString* _str_shop_url;
    NSString* _str_reserve_url;
}
@property (nonatomic, strong) NSString* str_shop_id;

- (IBAction)btn_insta:(id)sender;
- (IBAction)btn_facebook:(id)sender;
- (IBAction)btn_twitter:(id)sender;
- (IBAction)btn_web:(id)sender;
- (IBAction)btn_webReservation:(id)sender;
- (IBAction)btn_tel:(id)sender;
- (IBAction)btn_map:(id)sender;

@end
