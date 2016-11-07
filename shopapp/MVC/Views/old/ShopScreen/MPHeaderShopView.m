//
//  MPHeaderShopView.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/4/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPHeaderShopView.h"
#import "CustomColor.h"
#import "MPShopDetaillView.h"
#import "MPUIConfigObject.h"

#define BONUS_HEIGHT 20
#define METERS_PER_MILE 1609.344

@implementation MPHeaderShopView

// INSERTED BY ama 2016.10.05 START
// パラメータ追加
@synthesize lng_favorite = _lng_favorite;
// INSERTED BY ama 2016.10.05 END

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [header2 setText:[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab4] objectForKey:@"titleHederDetail2"]];
}

- (void)setData:(MPShopObject *)object {
    
    shopObject = object;
    
    //店舗画像セット
    if (!shopObject.image || [shopObject.image isEqualToString:@""]) {
        
        UIImage *image = nil;
        image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
        [imageShop setBackgroundColor:[UIColor whiteColor]];
        [imageShop setImage:image];
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSLog(@"image: %@",shopObject.image);
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,shopObject.image]]];
            [self performSelectorOnMainThread:@selector(setImage:) withObject:data waitUntilDone:YES];
            
        });
    }
    
    //マイショップ設定
    // REPLACED BY ama 2016.10.05 START
    // パラメータ名変更
    [self setShopFlg:shopObject.favorite];
    // REPLACED BY ama 2016.10.05 END
    
    //apple mapセット
    CLLocationCoordinate2D zoomLocation;
    NSString *shopLatitue = [NSString stringWithFormat:@"%@",shopObject.latitude];
    NSString *shopLongtitue = [NSString stringWithFormat:@"%@",shopObject.longitude];
    zoomLocation.latitude = [shopLatitue doubleValue];
    zoomLocation.longitude= [shopLongtitue doubleValue];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:zoomLocation];
    
    //    [annotation setTitle:[NSString stringWithFormat:@"%@\n%@",[Utility checkNIL:shopObject.address],[Utility checkNIL:shopObject.access_method]]];
    [_mapView addAnnotation:annotation];
    
    [_mapView setRegion:viewRegion animated:YES];

//    [webView loadHTMLString:[NSString stringWithFormat:MAP_VIEW_IFRAME,
//                             [NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&output=embed&iwloc=0",
//                              shopObject.latitude,shopObject.longitude]]
//                    baseURL:nil];
    
    [accessShop setText:[NSString stringWithFormat:@"%@\n%@",[Utility checkNIL:shopObject.address],[Utility checkNIL:shopObject.access_method]]];
    
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&iwloc=0",shopObject.latitude,shopObject.longitude]]]];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&output=embed&iwloc=0",shopObject.latitude,shopObject.longitude]]]];
}

- (void)setShopFlg:(BOOL)flg {
    
    //マイショップ設定
    if(flg){
        
        self.lbl_myshop.text = @"マイショップ登録済み";
        // INSERTED BY ama 2016.10.08 START
        // お気に入りボタン変更
        self.lbl_myshop.textColor = [UIColor colorWithRed:247/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        view_myshop.backgroundColor = [UIColor colorWithRed:113/255.0 green:112/255.0 blue:113/255.0 alpha:1.0];
        UIImage *img_toppics = [UIImage imageNamed:@"icon_shop_on.png"];
        [img_shop setImage:img_toppics];
        // INSERTED BY ama 2016.10.08 START

        // REPLACED BY ama 2016.10.05 START
        // パラメータ名変更
        shopObject.favorite = NO;
        // REPLACED BY ama 2016.10.05 END
    }else{
        
        self.lbl_myshop.text = @"マイショップに登録";
        // INSERTED BY ama 2016.10.08 START
        // お気に入りボタン変更
        self.lbl_myshop.textColor = [UIColor colorWithRed:113/255.0 green:112/255.0 blue:113/255.0 alpha:1.0];
        view_myshop.backgroundColor = [UIColor colorWithRed:247/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        UIImage *img_toppics = [UIImage imageNamed:@"icon_shop_off.png"];
        [img_shop setImage:img_toppics];
        // INSERTED BY ama 2016.10.08 START
        
        // REPLACED BY ama 2016.10.05 START
        // パラメータ名変更
        shopObject.favorite = YES;
        // REPLACED BY ama 2016.10.05 END
    }
}

- (void)setImage:(NSData*)data {
    
    UIImage *image = nil;
    if (data) {
        image = [UIImage imageWithData:data];
    }else{
        image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
    }
    [imageShop setBackgroundColor:[UIColor whiteColor]];
    [imageShop setImage:image];
}

- (IBAction)myshop_push:(id)sender {
    
    //マイショップ設定
    // REPLACED BY ama 2016.10.05 START
    // パラメータ名変更
    [self setShopFlg:shopObject.favorite];
    // REPLACED BY ama 2016.10.05 END
    
    // REPLACED BY ama 2016.10.05 START
    //マイショップフラグセット
    if(shopObject.favorite){
        
        [[ManagerDownload sharedInstance] delFavoriteShop:[Utility getAppID] withDeviceID:[Utility getDeviceID] withShopID:shopObject.id delegate:self];
        
        // INSERTED BY ama 2016.10.08 START
        // マイショップ登録ダイアログ
        [self.delegate delShop];
        // INSERTED BY ama 2016.10.08 END

    }else{
        
        [[ManagerDownload sharedInstance] setFavoriteShop:[Utility getAppID] withDeviceID:[Utility getDeviceID] withShopID:shopObject.id delegate:self];
        
        // INSERTED BY ama 2016.10.08 START
        // マイショップ登録ダイアログ
        [self.delegate setShop];
        // INSERTED BY ama 2016.10.08 END

    }
    
    // REPLACED BY ama 2016.10.05 END
}

- (IBAction)tel_push:(id)sender {
    
    NSString *theCall = [NSString stringWithFormat:@"telprompt://%@",shopObject.phone];
    
    NSString *theNewCall = [theCall stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theNewCall]];
}

- (IBAction)map_push:(id)sender {
    
    //    add Google Map
    //    [NSString stringWithFormat:MAP_VIEW_IFRAME,[NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&output=embed&iwloc=0",shopObject.latitude,shopObject.longitude]];
    //    // https://www.google.com/maps/embed/v1/MODE?key=API_KEY&parameters
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.google.com/maps?q=%@,%@&iwloc=0",shopObject.latitude,shopObject.longitude]]];
    //    add Apple Map
    [NSString stringWithFormat: MAP_VIEW_IFRAME,[NSString stringWithFormat:@"https://maps.apple.com/maps?q=%@,%@&output=embed&iwloc=0",shopObject.latitude,shopObject.longitude]];
    // https://www.google.com/maps/embed/v1/MODE?key=API_KEY&parameters
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.apple.com/maps?q=%@,%@&iwloc=0",shopObject.latitude,shopObject.longitude]]];
}

- (void)dealloc {
    
    _mapView.delegate = nil;
}

@end
