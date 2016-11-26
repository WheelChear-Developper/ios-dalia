//
//  ManagerDownload.m
//  Oromo
//
//  Created by TUYENBQ on 10/16/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import "ManagerDownload.h"
#import "ManagerErrors.h"
#import "ProgressView.h"
#import "MPTabBarViewController.h"
#import "MPAppDelegate.h"
#import "Utility.h"

#import "MPTopImageObject.h"
#import "MPMenuTopinfoObject.h"
#import "MPMenuRecommend_itemObject.h"
#import "MPRecommend_menuObject.h"
#import "MPWhatNewsObject.h"






#import "MPMemberObject.h"

#import "MPNewHomeObject.h"
#import "MPCouponObject.h"
#import "MPMenuObject.h"
#import "MPItemObject.h"
#import "MPShopObject.h"
#import "MPApnsObject.h"

@implementation ManagerDownload
+ (ManagerDownload *)sharedInstance{
    static ManagerDownload *manager = nil;
    if (!manager) {
        manager = [[ManagerDownload alloc] init];
    }
    return manager;
}
- (id)init
{
    self = [super init];
    if (self) {
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 10;
        privateImageQueue = [[NSOperationQueue alloc] init];
        privateImageQueue.maxConcurrentOperationCount = 2;
        listRequest = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    exit(0);
}

#pragma mark - base Request
- (void)baseRequestJSON:(NSURLRequest *)request parameter:(DownloadParam *)parameter{
    
    if (![[MPAppDelegate sharedMPAppDelegate] networkStatus]) {
        [[ManagerErrors sharedInstance] alertNoNetwork];
        return;
    }
    if (![self canRequestNow:parameter]) {
        return;
    }
    [[ProgressView sharedInstance] progressWithTitle:@"Loading..." andView:[MPTabBarViewController sharedInstance].view andDelegate:nil];
    SEL fail = @selector(downloadDataFail:);
    SEL success = @selector(downloadDataSuccess:);
    AFJSONRequestOperation *oper = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // SUCCESS REQUEST
        parameter.http_code = response.statusCode;
        parameter.result_code = [[JSON objectForKey:@"error_code"] integerValue];
        
        //TODO: app will be disable
        if (parameter.result_code == APP_DISABLE) {
            if (!appDisable) {
                appDisable = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *exitAppAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"本アプリは運用を停止しました。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [exitAppAlertView show];
                });
                
                
            }
            
        }
        
        id obj = nil;
        obj = [JSON objectForKey:@"data"];

        
        NSArray *listObject;
        if ([obj isKindOfClass:[NSArray class]]) {
            listObject = obj;
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            listObject = [NSArray arrayWithObject:obj];
        }
        switch (parameter.request_type) {
            case RequestType_GET_DEFAULT_NOTIFICATION:
                //バッジ情報取得
                [self processDefaultNotification:listObject with:parameter];
                break;

            case RequestType_SUBMIT_DEVICE_ID:
                //デバイス登録
                [self processSetDeviceId:listObject with:parameter];
                break;

            case RequestType_GET_LIST_IMAGES:
                //トップスライドイメージ取得
                [self processListImage:listObject with:parameter];
                break;

            case RequestType_SET_SEND_MESSAGE:
                //お知らせ配信依頼
                break;
            case RequestType_GET_TOP_INFO:
                //トップ画面情報取得
                [self processGetTopInfo:listObject with:parameter];
                break;

            case RequestType_GET_LIST_COUPON:
                //クーポン取得
                [self processListCoupon:listObject with:parameter];
                break;

            case RequestType_GET_LIST_MESSAGES:
                //新着情報取得
                [self processListMessage:listObject with:parameter];
                break;


/*
            case RequestType_GET_MEMBER_INFO:
                [self processGetMemberInfo:listObject with:parameter];
                break;
                
            case RequestType_SET_MEMBER_INFO:
                [self processSetMemberInfo:listObject with:parameter];
                break;
                
            case RequestType_SUBMIT_DEVICE_TOKEN:
            case RequestType_ENABLE_NOTIFICATION:
                break;
                

                

                

            
            case RequestType_READ_MESSAGE:
                [self processReadMessage:listObject with:parameter];
                break;
                
            case RequestType_GET_LIST_MENU:
                [self processListMenu:listObject with:parameter];
                break;
                
            case RequestType_GET_DETAIL_MENU:
                [self processDetailMenu:listObject with:parameter];
                break;
                
            case RequestType_GET_LIST_LIKED_MENU:
                [self processListLikedMenu:listObject with:parameter];
                break;
                
            case RequestType_SET_LIKED_MENU:
                break;
                
            case RequestType_GET_LIST_CAT_SHOP:
                [self processListCatShop:listObject with:parameter];
                break;
                
            case RequestType_GET_DETAIL_SHOP:
                [self processDetailShop:listObject with:parameter];
                break;
                
            case RequestType_SET_FAVORITE_SHOP:
                break;
                
            case RequestType_DEL_FAVORITE_SHOP:
                break;
                
            case RequestType_SET_USE_COUPON:
                break;
                
            case RequestType_SET_REGIST_COUPON:
                
                break;
                
            case RequestType_SET_BIRTHDAY:
                break;
                
            case RequestType_GET_LIST_COUPON_SHARE:
                [self processListCouponShare:listObject with:parameter];
                break;
                
            case RequestType_GET_DETAIL_COUPON_SHARE:
                [self processDetailCouponShare:listObject with:parameter];
                break;
                
            case RequestType_GET_DETAIL_COUPON_STAMP:
                [self processDetailCouponStamp:listObject with:parameter];
                break;
                
            case RequestType_SET_STAMP:
                // REPLACED BY M.ama 2016.10.08 START
                // クーポン件数取得用更新
                [self processSetStamp:[JSON objectForKey:@"message"] withCurponCount:[Utility checkNIL:[Utility checkNULL:[obj objectForKey:@"coupon_count"]]] with:parameter];
                // REPLACED BY M.ama 2016.10.08 END
                break;
                
            case RequestType_RECOMMEND_PRODUCT:
                [self processRecommendProduct:listObject with:parameter];
                break;
                
            case RequestType_GET_LINK:
                [self processLink:listObject with:parameter];
                break;
                
            case RequestType_GET_BOOK_LINK:
                [self processBookLink:listObject with:parameter];
                break;
                
            case RequestType_GET_COMPANY:
                [self processGetCompany:listObject with:parameter];
                break;
            // INSERTED BY M.FUJII 2015.12.12 START
            // 電子スタンプ対応
            case RequestType_GET_TRANSFER_CODE:
                if ( [JSON[@"error_code"] integerValue] != 200 ){
                    listObject = nil;
                }
                [self processTransfer:listObject with:parameter];
                break;
            case RequestType_SET_TRANSFER_DIVESE:
                if ( [JSON[@"error_code"] integerValue] != 200 ){
                    listObject = nil;
                }
                [self processTransfer:listObject with:parameter];
                break;
            case RequestType_DEL_TRANSFER_CODE:
                if ( [JSON[@"error_code"] integerValue] != 200 ){
                    listObject = nil;
                }
                [self processTransfer:listObject with:parameter];
                break;
*/
            default:
                break;
        }
        
        
        if (parameter && parameter.delegate) {
            if ([parameter.delegate respondsToSelector:success]) {
                [parameter.delegate performSelectorOnMainThread:success withObject:parameter waitUntilDone:NO];
            }
        }
        [self removeCompleteRequest:parameter];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // FAIL REQUEST
        parameter.http_code = response.statusCode;
        parameter.result_code = [[JSON objectForKey:@"error_code"] integerValue];
        parameter.result_err_mes = [JSON objectForKey:@"message"];
        parameter.apple_error_code = error.code;
        [[ManagerErrors sharedInstance] errorRequestFromParameter:parameter];
        if (parameter.http_code != 0) {
            if (parameter && parameter.delegate) {
                if ([parameter.delegate respondsToSelector:fail]) {
                    [parameter.delegate performSelectorOnMainThread:fail withObject:parameter waitUntilDone:NO];
                }
            }
        }else {
                if (parameter && parameter.delegate) {
                    if ([parameter.delegate respondsToSelector:fail]) {
                        [parameter.delegate performSelectorOnMainThread:fail withObject:parameter waitUntilDone:NO];
                    }
                }
        }
        [self removeCompleteRequest:parameter];
    }];
    
    [queue addOperation:oper];
}

