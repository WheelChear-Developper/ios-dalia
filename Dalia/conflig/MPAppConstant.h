//
//  MPAppConstant.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#ifndef Misepuri_MPAppConstant_h
#define Misepuri_MPAppConstant_h

#define APP_DISABLE 203 // when error_code = 203 then App will be disable
//===========
#define NO_LIST_COUPON_MESSAGE @"現在、発行しているクーポンはありません。"
#define NO_LIST_MENU_MESSAGE @"現在、メニューはありません。"
#define NO_LIST_SHOP_MESSAGE @"現在、店舗はありません。"
#define NO_RECOMMEND_PRODUCT_MESSAGE @"現在、おすすめ商品はありません。"
#define NO_COUPON_STAMP_MESSAGE @"現在、発行しているクーポンはありません。"
#define NO_LIST_SHARE_THANK_COUPON_MESSAGE @"現在、発行しているクーポンはありません。"
#define NO_MY_COLLECTION_MESSAGE @"現在、マイコレクションはありません。"
#define MAP_VIEW_IFRAME @"<iframe width=600 height=450 frameborder=0 style='border:0' src='%@'> </iframe>"
#define NO_SCHOOL_MESSAGE @"現在、スクールはありません。"
#define NO_FAVORITE_MESSAGE @"現在、お気に入りメニューはありません。"
#define NO_LIST_NEWS @"現在、お知らせはありません。"
//=========== #E2E1D5
#define MESSAGE_SEND_DEVICE_ID_FAIL @"初回起動時はインターネット接続が必要となります。接続可能な環境で再度アプリを起動してください。"
#define TITLE_RECOMMEND @"おすすめ商品"
#define TITLE_MESSAGE_SHARE_FACEBOOK @"Facebookへの投稿"
#define TITLE_MESSAGE_SHARE_TWITTER @"Twitterへの投稿"
#define MESSAGE_SHARE_SOCIAL_OKAY @"クーポンがシェアされました。クーポンをビューするために、「OK」をクリックして下さい。"

#define BODY_MESSAGE_SHARE_FACEBOOK_OKAY @"Facebookのタイムラインへ投稿しました"
#define BODY_MESSAGE_SHARE_TWITTER_OKAY @"Twitterのタイムラインへ投稿しました。"

#define MESSAGE_SHARE_SOCIAL_ERROR @"Don't share as Spam!"

#define CAPTURE_IMAGE_NOTIFICATION @"CAPTURE_IMAGE_NOTIFICATION"
#define POST_DATA_TO_FACEBOOK_OKAY @"POST_DATA_TO_FACEBOOK_OKAY"
#define INSERT_BODY_RECORD_OK @"INSERT_BODY_RECORD_OK"
#define SET_DATE_SUBMIT_DEVICE_USER_DEFAULT @"SET_DATE_SUBMIT_DEVICE_USER_DEFAULT"

#define IMAGE_BODY_FOLDER @"ImageBody"
#define LINE_OF_APP @"background.png"
#define LINE_OF_NEWS @"line_coupon_detail.png"
#define FONT_TITLE_APP @"HelveticaNeue-Bold"
#define FONT_MESSAGE_APP @"HelveticaNeue"
#define FONT_SIZE_TITLE_APP 12
#define TITLE_HEADER_LEFT 15


#define DEVICE_ID_USER_DEFAULT @"device_id_userdefault"
#define HEIGHT_TABBAR_OR_NAVIGATION 44
#define CONFIG_FILE @"config"
#define SET_BIRTHDAY_USER_DEFAULT @"SET_BIRTHDAY_USER_DEFAULT"
#define MONTH_BIRTH @"MONTH_BIRTH"
#define UNAVAILABLE_IMAGE @"no_photo.png"

//URL Webservice Misepuri
#define BASE_PREFIX_URL @"http://dalia.miseapps.com/%@"
//#define BASE_PREFIX_URL @"http://dondontei.miseapps.com/%@"
#define BASE_URL @"http://dalia.miseapps.com/index.php/services/%@"
//#define BASE_URL @"http://dondontei.miseapps.com/index.php/services/%@"
//CURPON IMAGE
//#define CURPON_IMAGE_URL @"http://dondontei.miseapps.com/images/top_coupon_bunner.png"

#define SET_DEVICE @"device/setDevice"
#define SET_DEVICE_TOKEN @"device/setDeviceToken"
#define SET_ENABLE_NOTIFICATION @"device/setAcceptNotification"

//DEFAULT NOTIFICATION
#define GET_DEFAULT_NOTIFICATION @"default/notification"












//USER
#define GET_MEMBER_INFO @"member/getMemberInfo"
#define SET_MEMBER_INFO @"member/setMemberInfo"

//HOME
#define GET_LIST_IMAGES @"image/getListImage"
#define GET_LIST_MESSAGES @"message/getListMessage"
#define READ_MESSAGE @"message/read"

//MENU
#define GET_LIST_MENU @"menu/getListMenu"
#define GET_DETAIL_MENU @"menu/getDetailMenu"
#define GET_LIST_LIKED_MENU @"menu/getListLikedMenu"
#define SET_LIKED_MENU @"menu/setLikedMenu"

