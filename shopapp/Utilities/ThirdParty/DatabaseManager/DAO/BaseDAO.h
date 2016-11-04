//
//  BaseDAO.h
//  iPadReport
//
//  Created by Duc Nguyen on 10/18/12.
//  Copyright (c) 2013 TinhVan Outsourcing Technology JSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "BaseEntity.h"



@interface BaseDAO : NSObject
{
    
}

@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, strong) Class classOfEntity;
@property (nonatomic, strong) FMDatabase* database;
@property (nonatomic, assign) BOOL selfManagedTransaction;

#pragma mark - Object life-cycle methods

#pragma mark - Init database methods


-(id)initWithDatabasepath:(NSString*) databasePath;
-(id)initWithDatabase:(FMDatabase*) database;

#pragma mark - Open and commit transaction methods

-(BOOL) openConnectionAndBeginTransaction;
-(BOOL) beginTransaction;
-(BOOL) commitTransactionAndCloseConnection;
-(BOOL) commitTransaction;

#pragma mark - Private insert methods

-(BOOL) insertRecord:(NSString *)tableName
       fieldNameList:(NSArray *)fieldNameList
             argList:(NSArray *)argList;
-(BOOL) insertRecord:(BaseEntity *)newRecord tableName:(NSString*) tableName;

#pragma mark - Private update method

-(BOOL) updateRecord:(NSString*) tableName conditionArgumentNameList:(NSArray*) conditionArgumentNameList
newValueArgumentNameList: (NSArray*) newValueArgumentNameList
conditionArgumentValueList:(NSArray*) conditionArgumentValueList
newvalueArgumentList: (NSArray*) newValueArgumentList;
-(BOOL) updateRecord:(BaseEntity *)record tableName:(NSString *)tableName;

#pragma mark - Object mapping methods

- (BaseEntity*) baseEntityFromFMResultSet:(FMResultSet*) resultSet;
- (BaseEntity*) bindBaseEntity:(BaseEntity*) baseEntity fromFMResultSet:(FMResultSet*) resultSet;

#pragma mark - Insert, Select, Update, Delete for using out of class scope

-(BOOL) insertRecord:(BaseEntity*)newRecord;
-(NSArray*) selectRecordsWithConditionsString:(NSString *)conditionsString;
-(NSString*) getTableName;
-(BOOL) updateRecord:(BaseEntity*)record;
-(BOOL) deleteRecord:(BaseEntity*)record;
-(NSArray*) selectAll;
-(NSArray*) selectWithQuery:(NSString*) query;


- (BaseEntity *)selectRecordWithConditionsString:(NSString *)conditionsString;

- (NSArray*)selectWithPeople:(NSString*)peopleId;
- (BOOL) deleteWithPeople:(NSString *)peopleId;
- (BOOL) deleteAll;
@end