#pragma mark - manager request
- (BOOL)canRequestNow:(DownloadParam *)param{
    if ([listRequest containsObject:param]) {
        return NO;
    }
    [listRequest addObject:param];
    return YES;
}
- (void)removeCompleteRequest:(DownloadParam *)param{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([listRequest containsObject:param]) {
            [listRequest removeObject:param];
        }
        if ([listRequest count] == 0) {
            [[ProgressView sharedInstance] removeHUD];
        }
    });
}

#pragma mark - ACCESS API
- (void)getDefaultNotification:(NSString*)deviceID withAppID:(NSString*)appID delegate:(NSObject<ManagerDownloadDelegate>*) delegate{

    //バッジ情報取得
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];

    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_DEFAULT_NOTIFICATION];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_DEFAULT_NOTIFICATION];
    paramenter.delegate = delegate;
    
    strRequest = [NSString stringWithFormat:@"%@%@",strRequest,[Utility stringParamWithMethodHTTPGET:params moreParam:NO]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request setHTTPMethod:@"GET"];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void)getListImage:(NSString*)appID delegate:(NSObject<ManagerDownloadDelegate>*)delegate {

    //トップスライドイメージ取得
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_IMAGES];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_IMAGES];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void)setSendMessage:(long)member_mode member_ids:(NSArray*)member_ids send_mode:(long)send_mode postion:(long)postion title:(NSString*)title descliption:(NSString*)descliption image:(NSString*)image delegate:(NSObject<ManagerDownloadDelegate>*)delegate {

    //お知らせ配信依頼
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:[NSString stringWithFormat:@"%ld",member_mode] forKey:@"member_mode"];
    [params setValue:member_ids forKey:@"member_ids"];
    [params setValue:[NSString stringWithFormat:@"%ld",send_mode] forKey:@"send_mode"];
    [params setValue:[NSString stringWithFormat:@"%ld",postion] forKey:@"postion"];
    [params setValue:title forKey:@"title"];
    [params setValue:descliption forKey:@"descliption"];
    [params setValue:image forKey:@"image"];

    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_SEND_MESSAGE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_SEND_DEVICE];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];

}

