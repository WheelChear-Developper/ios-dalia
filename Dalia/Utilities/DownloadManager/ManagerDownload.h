//
//  ManagerDownload.h
//  Oromo
//
//  Created by TUYENBQ on 10/16/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadParam.h"
#import "AFJSONRequestOperation.h"
#import "MPCouponObject.h"

@interface ManagerDownload : NSObject<UIAlertViewDelegate>
{
    NSOperationQueue *queue;
    NSOperationQueue *privateImageQueue;
    NSMutableArray *listRequest;
    BOOL appDisable;
}
+ (ManagerDownload *)sharedInstance;

#pragma mark - ACCESS API
//バッジ情報取得
- (void)getDefaultNotification:(NSString*)deviceID withAppID:(NSString*)appID delegate:(NSObject<ManagerDownloadDelegate>*)delegate;
//トップスライドイメージ取得
- (void)getListImage:(NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
//お知らせ配信依頼
- (void)setSendMessage:(long)member_mode member_ids:(NSArray*)member_ids send_mode:(long)send_mode postion:(long)postion title:(NSString*)title descliption:(NSString*)descliption image:(NSString*)image delegate:(NSObject<ManagerDownloadDelegate>*)delegate;









- (void) getMemberInfo:(NSString*)appID withDeviceID:(NSString*)deviceID delegate:(NSObject<ManagerDownloadDelegate>*) delegate;
- (void) setMemberInfo:(NSString*)userID withAppID:(NSString*)appID withMemberNO:(NSString*)memberNO withDeviceID:(NSString*)deviceID withNickName:(NSString*)nickName withGender:(long)gender withBirthday:(NSString*)birthday withZipcode:(NSString*)zipcode withChild1Name:(NSString*)child1name withChild1Birthday:(NSString*)child1birthday withChild2Name:(NSString*)child2name withChild2Birthday:(NSString*)child2birthday delegate: (NSObject<ManagerDownloadDelegate>*) delegate;


- (void) getListMessage: (NSString*) deviceID withAppID: (NSString*) appID withLimit: (NSString*) limit delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) readMessage: (NSString*) deviceID withAppID: (NSString*) appID withMessageID: (NSString*) messageID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getListMenu: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getListLikedMenu: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getDetailMenu: (NSString*) deviceID withAppID: (NSString*) appID withMenuID: (NSString*) menuID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getListCatShop: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
// REPLACED BY ama 2016.10.05 START
// パラメータ追加
- (void) getDetailShop: (NSString*) appID withShopID: (NSString*) shopID withDeviceID:(NSString*)deviceID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
// REPLACED BY ama 2016.10.05 END
- (void) setFavoriteShop:(NSString*)appID withDeviceID:(NSString*)deviceID withShopID:(NSString*)shopID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
// INSERTED BY ama 2016.10.05 START
// お気に入り削除追加
- (void) delFavoriteShop:(NSString*)appID withDeviceID:(NSString*)deviceID withShopID:(NSString*)shopID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
// INSERTED BY ama 2016.10.05 END
- (void) getListCoupon: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getListCouponShare: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getDetailCouponShare: (NSString*) deviceID withAppID: (NSString*) appID withCoupon:(MPCouponObject*) coupon delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getDetailCouponStamp: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getRecommendProduct: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getLink: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getBookLink: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getCompany: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) getTransferCode: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) setTransferDevice: (NSString*) deviceID withAppID: (NSString*) appID transfer_code: (NSString*) transfer_code delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) delTransferCode: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;




#pragma mark - SUBMIT DATA TO SERVER
//デバイス登録
- (void)submitDeviceID:(NSString*)deviceID withAppID:(NSString*)appID withType:(NSString*)type delegate:(NSObject<ManagerDownloadDelegate>*)delegate;










- (void) submitDeviceToken: (NSString*) deviceToken withAppID: (NSString*) appID withDeviceID: (NSString*) deviceID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) enableNotificationToDevice: (NSString*) deviceID withAppID: (NSString*) appID withReceived: (NSString*) received delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) submitLikedMenu: (NSString*) deviceID withAppID: (NSString*) appID withMenuID: (NSString*) menuID delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) submitUseCoupon: (NSString*) deviceID withAppID: (NSString*) appID withCoupon: (MPCouponObject*) coupon delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) submitRegistCoupon: (NSString*) deviceID withAppID: (NSString*) appID withCoupon: (MPCouponObject*) coupon delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
- (void) submitBirthDay: (NSString*) deviceID withAppID: (NSString*) appID withBirthday: (NSString*) birthDay delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
// REPLACED BY ama 2016.10.05 START
// iBeacon識別追加
- (void) submitStamp: (NSString*) deviceID withAppID: (NSString*) appID withCoupon: (MPCouponObject*) coupon withCode: (NSString*) code withAmount:(NSString *)amount withUUID:(NSString *)uuid withMajor:(NSString *)major withMinor:(NSString *)minor delegate: (NSObject<ManagerDownloadDelegate>*) delegate;
// REPLACED BY ama 2016.10.05 END

@end
