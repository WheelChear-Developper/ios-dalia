//
//  Configuration.m
//
//  Created by MacServer on 2015/12/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

#pragma mark - Synchronize
+ (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - FirstUserInfoSet
static NSString *CONFIGURATION_FIRSTUSERINFOSET = @"Configuration.FirstUserInfoSet";
+ (BOOL)getFirstUserInfoSet
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_FIRSTUSERINFOSET : @(NO)}];
    return [userDefaults boolForKey:CONFIGURATION_FIRSTUSERINFOSET];
}
+ (void)setFirstUserInfoSet:(BOOL)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:CONFIGURATION_FIRSTUSERINFOSET];
}










#pragma mark - DeviceTokenKey
static NSString *CONFIGURATION_DEVICETOKENKEY = @"Configuration.DeviceTokenKey";
+ (NSString*)getDeviceTokenKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_DEVICETOKENKEY : @("")}];
    return [userDefaults stringForKey:CONFIGURATION_DEVICETOKENKEY];
}
+ (void)setDeviceTokenKey:(NSString*)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:CONFIGURATION_DEVICETOKENKEY];
}

#pragma mark - SessionTokenKey
static NSString *CONFIGURATION_SESSIONTOKENKEY = @"Configuration.SessionTokenKey";
+ (NSString*)getSessionTokenKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_SESSIONTOKENKEY : @("")}];
    return [userDefaults stringForKey:CONFIGURATION_SESSIONTOKENKEY];
}
+ (void)setSessionTokenKey:(NSString*)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:CONFIGURATION_SESSIONTOKENKEY];
}

#pragma mark - ScreenWidth
static NSString *CONFIGURATION_SCREENWIDTH = @"Configuration.ScreenWidth";
+ (long)getScreenWidth
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_SCREENWIDTH : @(0)}];
    return [userDefaults integerForKey:CONFIGURATION_SCREENWIDTH];
}
+ (void)setScreenWidth:(long)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:CONFIGURATION_SCREENWIDTH];
}

#pragma mark - ScreenHeight
static NSString *CONFIGURATION_SCREENHEIGHT = @"Configuration.ScreenHeight";
+ (long)getScreenHeight
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_SCREENHEIGHT : @(0)}];
    return [userDefaults integerForKey:CONFIGURATION_SCREENHEIGHT];
}
+ (void)setScreenHeight:(long)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:CONFIGURATION_SCREENHEIGHT];
}

#pragma mark - IDSave
static NSString *CONFIGURATION_IDSAVE = @"Configuration.IDSave";
+ (BOOL)getIDSave
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_IDSAVE : @(NO)}];
    return [userDefaults boolForKey:CONFIGURATION_IDSAVE];
}
+ (void)setIDSave:(BOOL)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:CONFIGURATION_IDSAVE];
}

#pragma mark - ID
static NSString *CONFIGURATION_ID = @"Configuration.ID";
+ (NSString*)getID
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_ID : @("")}];
    return [userDefaults stringForKey:CONFIGURATION_ID];
}
+ (void)setID:(NSString*)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:CONFIGURATION_ID];
}

#pragma mark - Password
static NSString *CONFIGURATION_PASSWORD = @"Configuration.Password";
+ (NSString*)getPassword
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_PASSWORD : @("")}];
    return [userDefaults stringForKey:CONFIGURATION_PASSWORD];
}
+ (void)setPassword:(NSString*)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:CONFIGURATION_PASSWORD];
}

#pragma mark - PushSetting_before_attendance
static NSString *CONFIGURATION_PUSHSETTING_BEFORE_ATTENDANCE = @"Configuration.PushSetting_before_attendance";
+ (BOOL)getPushSetting_before_attendance
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_PUSHSETTING_BEFORE_ATTENDANCE : @(NO)}];
    return [userDefaults boolForKey:CONFIGURATION_PUSHSETTING_BEFORE_ATTENDANCE];
}
+ (void)setPushSetting_before_attendance:(BOOL)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:CONFIGURATION_PUSHSETTING_BEFORE_ATTENDANCE];
}

#pragma mark - PushSetting_empty
static NSString *CONFIGURATION_PUSHSETTING_EMPTY = @"Configuration.PushSetting_empty";
+ (BOOL)getPushSetting_empty
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_PUSHSETTING_EMPTY : @(NO)}];
    return [userDefaults boolForKey:CONFIGURATION_PUSHSETTING_EMPTY];
}
+ (void)setPushSetting_empty:(BOOL)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:CONFIGURATION_PUSHSETTING_EMPTY];
}

#pragma mark - NormalNoticeCount
static NSString *CONFIGURATION_NORMALNOTIFICECOUNT = @"Configuration.NormalNoticeCount";
+ (long)getNormalNoticeCount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_NORMALNOTIFICECOUNT : @(0)}];
    return [userDefaults integerForKey:CONFIGURATION_NORMALNOTIFICECOUNT];
}
+ (void)setNormalNoticeCount:(long)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:CONFIGURATION_NORMALNOTIFICECOUNT];
}
#pragma mark - ImportantNoticeCount
static NSString *CONFIGURATION_IMPORTANTNOTIFICECOUNT = @"Configuration.ImportantNoticeCount";
+ (long)getImportantNoticeCount
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_IMPORTANTNOTIFICECOUNT : @(0)}];
    return [userDefaults integerForKey:CONFIGURATION_IMPORTANTNOTIFICECOUNT];
}
+ (void)setImportantNoticeCount:(long)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:CONFIGURATION_IMPORTANTNOTIFICECOUNT];
}

#pragma mark - ScheduleKind
static NSString *CONFIGURATION_SCHEDULEKIND = @"Configuration.ScheduleKind";
+ (long)getScheduleKind
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaults:@{CONFIGURATION_SCHEDULEKIND : @(0)}];
    return [userDefaults integerForKey:CONFIGURATION_SCHEDULEKIND];
}
+ (void)setScheduleKind:(long)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:CONFIGURATION_SCHEDULEKIND];
}
















@end