- (void)getTopInfo:(NSString*)appID withDeviceID:(NSString*) deviceID delegate:(NSObject<ManagerDownloadDelegate>*)delegate {

    //トップ画面情報取得
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:appID forKey:@"app_id"];
    [params setValue:deviceID forKey:@"device_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_TOP_INFO];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_TOP_INFO];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void)getListCoupon:(NSString*)deviceID withAppID:(NSString*)appID delegate:(NSObject<ManagerDownloadDelegate>*) delegate
{
    //クーポン取得
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:appID forKey:@"app_id"];
    [params setValue:deviceID forKey:@"device_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_COUPON];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_COUPON];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void)getListMessage:(NSString*)deviceID withAppID:(NSString*)appID withLimit:(NSString *)limit delegate:(NSObject<ManagerDownloadDelegate> *)delegate
{
    //新着情報取得
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    [params setValue:limit forKey:@"limit"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_MESSAGES];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_MESSAGES];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}













/*

- (void) getMemberInfo: (NSString*) appID withDeviceID:(NSString*) deviceID delegate: (NSObject<ManagerDownloadDelegate>*) delegate {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:appID forKey:@"app_id"];
    [params setValue:deviceID forKey:@"device_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_MEMBER_INFO];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_MEMBER_INFO];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) setMemberInfo:(NSString*)userID withAppID:(NSString*)appID withMemberNO:(NSString*)memberNO withDeviceID:(NSString*)deviceID withNickName:(NSString*)nickName withGender:(long)gender withBirthday:(NSString*)birthday withZipcode:(NSString*)zipcode withChild1Name:(NSString*)child1name withChild1Birthday:(NSString*)child1birthday withChild2Name:(NSString*)child2name withChild2Birthday:(NSString*)child2birthday delegate: (NSObject<ManagerDownloadDelegate>*) delegate {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",userID] forKey:@"id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",memberNO] forKey:@"member_no"];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",nickName] forKey:@"nick_name"];
    [params setValue:[NSString stringWithFormat:@"%ld",gender] forKey:@"gender"];
    [params setValue:[NSString stringWithFormat:@"%@",birthday] forKey:@"birthday"];
    [params setValue:[NSString stringWithFormat:@"%@",zipcode] forKey:@"zipcode"];
    [params setValue:[NSString stringWithFormat:@"%@",child1name] forKey:@"child1_name"];
    [params setValue:[NSString stringWithFormat:@"%@",child1birthday] forKey:@"child1_birthday"];
    [params setValue:[NSString stringWithFormat:@"%@",child2name] forKey:@"child2_name"];
    [params setValue:[NSString stringWithFormat:@"%@",child2birthday] forKey:@"child2_birthday"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_MEMBER_INFO];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_MEMBER_INFO];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}





- (void) readMessage: (NSString*) deviceID withAppID: (NSString*) appID withMessageID: (NSString*) messageID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    [params setValue:messageID forKey:@"message_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_READ_MESSAGE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,READ_MESSAGE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getListMenu: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_MENU];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_MENU];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void)getListLikedMenu:(NSString *)deviceID withAppID:(NSString *)appID delegate:(NSObject<ManagerDownloadDelegate> *)delegate{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_LIKED_MENU];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_LIKED_MENU];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getDetailMenu: (NSString*) deviceID withAppID: (NSString*) appID withMenuID: (NSString*) menuID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    [params setValue:menuID forKey:@"menu_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_DETAIL_MENU];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_DETAIL_MENU];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getListCatShop: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:appID forKey:@"app_id"];
    [params setValue:deviceID forKey:@"device_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_CAT_SHOP];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_CAT_SHOP];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

// REPLACED BY ama 2016.10.05 START
// パラメータ追加
- (void) getDetailShop: (NSString*) appID withShopID: (NSString*) shopID withDeviceID:(NSString*)deviceID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    
    [params setValue:appID forKey:@"app_id"];
    [params setValue:shopID forKey:@"shop_id"];
    [params setValue:deviceID forKey:@"device_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_DETAIL_SHOP];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_DETAIL_SHOP];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
// REPLACED BY ama 2016.10.05 END

- (void) setFavoriteShop:(NSString*)appID withDeviceID:(NSString*)deviceID withShopID:(NSString*)shopID delegate: (NSObject<ManagerDownloadDelegate>*) delegate {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",shopID] forKey:@"shop_id"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_FAVORITE_SHOP];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_FAVORITE_SHOP];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

// INSERTED BY ama 2016.10.05 START
// お気に入り削除追加
- (void) delFavoriteShop:(NSString*)appID withDeviceID:(NSString*)deviceID withShopID:(NSString*)shopID delegate: (NSObject<ManagerDownloadDelegate>*) delegate {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",shopID] forKey:@"shop_id"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_DEL_FAVORITE_SHOP];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,DEL_FAVORITE_SHOP];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
// INSERTED BY ama 2016.10.05 END



- (void) getListCouponShare: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LIST_COUPON_SHARE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LIST_COUPON_SHARE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
- (void) getDetailCouponShare: (NSString*) deviceID withAppID: (NSString*) appID withCoupon:(MPCouponObject*) coupon delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    [params setValue:coupon.coupon_id forKey:@"coupon_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_DETAIL_COUPON_SHARE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_DETAIL_COUPON_SHARE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getDetailCouponStamp: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    //[params setValue:coupon.coupon_id forKey:@"coupon_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_DETAIL_COUPON_STAMP];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_DETAIL_COUPON_STAMP];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getRecommendProduct: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_RECOMMEND_PRODUCT];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,RECOMMENT_PRODUCT];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getLink: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_LINK];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_LINK];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
- (void) getBookLink: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_BOOK_LINK];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_BOOK_LINK];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) getCompany: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setValue:deviceID forKey:@"device_id"];
    [params setValue:appID forKey:@"app_id"];
    //[params setValue:coupon.coupon_id forKey:@"coupon_id"];
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_COMPANY];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_COMPANY];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
*/





#pragma mark - SUBMIT DATA
- (void)submitDeviceID:(NSString *)deviceID withAppID:(NSString *)appID withType:(NSString *)type delegate: (NSObject<ManagerDownloadDelegate>*) delegate {

    //デバイス登録
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",type] forKey:@"type"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SUBMIT_DEVICE_ID];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_DEVICE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}







- (void) submitDeviceToken: (NSString*) deviceToken withAppID: (NSString*) appID withDeviceID: (NSString*) deviceID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",deviceToken] forKey:@"device_token"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SUBMIT_DEVICE_TOKEN];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_DEVICE_TOKEN];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}


















/*

- (void) enableNotificationToDevice: (NSString*) deviceID withAppID: (NSString*) appID withReceived: (NSString*) received delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",received] forKey:@"recieved"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_ENABLE_NOTIFICATION];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_ENABLE_NOTIFICATION];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) submitLikedMenu: (NSString*) deviceID withAppID: (NSString*) appID withMenuID: (NSString*) menuID delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",menuID] forKey:@"menu_id"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_LIKED_MENU];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_LIKED_MENU];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) submitUseCoupon: (NSString*) deviceID withAppID: (NSString*) appID withCoupon: (MPCouponObject*) coupon delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",coupon.coupon_id] forKey:@"coupon_id"];
    [params setValue:[NSString stringWithFormat:@"%ld",coupon.coupon_type] forKey:@"coupon_type"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_USE_COUPON];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_USE_COUPON];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) submitRegistCoupon: (NSString*) deviceID withAppID: (NSString*) appID withCoupon: (MPCouponObject*) coupon delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",coupon.coupon_id] forKey:@"coupon_id"];
    [params setValue:[NSString stringWithFormat:@"%ld",coupon.coupon_type] forKey:@"coupon_type"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_REGIST_COUPON];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_REGIST_COUPON];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

- (void) submitBirthDay: (NSString*) deviceID withAppID: (NSString*) appID withBirthday: (NSString*) birthDay delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",birthDay] forKey:@"birthday"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_BIRTHDAY];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_BIRTHDAY];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}

// REPLACED BY ama 2016.10.05 START
// iBeacon識別追加
- (void) submitStamp: (NSString*) deviceID withAppID: (NSString*) appID withCoupon: (MPCouponObject*)coupon withCode:(NSString *)code withAmount:(NSString *)amount withUUID:(NSString *)uuid withMajor:(NSString *)major withMinor:(NSString *)minor delegate:(NSObject<ManagerDownloadDelegate> *)delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",coupon.coupon_id] forKey:@"coupon_id"];
    [params setValue:[NSString stringWithFormat:@"%@",code] forKey:@"coupon_code"];
    [params setValue:[NSString stringWithFormat:@"%@",amount] forKey:@"amount"];
    [params setValue:[NSString stringWithFormat:@"%@",uuid] forKey:@"uuid"];
    [params setValue:[NSString stringWithFormat:@"%@",major] forKey:@"major"];
    [params setValue:[NSString stringWithFormat:@"%@",minor] forKey:@"minor"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_STAMP];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_STAMP];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
// REPLACED BY ama 2016.10.05 END


*/



#pragma mark - process Data
- (void)processDefaultNotification:(NSArray *)listObject with:(DownloadParam *)param {

    //バッジ情報取得
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        MPApnsObject *object = [[MPApnsObject alloc] init];
        object.apns_cp = [Utility checkNULL:[dic objectForKey:@"coupon_count"]];
        object.apns_badge = [Utility checkNULL:[dic objectForKey:@"total"]];
        
        [param.listData addObject:object];
    }
}

- (void)processSetDeviceId:(NSArray *)listObject with:(DownloadParam *)param {

    //デバイス登録
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }

        NSLog(@"dic = %@", dic);
        [param.listData addObject:dic];
    }
}