//SHOP
#define GET_LIST_CAT_SHOP @"shop/getListCatShop"
#define GET_DETAIL_SHOP @"shop/getDetailShop"
#define SET_FAVORITE_SHOP @"shop/setFavorite"
// INSERTED BY ama 2016.10.05 START
// お気に入り削除追加
#define DEL_FAVORITE_SHOP @"shop/delFavorite"
// INSERTED BY ama 2016.10.05 END

//COUPON
#define GET_LIST_COUPON @"coupon/getListCoupon"
#define SET_USE_COUPON @"coupon/setUseCoupon"
#define SET_REGIST_COUPON @"coupon/setRegistCoupon"
#define SET_BIRTHDAY @"device/setBirthday"

//SHARE THANK COUPON
#define GET_LIST_COUPON_SHARE @"coupon/getListCouponShare"
#define GET_DETAIL_COUPON_SHARE @"coupon/getDetailCouponShare"

//STAMP CARD COUPON
#define GET_DETAIL_COUPON_STAMP @"coupon/getDetailCouponStamp"
#define SET_REGIST_COUPON @"coupon/setRegistCoupon"
#define SET_STAMP @"coupon/setStamp"

//RECOMMEND PRODUCT
#define RECOMMENT_PRODUCT @"menu/getRecommendProduct"

#define GET_LINK @"app/getLink"
#define GET_BOOK_LINK @"app/getBookLink"
#define GET_LIST_SCHOOL @"school/getListSchool"
#define GET_DETAIL_SCHOOL @"getDetailSchool"

//GET COMPANY
#define GET_COMPANY @"setting/getCompany"

#define REQUEST_TIMEOUT 30

#define DEFAULT_DATABASE_NAME @"misepuri.sqlite"
#define COMMON_DATETIME_FORMAT @"yyyy-MM-dd HH:mm:SS"

// define SQL TEMPLATE
#define WHERE_CLAUSE_TEMPLATE           @"%1$@ = '%2$@'"
#define WHERE_2_CLAUSE_TEMPLATE         @"%1$@ = '%2$@' OR %3$@ = '%4$@'"
#define WHERE_CLAUSE_TEMPLATE_WITH_ARGUMENTS    @"%1$@ = %2$@"

#define SELECT_STATEMENT_TEMPLATE       @"SELECT %1$@ FROM [%2$@] WHERE %3$@"
#define SELECT_TABLES_STATEMENT_TEMPLATE       @"SELECT %1$@ FROM %2$@ WHERE %3$@"
#define BETWEEN_STATEMENT_TEMPLATE      @"%1$@ <= '%2$@' AND %3$@ >= '%4$@' ORDER BY %5$@"
#define SELECT_ORDERBY_STATEMENT @"SELECT %1$@ FROM [%2$@] ORDER BY %3$@ DESC"

#define SELECT_GET_NUMBER_DATE @"SELECT (julianday(Date('now')) - julianday(MIN(%1$@))) FROM %2$@"

#define UPDATE_STATEMENT_TEMPLATE       @"UPDATE [%1$@] SET %2$@ WHERE %3$@"
#define UPDATE_SET_CLAUSE_TEMPLATE      @"%1$@ = '%2$@'"
#define UPDATE_SET_CLAUSE_TEMPLATE_WITH_ARGUMENTS   @"%1$@ = %2$@"
#define DELETE_STATEMENT_TEMPLATE       @"DELETE FROM [%1$@] WHERE %2$@"
#define DELETE_MORE_STATEMENT_TEMPLATE  @"DELETE FROM [%1$@] WHERE %2$@ AND %3$@"
#define DELETE_MORE_STATEMENT_TEMPLATE_WITH_TYPE  @"DELETE FROM [%1$@] WHERE %2$@ AND %3$@ AND %4$@"
#define DELETE_ALL @"DELETE FROM [%1$@]"
#define DELETE_CONDITION_TEMPLATE       @"%1$@ = \'%2$@\'"

// INSERT START 2015.01.16
// INSERTED BY M.FUJII
// ADD OPTION9 (LINE連携追加)
#define TITLE_MESSAGE_SHARE_LINE @"LINEへの投稿"
#define BODY_MESSAGE_SHARE_LINE_OKAY @"LINEのタイムラインへ連携しました。"
#define MESSAGE_SHARE_SOCIAL_LINE_ERROR @"連携に失敗しました。端末にLINEアプリがインストールされていない場合、インストール後にご利用ください。"
// INSERT END 2015.01.16

// INSERTED BY M.FUJII 2015.12.12 START
// 電子スタンプ実装
#define GET_TRANSFER_CODE @"device/getDeviceTranferCode"
#define SET_TRANSFER_DEVICE @"device/setTransferDevice"
#define DEL_TRANSFER_DEVICE @"device/delDeviceTranferCode"
#define IS_TRANSFER @"IS_TRANSFER"
// INSERTED BY M.FUJII 2015.12.12 END

// INSERTED BY M.FUJII 2016.02.04 START
// 簡易CMS対応
#define GET_MEMBER_NO @"setting/getMemberNo"
#define MEMBER_NO @"MEMBER_NO"
// INSERTED BY M.FUJII 2016.02.04 END

#endif
