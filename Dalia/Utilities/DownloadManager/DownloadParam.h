//
//  DownloadParam.h
//  Oromo
//
//  Created by TUYENBQ on 10/16/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

// REPLACED BY ama 2016.10.05 START
// お気に入り削除追加
typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_GET_DEFAULT_NOTIFICATION,
    RequestType_SUBMIT_DEVICE_ID,
    RequestType_GET_LIST_IMAGES,
    RequestType_SET_SEND_MESSAGE,
    RequestType_GET_TOP_INFO,
    RequestType_GET_LIST_COUPON,
    RequestType_GET_LIST_SHOP,
    RequestType_GET_LIST_RECOMMENMENU,
    RequestType_GET_MEMBER_INFO,
    RequestType_SET_MEMBER_INFO,
    RequestType_GET_MEMBER_CARD,





    

    RequestType_SUBMIT_DEVICE_TOKEN,
    RequestType_ENABLE_NOTIFICATION,

    RequestType_GET_LIST_MESSAGES,
    RequestType_READ_MESSAGE,
    RequestType_GET_LIST_MENU,
    RequestType_GET_DETAIL_MENU,
    RequestType_GET_LIST_LIKED_MENU,
    RequestType_SET_LIKED_MENU,
    RequestType_GET_LIST_CAT_SHOP,
    RequestType_GET_DETAIL_SHOP,
    RequestType_SET_FAVORITE_SHOP,
    RequestType_DEL_FAVORITE_SHOP,

    RequestType_SET_USE_COUPON,
    RequestType_SET_REGIST_COUPON,
    RequestType_SET_BIRTHDAY,
    RequestType_GET_LIST_COUPON_SHARE,
    RequestType_GET_DETAIL_COUPON_SHARE,
    RequestType_GET_DETAIL_COUPON_STAMP,
    RequestType_SET_STAMP,
    RequestType_RECOMMEND_PRODUCT,
    RequestType_GET_LINK,
    RequestType_GET_BOOK_LINK,
    RequestType_GET_COMPANY,
    RequestType_GET_TRANSFER_CODE,
    RequestType_SET_TRANSFER_DIVESE,
    RequestType_DEL_TRANSFER_CODE
};
// REPLACED BY ama 2016.10.05 END

@protocol ManagerDownloadDelegate;
@interface DownloadParam : NSObject
@property (nonatomic) long http_code;
@property (nonatomic) long result_code;
@property (nonatomic) long apple_error_code;

//confusing
@property (nonatomic, strong) NSString *dobCoupon;

@property (nonatomic, strong) NSString *result_err_mes;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) NSDictionary *listParam;
@property (nonatomic) RequestType request_type;
@property (nonatomic, assign) NSObject<ManagerDownloadDelegate> *delegate;

- (id)initWithType:(RequestType)type;
@end

@protocol ManagerDownloadDelegate <NSObject>
@optional
- (void)downloadDataSuccess:(DownloadParam *)param;
- (void)downloadDataFail:(DownloadParam *)param;
@end