- (void)processListImage:(NSArray *)listObject with:(DownloadParam *)param {

    //トップスライドイメージ取得
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        MPTopImageObject *topImageObj = [[MPTopImageObject alloc] init];
        topImageObj.topID = [Utility checkNULL:[dic objectForKey:@"id"]];
        topImageObj.topUrl = [Utility checkNULL:[dic objectForKey:@"image"]];
        topImageObj.topDesc = [Utility checkNULL:[dic objectForKey:@"description"]];
        topImageObj.linkUrl = [Utility checkNULL:[dic objectForKey:@"url"]];
        topImageObj.is_url_open = [[Utility checkNULL:[dic objectForKey:@"is_url_open"]] integerValue];
        topImageObj.is_News = [[Utility checkNULL:[dic objectForKey:@"is_new"]] integerValue];
        [param.listData addObject: topImageObj];
    }
}

- (void)processGetTopInfo:(NSArray *)listObject with:(DownloadParam *)param {

    //トップ画面情報取得
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }

        MPMenuTopinfoObject *topInfoObject = [[MPMenuTopinfoObject alloc] init];

        NSArray *ary_recommend_item = [Utility checkNULL:[dic objectForKey:@"recommend_item"]];
        NSArray *ary_recommend_menu = [Utility checkNULL:[dic objectForKey:@"recommend_menu"]];
        NSArray *ary_news = [Utility checkNULL:[dic objectForKey:@"news"]];

        for (long i = 0; i < ary_recommend_item.count; i ++) {

            MPMenuRecommend_itemObject *itemObject = [[MPMenuRecommend_itemObject alloc] init];
            itemObject.id = [Utility checkNULL:[[ary_recommend_item objectAtIndex:i] objectForKey:@"id"]];
            itemObject.title = [Utility checkNULL:[[ary_recommend_item objectAtIndex:i] objectForKey:@"title"]];
            itemObject.image = [Utility checkNULL:[[ary_recommend_item objectAtIndex:i] objectForKey:@"image"]];
            itemObject.brand_name = [Utility checkNULL:[[ary_recommend_item objectAtIndex:i] objectForKey:@"brand_name"]];
            itemObject.modified = [Utility checkNULL:[[ary_recommend_item objectAtIndex:i] objectForKey:@"modified"]];
            [topInfoObject.recommend_item addObject:itemObject];
        }

        for (long i = 0; i < ary_recommend_menu.count; i ++) {

            MPRecommend_menuObject *menuObject = [[MPRecommend_menuObject alloc] init];
            menuObject.id = [Utility checkNULL:[[ary_recommend_menu objectAtIndex:i] objectForKey:@"id"]];
            menuObject.title = [Utility checkNULL:[[ary_recommend_menu objectAtIndex:i] objectForKey:@"title"]];
            menuObject.image = [Utility checkNULL:[[ary_recommend_menu objectAtIndex:i] objectForKey:@"image"]];
            menuObject.content = [Utility checkNULL:[[ary_recommend_menu objectAtIndex:i] objectForKey:@"content"]];
            menuObject.thumbnail = [Utility checkNULL:[[ary_recommend_menu objectAtIndex:i] objectForKey:@"thumbnail"]];
            menuObject.updated_at = [Utility checkNULL:[[ary_recommend_menu objectAtIndex:i] objectForKey:@"updated_at"]];
            [topInfoObject.recommend_menu addObject:menuObject];
        }

        for (long i = 0; i < ary_news.count; i ++) {

            MPWhatNewsObject *newsObject = [[MPWhatNewsObject alloc] init];
            newsObject.id = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"id"]];
            newsObject.title = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"title"]];
            newsObject.content = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"content"]];
            newsObject.is_new = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"is_new"]];
            newsObject.is_read = [[Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"is_read"]] integerValue];
            newsObject.update_at = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"update_at"]];
            newsObject.isOptionPlus01 = [[Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"isOptionPlus01"]] integerValue];
            newsObject.position = [[Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"position"]] integerValue];
            newsObject.image = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"image"]];
            newsObject.thumbnail = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"thumbnail"]];
            newsObject.wp_url = [Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"wp_url"]];
            newsObject.wp_flg = [[Utility checkNULL:[[ary_news objectAtIndex:i] objectForKey:@"wp_flg"]] integerValue];
            [topInfoObject.news addObject:newsObject];
        }
        [param.listData addObject: topInfoObject];
    }
}

