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











@end
