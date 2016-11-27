//
//  MPTheFourthViewController.h
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"
#import "ManagerDownload.h"
#import "ShopListViewCell.h"

@interface MPTheFourthViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate, MKMapViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;

    __weak IBOutlet UIView *_img_photo;
    __weak IBOutlet UILabel *_lbl_shopName;
    __weak IBOutlet UILabel *_lbl_subShopName;

    __weak IBOutlet UILabel *_lbl_zipcode;
    __weak IBOutlet UILabel *_lbl_adress;
    __weak IBOutlet UILabel *_lbl_tel;
    __weak IBOutlet UILabel *_lbl_bisinessHour;
    __weak IBOutlet UILabel *_lbl_parking;
    __weak IBOutlet UILabel *_lbl_memo;
    __weak IBOutlet MKMapView *_map;
    __weak IBOutlet UITableView *_tbl_shopList;

    NSMutableArray* _list_data;

    NSMutableArray *_ary_shopTitle;
}
- (IBAction)btn_insta:(id)sender;
- (IBAction)btn_facebook:(id)sender;
- (IBAction)btn_twitter:(id)sender;
- (IBAction)btn_web:(id)sender;
- (IBAction)btn_webReservation:(id)sender;
- (IBAction)btn_tel:(id)sender;
- (IBAction)btn_map:(id)sender;

@end