- (void)processListCoupon:(NSArray *)listObject with:(DownloadParam *)param{

    //クーポン取得
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }

        MPCouponObject *couponObj = [[MPCouponObject alloc] init];
        couponObj.id = [Utility checkNULL:[dic objectForKey:@"id"]];
        couponObj.name = [Utility checkNULL:[dic objectForKey:@"name"]];
        couponObj.is_due_date = [[Utility checkNULL:[dic objectForKey:@"is_due_date"]] integerValue];
        couponObj.due_date = [Utility checkNULL:[dic objectForKey:@"due_date"]];
        couponObj.limit_num = [[Utility checkNULL:[dic objectForKey:@"limit_num"]] integerValue];
        couponObj.condition = [Utility checkNULL:[dic objectForKey:@"condition"]];
        couponObj.coupon_image = [Utility checkNULL:[dic objectForKey:@"coupon_image"]];
        couponObj.tokuten_mode = [[Utility checkNULL:[dic objectForKey:@"tokuten_mode"]] integerValue];
        couponObj.percentage = [[Utility checkNULL:[dic objectForKey:@"percentage"]] integerValue];
        couponObj.original_price = [[Utility checkNULL:[dic objectForKey:@"original_price"]] integerValue];
        couponObj.open_price = [[Utility checkNULL:[dic objectForKey:@"open_price"]] integerValue];
        couponObj.tokuten_free_word = [Utility checkNULL:[dic objectForKey:@"tokuten_free_word"]];
        couponObj.coupon_type = [[Utility checkNULL:[dic objectForKey:@"coupon_type"]] integerValue];
        couponObj.is_birthday = [[Utility checkNULL:[dic objectForKey:@"is_birthday"]] integerValue];
        couponObj.tokuten_detail = [Utility checkNULL:[dic objectForKey:@"tokuten_detail"]];
        couponObj.created_at = [Utility checkNULL:[dic objectForKey:@"created_at"]];
        [param.listData addObject:couponObj];
    }
}

