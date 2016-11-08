//
//  MPHeaderShopView.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/4/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPShopObject.h"
#import "ManagerDownload.h"
#import <MapKit/MapKit.h>

// INSERTED BY ama 2016.10.08 START
// マイショップ登録ダイアログ
@protocol MPHeaderShopViewDelegate<NSObject>
- (void)delShop;
- (void)setShop;
@end
// INSERTED BY ama 2016.10.08 END

@interface MPHeaderShopView : UIView<MKMapViewDelegate, ManagerDownloadDelegate>
{
    MPShopObject *shopObject;
    IBOutlet UIImageView *imageShop;
    IBOutlet UILabel *accessShop;
    IBOutlet UIView *wrapView;
    IBOutlet MKMapView *_mapView;
    IBOutlet UILabel *header2;
    // INSERTED BY ama 2016.10.05 START
    // パラメータ追加
    long _lng_favorite;
    // INSERTED BY ama 2016.10.05 END
    
    // INSERTED BY ama 2016.10.08 START
    // お気に入りボタン変更
    __weak IBOutlet UIView *view_myshop;
    __weak IBOutlet UIImageView *img_shop;
    // INSERTED BY ama 2016.10.08 START
}
@property (nonatomic,assign) id<MPHeaderShopViewDelegate> delegate;

- (void)setData:(MPShopObject*)object;
// INSERTED BY ama 2016.10.05 START
// パラメータ追加
@property (nonatomic) long lng_favorite;
// INSERTED BY ama 2016.10.05 END

@property (weak, nonatomic) IBOutlet UILabel *lbl_myshop;

- (IBAction)myshop_push:(id)sender;
- (IBAction)tel_push:(id)sender;
- (IBAction)map_push:(id)sender;

@end
