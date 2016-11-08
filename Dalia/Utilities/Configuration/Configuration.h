//
//  Configuration.h
//
//  Created by MacServer on 2015/12/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

@interface Configuration : NSObject

#pragma mark - Synchronize
+ (void)synchronize;

#pragma mark - IDSave
+ (BOOL)getFirstUserInfoSet;
+ (void)setFirstUserInfoSet:(BOOL)value;











#pragma mark - DeviceTokenKey
+ (NSString*)getDeviceTokenKey;
+ (void)setDeviceTokenKey:(NSString*)value;

#pragma mark - SessionTokenKey
+ (NSString*)getSessionTokenKey;
+ (void)setSessionTokenKey:(NSString*)value;

#pragma mark - ScreenWidth
+ (long)getScreenWidth;
+ (void)setScreenWidth:(long)value;
#pragma mark - ScreenHeight
+ (long)getScreenHeight;
+ (void)setScreenHeight:(long)value;

#pragma mark - IDSave
+ (BOOL)getIDSave;
+ (void)setIDSave:(BOOL)value;

#pragma mark - ID
+ (NSString*)getID;
+ (void)setID:(NSString*)value;

#pragma mark - Password
+ (NSString*)getPassword;
+ (void)setPassword:(NSString*)value;

#pragma mark - PushSetting_before_attendance
+ (BOOL)getPushSetting_before_attendance;
+ (void)setPushSetting_before_attendance:(BOOL)value;

#pragma mark - PushSetting_empty
+ (BOOL)getPushSetting_empty;
+ (void)setPushSetting_empty:(BOOL)value;

#pragma mark - NormalNoticeCount
+ (long)getNormalNoticeCount;
+ (void)setNormalNoticeCount:(long)value;

#pragma mark - ImportantNoticeCount
+ (long)getImportantNoticeCount;
+ (void)setImportantNoticeCount:(long)value;

//定時、自由の設定フラグ
#pragma mark - ScheduleKind
+ (long)getScheduleKind;
+ (void)setScheduleKind:(long)value;













@end