- (void) processListMessage:(NSArray *)listObject with:(DownloadParam *)param{

    //新着情報取得
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        MPNewHomeObject *newObj = [[MPNewHomeObject alloc] init];
        newObj.id = [Utility checkNULL:[dic objectForKey:@"id"]];
        newObj.title = [Utility checkNULL:[dic objectForKey:@"title"]];
        newObj.content = [Utility checkNULL:[dic objectForKey:@"content"]];
        newObj.is_new = [[Utility checkNULL:[dic objectForKey:@"is_new"]] integerValue];
        newObj.is_read = [[Utility checkNULL:[dic objectForKey:@"is_read"]] integerValue];
        newObj.update_at = [Utility checkNULL:[dic objectForKey:@"updated_at"]];
        newObj.isOptionPlus01 = [[Utility checkNULL:[dic objectForKey:@"isOptionPlus01"]] boolValue];
        newObj.position = [[Utility checkNULL:[dic objectForKey:@"position"]] integerValue];
        newObj.image = [Utility checkNULL:[dic objectForKey:@"image"]];
        newObj.thumbnail = [Utility checkNULL:[dic objectForKey:@"thumbnail"]];
        newObj.wp_url = [Utility checkNULL:[dic objectForKey:@"wp_url"]];
        newObj.wp_flg = [[Utility checkNULL:[dic objectForKey:@"wp_flg"]] intValue];

        [param.listData addObject: newObj];
    }
}








