//
//  DatabaseManager.h
//  NEWS
//
//  Created by Duc Nguyen on 10/25/12.
//  Copyright (c) 2013 TinhVan Outsourcing Technology JSC. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DatabaseManager : NSObject

+(BOOL) checkPhycicalDatabase;
+(NSString*) getDatabasePath;
+(void) assignDatabasePath:(NSString *)databasePath;
+(BOOL) createNewDataBaseFile;

@end
