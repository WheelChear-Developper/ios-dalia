//
//  DatabaseManager.m
//  iPadReport
//
//  Created by Duc Nguyen on 10/25/12.
//  Copyright (c) 2013 TinhVan Outsourcing Technology JSC. All rights reserved.
//
#import "DatabaseManager.h"
#import "FMDatabase.h"

@implementation DatabaseManager

#pragma mark - Init database methods

NSString* databasePath;

+(BOOL) checkPhycicalDatabase
{
    NSString* databasePath = [self getDatabasePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath]) {
    
        return YES;
    } else {
        return [self createNewDataBaseFile];
    }
}

+(NSString*) getDatabasePath
{
    if(databasePath != nil) {
        return databasePath;
    } else {
        NSArray *myPathList =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        databasePath =  (myPathList != nil) ? ([[myPathList objectAtIndex:0] stringByAppendingPathComponent:DEFAULT_DATABASE_NAME]) : nil;
    }
    return databasePath;
}

+(void) assignDatabasePath:(NSString *)databasePathArg
{
    databasePath = databasePathArg;
}

+(BOOL) createNewDataBaseFile
{
    NSString* databasePath = [self getDatabasePath];
    FMDatabase* database = [[FMDatabase alloc] initWithPath:databasePath];
    // huyld 20121027 Begin transaction for keeping file -- start
    [database beginTransaction];
    // huyld 20121027 Begin transaction for keeping file -- end
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath]) {
        return NO;
    } else {
        NSArray* query = [[NSArray alloc]initWithObjects:
                          @"DROP TABLE IF EXISTS 'presetManagement';",
                          @"CREATE TABLE [presetManagement] ([preset_id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,[preset_name] DATETIME NOT NULL)",
                          
                          @"DROP TABLE IF EXISTS 'hospitalHistory';",
                          @"CREATE TABLE [hospitalHistory] ([history_id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,[history_date] DATETIME NOT NULL)",
                          
                          @"DROP TABLE IF EXISTS 'gym';",
                          @"CREATE TABLE [gym] ([gym_id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,[gym_date] DATETIME ,[gym_image] TEXT,[gym_weight] TEXT,[gym_check1] TEXT,[gym_check2] TEXT,[gym_check3] TEXT)",
                          
                          @"DROP TABLE IF EXISTS 'APNS';",
                          @"CREATE TABLE [APNS] ([apns_id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,[apns_badge] TEXT,[apns_cp] TEXT,[apns_type] TEXT)",
                          
                          nil];
        
        
        
        if(![database open]) {
            return NO;
        }
        
        
//        NSString* queryContent = @"";
//        for(int i = 0 ; i < [query count] ; ++i) {
//            queryContent = [queryContent stringByAppendingString:[query objectAtIndex:i]];
//        }
//        NSLog(@"query content: %@",queryContent);
//        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//        [userDefault setObject:queryContent forKey:@"Query_Content"];
//        [userDefault synchronize];
        
        for(int i = 0 ; i < [query count] ; ++i) {
            if([query objectAtIndex:i]) {
                // huyld 20121027 Begin transaction for keeping file -- start
                @try {
                    [database executeUpdate:[query objectAtIndex:i]];
                }
                @catch (NSException *exception) {
                    NSString *exceptionDescription = [NSString stringWithFormat:
                                                                    @"Exception: %@",
                                                                    exception.description];
                    NSLog(@"%@",exceptionDescription);
                    [database commit];
                    return NO;
                }
                // huyld 20121027 Begin transaction for keeping file -- start
            }
        }
        // huyld 20121027 Begin transaction for keeping file -- start
        [database commit];
        [database close];
        // huyld 20121027 Begin transaction for keeping file -- end
        
        //save content query to userDefault
        
        return YES;
    }
}

@end