/*

- (void) processGetMemberInfo:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        MPMemberObject *memberInfoObj = [[MPMemberObject alloc] init];
        memberInfoObj.id = [Utility checkNULL:[dic objectForKey:@"id"]];
        memberInfoObj.app_id = [Utility checkNULL:[dic objectForKey:@"app_id"]];
        memberInfoObj.member_no = [Utility checkNULL:[dic objectForKey:@"member_no"]];
        memberInfoObj.device_id = [Utility checkNULL:[dic objectForKey:@"device_id"]];
        memberInfoObj.nick_name = [Utility checkNULL:[dic objectForKey:@"nick_name"]];
        memberInfoObj.gender = [[Utility checkNULL:[dic objectForKey:@"gender"]] integerValue];
        memberInfoObj.birthday = [Utility checkNULL:[dic objectForKey:@"birthday"]];
        memberInfoObj.zipcode = [Utility checkNULL:[dic objectForKey:@"zipcode"]];
        memberInfoObj.child1_name = [Utility checkNULL:[dic objectForKey:@"child1_name"]];
        memberInfoObj.child1_birthday = [Utility checkNULL:[dic objectForKey:@"child1_birthday"]];
        memberInfoObj.child2_name = [Utility checkNULL:[dic objectForKey:@"child2_name"]];
        memberInfoObj.child2_birthday = [Utility checkNULL:[dic objectForKey:@"child2_birthday"]];
        [param.listData addObject: memberInfoObj];
    }
}

- (void) processSetMemberInfo:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        MPMemberObject *memberInfoObj = [[MPMemberObject alloc] init];
        [param.listData addObject: memberInfoObj];
    }
}



- (void) processReadMessage:(NSArray *)listObject with:(DownloadParam *)param{
    
}

- (void) processListMenu:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        NSArray *cateArr = [Utility checkNULL:[dic objectForKey:@"cat"]];
        for (long i = 0; i < cateArr.count; i ++) {
            MPMenuObject *menuObject = [[MPMenuObject alloc] init];
            menuObject.style = [[Utility checkNULL:[dic objectForKey:@"format_menu"]] integerValue];
            menuObject.category = [Utility checkNULL:[[cateArr objectAtIndex:i] objectForKey:@"category"]];
            menuObject.order_by = [Utility checkNULL:[[cateArr objectAtIndex:i] objectForKey:@"order_by"]];
            NSArray *itemArr = [Utility checkNULL:[[cateArr objectAtIndex:i] objectForKey:@"menu"]];
            for (long j = 0; j < itemArr.count; j ++) {
                MPItemObject *itemObject = [[MPItemObject alloc] init];
                itemObject.id = [Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"id"]];
                itemObject.title = [Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"title"]];
                itemObject.content =  [Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"content"]];
                itemObject.price = [Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"price"]];
                itemObject.image = [Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"image"]];
                itemObject.thumbnail = [Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"thumbnail"]];
                itemObject.order_by = [[Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"order_by"]] integerValue];
                NSLog(@"%@",[Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"liked"]]);
                itemObject.likedd = [[Utility checkNULL:[[itemArr objectAtIndex:j] objectForKey:@"liked"]] integerValue];
                [menuObject.item addObject:itemObject];
            }
            [param.listData addObject:menuObject];
        }
    }
}

- (void) processDetailMenu:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        
        MPItemObject *itemObject = [[MPItemObject alloc] init];
        itemObject.id = [Utility checkNULL:[dic objectForKey:@"id"]];
        itemObject.title = [Utility checkNULL:[dic objectForKey:@"title"]];
        itemObject.content =  [Utility checkNULL:[dic objectForKey:@"content"]];
        itemObject.price = [Utility checkNULL:[dic objectForKey:@"price"]];
        itemObject.image = [Utility checkNULL:[dic objectForKey:@"image"]];
        itemObject.likedd = [[Utility checkNULL:[dic objectForKey:@"liked"]] integerValue];
        [param.listData addObject:itemObject];
        
    }
}


- (void) processListLikedMenu:(NSArray *)listObject with:(DownloadParam *)param{
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        NSArray *menuLiked = [dic objectForKey:@"menulike"];
        
        for(long j = 0; j < menuLiked.count; j ++) {
            MPItemObject *itemObject = [[MPItemObject alloc] init];
            itemObject.id = [Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"id"]];
            itemObject.title = [Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"title"]];
            itemObject.content =  [Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"content"]];
            itemObject.price = [Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"price"]];
            itemObject.image = [Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"image"]];
            itemObject.thumbnail = [Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"thumbnail"]];
            itemObject.order_by = [[Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"order_by"]] integerValue];
            itemObject.likedd = [[Utility checkNULL:[[menuLiked objectAtIndex:j] objectForKey:@"liked"]] integerValue];
            [param.listData addObject:itemObject];
        }
    }
}

- (void) processListCatShop:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        [param.listData addObject:listObject];
    }
}

- (void) processDetailShop:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        MPShopObject *shopObj = [[MPShopObject alloc] init];
        shopObj.id = [dic objectForKey:@"id"];
        shopObj.shop_name = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"shop_name"]]] ;
        shopObj.image = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"image"]]];
        //▽ 2016年9月29日 項目追加
        shopObj.postcode1 = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"postcode1"]]];
        shopObj.postcode2 = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"postcode1"]]];
        //△ 2016年9月29日 項目追加
        shopObj.address = [NSString stringWithFormat:@"%@ %@",[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"address1"]]],[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"address2"]]]];
        shopObj.latitude = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"latitude"]]];
        shopObj.longitude = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"longitude"]]];
        shopObj.business_hour = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"business_hour"]]];
        shopObj.regular_holiday = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"regular_holiday"]]];
        shopObj.access_method = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"access_method"]]];
        shopObj.seat_number = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"seat_number"]]];
        shopObj.parking = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"parking"]]];
        shopObj.phone = [NSString stringWithFormat:@"%@-%@-%@",[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"phone1"]]],[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"phone2"]]],[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"phone3"]]]];
        shopObj.responsible_person = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"responsible_person"]]];
        shopObj.other_title = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"other_title"]]];
        shopObj.other_content = [Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"other_content"]]];
        // INSERTED BY ama 2016.10.05 START
        // お気に入り状態追加
        shopObj.favorite = [[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"favorite"]]] integerValue];
        // INSERTED BY ama 2016.10.05 END
        [param.listData addObject:shopObj];
    }
}



- (void) processListCouponShare:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        MPCouponObject *couponObj = [[MPCouponObject alloc] init];
        couponObj.coupon_id = [Utility checkNULL:[dic objectForKey:@"id"]];
        couponObj.coupon_name = [Utility checkNULL:[dic objectForKey:@"name"]];
        couponObj.limit_date = [[Utility checkNULL:[dic objectForKey:@"limit_date"]] integerValue];
        couponObj.is_due_date = [[Utility checkNULL:[dic objectForKey:@"is_due_date"]] integerValue];
        couponObj.due_date = [Utility checkNULL:[dic objectForKey:@"due_date"]];
        couponObj.limit_num = [[Utility checkNULL:[dic objectForKey:@"limit_num"]] integerValue];
        couponObj.condition = [Utility checkNULL:[dic objectForKey:@"condition"]];
        couponObj.share_content = [Utility checkNULL:[dic objectForKey:@"share_content"]];
        
        // INSERT START 2015.01.16
        // INSERTED BY M.FUJII
        // ADD OPTION9 (LINE連携追加)
        couponObj.is_share_line = [Utility checkNULL:[dic objectForKey:@"is_share_line"] ];
        // INSERT END 2015.01.16
        
        [param.listData addObject:couponObj];
    }
}

- (void) processDetailCouponShare:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        NSLog(@"%@,%@",[dic objectForKey:@"session_id"],[dic objectForKey:@"usage"]);
        
        [param.listData addObject: dic];
    }
}

// REPLACED BY M.ama 2016.10.08 START
// クーポン件数取得用更新
- (void) processSetStamp: (NSString*) message withCurponCount:(NSString*)count with: (DownloadParam*) param{
    
    NSMutableDictionary *dic_data = [[NSMutableDictionary alloc] init];
    [dic_data setObject:message forKey:@"message"];
    [dic_data setObject:count forKey:@"count"];
    [param.listData addObject:dic_data];
}
// REPLACED BY M.ama 2016.10.08 END

- (void) processDetailCouponStamp:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        MPCouponObject *couponObj = [[MPCouponObject alloc] init];
        couponObj.coupon_id = [Utility checkNULL:[dic objectForKey:@"id"]];
        couponObj.coupon_name = [Utility checkNULL:[dic objectForKey:@"name"]];
        couponObj.status = [Utility checkNULL:[dic objectForKey:@"status"]];
        couponObj.is_due_date = [[Utility checkNULL:[dic objectForKey:@"is_due_date"]] integerValue];
        couponObj.due_date = [Utility checkNULL:[dic objectForKey:@"due_date"]];
        couponObj.due_date_format  = [Utility checkNULL:[dic objectForKey:@"due_date_format"]];
        couponObj.stamp_num = [[Utility checkNULL:[dic objectForKey:@"stamp_num"]] integerValue];
        couponObj.condition = [Utility checkNULL:[dic objectForKey:@"condition"]];
        couponObj.stamp_condition = [Utility checkNULL:[dic objectForKey:@"stamp_condition"]];
        couponObj.stamp_date_set = [Utility checkNULL:[dic objectForKey:@"stamp_date_set"]];
        couponObj.is_limit_stamp = [Utility checkNULL:[dic objectForKey:@"is_limit_stamp"]];
        // INSERTED BY M.FUJII 2015.12.11 START
        // 電子スタンプ機能実装
        couponObj.stamp_devices = [Utility checkNULL:[dic objectForKey:@"stamp_devices"]];
        // INSERTED BY M.FUJII 2015.12.11 END
        
        // INSERTED BY ama 2016.10.05 START
        // ランク用カラー設定
        couponObj.rank_color = [Utility checkNULL:[dic objectForKey:@"rank_color"]];
        // INSERTED BY ama 2016.10.05 END

        [param.listData addObject:couponObj];
    }
}

- (void) processRecommendProduct:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        MPItemObject *itemObj = [[MPItemObject alloc] init];
        
        itemObj.id = [Utility checkNULL:[dic objectForKey:@"id"]];
        itemObj.title = [Utility checkNULL:[dic objectForKey:@"title"]];
        itemObj.content = [Utility checkNULL:[dic objectForKey:@"content"]];
        itemObj.price = [Utility checkNULL:[dic objectForKey:@"price"]];
        itemObj.image = [Utility checkNULL:[dic objectForKey:@"image"]];
        itemObj.thumbnail = [Utility checkNULL:[dic objectForKey:@"thumbnail"]];
        itemObj.order_by = [[Utility checkNULL:[dic objectForKey:@"order_by"]] integerValue];
        itemObj.likedd = [[Utility checkNULL:[dic objectForKey:@"liked"]] integerValue];
        [param.listData addObject:itemObj];
    }
}

- (void) processLink:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
//        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
//            return;
//        }
        
        [param.listData addObject:[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"home_page"]]]];
    }
}

- (void) processBookLink:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        //        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
        //            return;
        //        }
        
        [param.listData addObject:[Utility checkNIL:[Utility checkNULL:[dic objectForKey:@"book_url"]]]];
    }
}

- (void) processGetCompany:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        NSLog(@"%@,%@",[dic objectForKey:@"session_id"],[dic objectForKey:@"usage"]);
        
        [param.listData addObject: dic];
    }
}
// INSERTED BY M.FUJII 2015.12.12 START
// 電子スタンプ実装
- (void) getTransferCode: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_GET_TRANSFER_CODE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,GET_TRANSFER_CODE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
- (void) setTransferDevice: (NSString*) deviceID withAppID: (NSString*) appID transfer_code: (NSString*) transfer_code delegate: (NSObject<ManagerDownloadDelegate>*) delegate
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    [params setValue:[NSString stringWithFormat:@"%@",transfer_code] forKey:@"transfer_code"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_SET_TRANSFER_DIVESE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,SET_TRANSFER_DEVICE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
- (void) delTransferCode: (NSString*) deviceID withAppID: (NSString*) appID delegate: (NSObject<ManagerDownloadDelegate>*) delegate{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@",deviceID] forKey:@"device_id"];
    [params setValue:[NSString stringWithFormat:@"%@",appID] forKey:@"app_id"];
    
    DownloadParam *paramenter = [[DownloadParam alloc] initWithType:RequestType_DEL_TRANSFER_CODE];
    paramenter.delegate = delegate;
    NSString *strRequest = @"";
    strRequest = [NSString stringWithFormat:BASE_URL,DEL_TRANSFER_DEVICE];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strRequest] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [Utility setParamWithMethodPost:params forRequest:request];
    [self baseRequestJSON:request parameter:paramenter];
}
- (void) processTransfer:(NSArray *)listObject with:(DownloadParam *)param{
    
    for (NSDictionary *dic in listObject) {
        if ([dic isKindOfClass:[NSString class]]||[dic isKindOfClass:[NSNull class]]) {
            return;
        }
        
        NSLog(@"dic = %@", dic);
        [param.listData addObject:dic];
        
    }
}
*/

@end
