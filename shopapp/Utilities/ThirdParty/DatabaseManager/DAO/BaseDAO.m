//
//  MPTopImageObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "BaseDAO.h"
#import "DatabaseManager.h"

@implementation BaseDAO

@synthesize isConnected = _isConnected;
@synthesize classOfEntity = _classOfEntity;
@synthesize database = _database;
@synthesize selfManagedTransaction = _selfManagedTransaction;

#pragma mark - Object life-cycle methods

-(id)init
{
    self = [super init];
    [DatabaseManager checkPhycicalDatabase];
    if (self) {
        self.isConnected = NO;
        self.selfManagedTransaction = YES;
        self.database = [[FMDatabase alloc] initWithPath:[DatabaseManager getDatabasePath]];
    }
    return self;
}

-(id)initWithDatabasepath:(NSString*) databasePath
{
    self = [super init];
    [DatabaseManager checkPhycicalDatabase];
    if(self)
    {
        self.isConnected = NO;
        self.selfManagedTransaction = YES;
        self.database = [[FMDatabase alloc]initWithPath:databasePath];
    }
    return self;
}

-(id)initWithDatabase:(FMDatabase *)database
{
    self = [super init];
    [DatabaseManager checkPhycicalDatabase];
    self.database = database;
    return self;
}

-(void) dealloc
{
    if (self.selfManagedTransaction && _database) {
        [_database close];
    }
    self.database = nil;
}

-(NSString*) getTableName
{
    return @"";
}

-(FMDatabase*) database
{
    if(_database == nil) {
        [DatabaseManager checkPhycicalDatabase];
        self.database = [[FMDatabase alloc] initWithPath:[DatabaseManager getDatabasePath]];
    }
    if (self.selfManagedTransaction && ![_database open]) {
        [_database open];
        self.isConnected = YES;
    }
    return _database;
}

#pragma mark - Open and commit transaction methods

-(BOOL) openConnectionAndBeginTransaction
{
    if([DatabaseManager checkPhycicalDatabase]) {
        if([self.database open]) {
            [self.database beginTransaction];
            self.isConnected = YES;
            self.selfManagedTransaction = YES;
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
    return YES;
}

-(BOOL) commitTransactionAndCloseConnection
{
    @try {
        [self.database commit];
        [self.database close];
        self.isConnected = NO;
        self.selfManagedTransaction = NO;
    }
    @catch (NSException *exception) {
        return NO;
    }
}

-(BOOL) beginTransaction
{
    if([DatabaseManager checkPhycicalDatabase]) {
        if([self.database open]) {
            [self.database beginTransaction];
            self.isConnected = YES;
            self.selfManagedTransaction = YES;
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

-(BOOL) commitTransaction
{
    @try {
        if (self.database && [self.database open] && [self.database inTransaction]) {
            [self.database commit];
            self.selfManagedTransaction = NO;
            return YES;
        } else {
            return NO;
        }
    }
    @catch (NSException *exception) {
        NSString* exceptionDescription = [NSString stringWithFormat:
                                                        @"Exception %@",
                                                        exception.description];
        NSLog(@"%@",exceptionDescription);
        return NO;
    }
}

#pragma mark - Private insert methods

-(BOOL) insertRecord:(NSString *)tableName
       fieldNameList:(NSArray *)fieldNameList
             argList:(NSArray *)argList
{
    if([fieldNameList count] != [argList count])
    {
        [NSException raise:NSInvalidArgumentException
                    format:@"Not match length of property list and values"];
    }
    BOOL insertResult = YES;
    @try {
        int nField = [fieldNameList count];
        NSString* query = [[@"insert into '" stringByAppendingString:tableName] stringByAppendingString:@"'( "];
        NSString* fieldNameString = @"";
        for(int itemIndex = 0 ; itemIndex < nField - 1 ; ++itemIndex) {
            fieldNameString = [fieldNameString stringByAppendingString:
                                                        [fieldNameList objectAtIndex:itemIndex]];
            fieldNameString = [fieldNameString stringByAppendingString:@","];
        }
        fieldNameString = [fieldNameString stringByAppendingString:
                                                    [fieldNameList lastObject]];
        fieldNameString = [fieldNameString stringByAppendingString:@")"];
        query = [query stringByAppendingString:fieldNameString];
        query = [query stringByAppendingString:@" values ("];
        NSString* argString = @"";
        NSMutableArray* arguments = [[NSMutableArray alloc]init];
        for(int n = 0;n< nField - 1;++n)
        {
            NSObject* object  = [argList objectAtIndex:n];
            if([object isKindOfClass:[NSDate class]])
            {
                NSDate *date = (NSDate*)object;
                NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                [formatter setDateFormat:COMMON_DATETIME_FORMAT];
                NSString *strDate =[formatter stringFromDate:date];
                argString = [argString stringByAppendingFormat:@"%@,",@"?"];
                [arguments addObject:strDate];
            }
            else{
                argString = [argString stringByAppendingFormat:@"%@,",@"?"];
                [arguments addObject:[argList objectAtIndex:n]];
            }
            // argString = [argString stringByAppendingString:@"%@,"];
        }
        NSObject* object  = [argList lastObject];
        if([object isKindOfClass:[NSDate class]])
        {
            NSDate *date = (NSDate*)object;
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:COMMON_DATETIME_FORMAT];
            NSString *strDate =[formatter stringFromDate:date];
            argString = [argString stringByAppendingFormat:@"%@,",@"?"];
            [arguments addObject:strDate];
        }
        else{
            //argString = [argString stringByAppendingFormat:@"\"%@\");",[argList lastObject]];
            argString = [argString stringByAppendingFormat:@"%@);",@"?"];
            [arguments addObject:[argList lastObject]];
        }
        query = [query stringByAppendingString:argString];
        
        // Khahc 20121023 -- add try catch -- start
        @try {
            // Khahc 20121023 -- add try catch -- end
            //if([self.database executeUpdate:query] == YES)
            if([self.database executeUpdate:query withArgumentsInArray:arguments] == YES)
            {
                insertResult = YES;
                // Khahc 20121023 -- show log
                NSLog(@"Insert successfully");
            }
            else {
                insertResult = NO;
                // Khahc 20121023 -- show log
                NSLog(@"Insert failed");
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Insert failed %@", exception.reason);
        }
        
    }
    @catch (NSException *exception) {
        insertResult = NO;
        @throw exception;
    }
    return insertResult;
    
}

-(BOOL) insertRecord:(BaseEntity *)newRecord tableName:(NSString*) tableName
{
    if(newRecord.propertyNamesDataFieldDic == nil) {
        [newRecord createPropertyNameDataFieldDic];
    }
    NSDictionary* property_databasefieldDic =  newRecord.propertyNamesDataFieldDic;
    NSArray* tmppropertyList = [property_databasefieldDic allKeys];
    NSArray* tmpdatafieldnameList = [newRecord.propertyNamesDataFieldDic objectsForKeys:tmppropertyList
                                                                         notFoundMarker:@"not found"];
    NSMutableArray* datafieldnameList = [[NSMutableArray alloc]init];
    NSMutableArray* propertyList = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < [tmpdatafieldnameList count] ; ++i) {
        if([newRecord valueForKey:[tmppropertyList objectAtIndex:i]] == nil) {
            continue;
        }
        [datafieldnameList addObject:[tmpdatafieldnameList objectAtIndex:i]];
        [propertyList addObject:[tmppropertyList objectAtIndex:i]];
    }
    NSArray* tmpPropertyvalueList = [newRecord getListOfPropertyValueByListOfPropertyName:propertyList];
    NSMutableArray* propertyvalueList = [[NSMutableArray alloc]init];
    for(int i = 0;i<[tmpPropertyvalueList count];++i)
    {
        NSObject* object  = [tmpPropertyvalueList objectAtIndex:i];
        if([object isKindOfClass:[NSDate class]])
        {
            NSDate *date = (NSDate*)object;
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:COMMON_DATETIME_FORMAT];
            NSString *strDate =[formatter stringFromDate:date];
            [propertyvalueList addObject:strDate];
        }
        else{
            [propertyvalueList addObject:[tmpPropertyvalueList objectAtIndex:i]];
        }
    }
    return [self insertRecord:tableName fieldNameList:datafieldnameList argList:propertyvalueList];
}

#pragma mark - Private update method

-(BOOL) updateRecord:(NSString*) tableName conditionArgumentNameList:(NSArray*) conditionArgumentNameList
newValueArgumentNameList: (NSArray*) newValueArgumentNameList
conditionArgumentValueList:(NSArray*) conditionArgumentValueList
newvalueArgumentList: (NSArray*) newValueArgumentList
{
//    if(!self.isConnected) {
//        [NSException raise: NSInvalidArgumentException format:@"Database is not open"];
//    }
    BOOL updateResult = YES;
    @try {
        if(conditionArgumentNameList == nil) {
            [NSException raise:NSInvalidArgumentException
                        format:@"conditionArgumentNameList is not allow null"];
        }
        if(newValueArgumentNameList == nil) {
            [NSException raise:NSInvalidArgumentException
                        format:@"newValueArgumentNameList is not allow null"];
        }
        if(conditionArgumentValueList == nil) {
            [NSException raise:NSInvalidArgumentException
                        format:@"conditionArgumentValueList is not allow null"];
        }
        if(newValueArgumentList == nil) {
            [NSException raise:NSInvalidArgumentException
                        format:@"newValueArgumentList is not allow null"];
        }
        
        // Init set clause
        NSMutableArray *setClauseArray = [[NSMutableArray alloc] init];
        NSMutableArray* arguments = [[NSMutableArray alloc]init];
        for(int itemIndex = 0 ; itemIndex < [newValueArgumentList count] ; ++itemIndex) {
            NSString* columName = [newValueArgumentNameList objectAtIndex:itemIndex];
            id value = [newValueArgumentList objectAtIndex:itemIndex];
            if (!value
                    || (value == [NSNull null])
                    || ([value class] == [NSString class]
                                    &&  [value isEqualToString:@"<null>"])) {
                continue;
            }
            NSString* setClauseStr = [NSString stringWithFormat:
                                                    UPDATE_SET_CLAUSE_TEMPLATE_WITH_ARGUMENTS,
                                                    columName,
                                                    @"\?"];
            [setClauseArray addObject:setClauseStr];
            [arguments addObject:value];
        }
        
        // Init where clause
        NSMutableArray *whereClauseArray = [[NSMutableArray alloc] init];
        for(int itemIndex = 0 ; itemIndex < [conditionArgumentNameList count]; ++itemIndex) {
            
            NSString* columName = [conditionArgumentNameList objectAtIndex:itemIndex];
            id value = [conditionArgumentValueList objectAtIndex:itemIndex];
            if (!value || ([value class] == [NSString class] &&  [value isEqualToString:@"/<null/>"])) {
                continue;
            }
            NSString* whereClauseStr = [NSString stringWithFormat:
                                                        WHERE_CLAUSE_TEMPLATE_WITH_ARGUMENTS,
                                                        columName,
                                                        @"\?"];
            //@ThuyDTN #15795 20121101 -- Query collection error -> disable one line
            //[whereClauseArray addObject:value];
            [whereClauseArray addObject:whereClauseStr];
            [arguments addObject:value];
            
        }
        
        // Init SQL statement
        NSString* setClauseStr = [setClauseArray componentsJoinedByString:@" , "];
        NSString* conditionClauseStr = [whereClauseArray componentsJoinedByString:@" AND "];
        
        NSString* query = [NSString stringWithFormat:
                                            UPDATE_STATEMENT_TEMPLATE,
                                            [self getTableName],
                                            setClauseStr,
                                            conditionClauseStr];
        
        updateResult = [self.database executeUpdate:query withArgumentsInArray:arguments];
        if (updateResult) {
            NSLog(@"Update %@ success", [self getTableName]);
        } else
           NSLog(@"Update %@ failed", [self getTableName]); 
    }
    @catch (NSException *exception) {
        updateResult = NO;
        NSString *exceptionDescription = [NSString stringWithFormat:
                                                        @"Exception %@",
                                                        exception.description];
        NSLog(@"%@",exceptionDescription);
    }
    return updateResult;
}

-(BOOL) updateRecord:(BaseEntity *)record tableName:(NSString *)tableName
{
    if(record.propertyNamesDataFieldDic == nil) {
        [record createPropertyNameDataFieldDic];
    }
    
    // Init argument array
    NSArray* conditionArgumentNameList = [record.propertyNamesDataFieldDic objectsForKeys:record.primarKeyNameList
                                                                  notFoundMarker:@"not found"];
    // Init argument value array
    NSArray* conditionArgumentValueList = [record getListOfPropertyValueByListOfPropertyName:
                                                record.primarKeyNameList];
    
    NSDictionary* propertyDatabaseFieldDic =  record.propertyNamesDataFieldDic;
    
    NSArray* tmppropertyList = [propertyDatabaseFieldDic allKeys];
    
    NSMutableArray* propertyList = [[NSMutableArray alloc]init];
    
    for(int i = 0 ; i < [tmppropertyList count] ; ++i) {
        if([record valueForKey:[tmppropertyList objectAtIndex:i]] != nil) {
            [propertyList addObject:[tmppropertyList objectAtIndex:i]];
        }
    }
    
    NSArray* datafieldnameList = [propertyDatabaseFieldDic objectsForKeys:propertyList
                                                            notFoundMarker:@"not found"];
    NSArray* tmpPropertyvalueList = [record getListOfPropertyValueByListOfPropertyName:propertyList];
    NSMutableArray* propertyvalueList = [[NSMutableArray alloc]init];
    for(int i = 0;i<[tmpPropertyvalueList count];++i)
    {
        NSObject* object  = [tmpPropertyvalueList objectAtIndex:i];
        if([object isKindOfClass:[NSDate class]])
        {
            NSDate *date = (NSDate*)object;
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:COMMON_DATETIME_FORMAT];
            NSString *strDate =[formatter stringFromDate:date];
            [propertyvalueList addObject:strDate];
        }
        else{
            [propertyvalueList addObject:[tmpPropertyvalueList objectAtIndex:i]];
        }
    }

    BOOL result = [self updateRecord:tableName
           conditionArgumentNameList:conditionArgumentNameList
            newValueArgumentNameList:datafieldnameList
          conditionArgumentValueList:conditionArgumentValueList
                newvalueArgumentList:propertyvalueList];
    
    return result;
}

#pragma mark - Object mapping methods

- (BaseEntity*) baseEntityFromFMResultSet:(FMResultSet*) resultSet
{
    BaseEntity* selectedItem = [[[self classOfEntity] alloc] init];
    if(selectedItem.propertyNamesDataFieldDic == nil) {
        [selectedItem createPropertyNameDataFieldDic];
    }
    return [self bindBaseEntity:selectedItem fromFMResultSet:resultSet];
}

- (BaseEntity*) bindBaseEntity:(BaseEntity*) baseEntity fromFMResultSet:(FMResultSet*) resultSet
{
    if (resultSet == nil) {
        NSLog(@"resultSet's allow null");
        return nil;
    }
    if (baseEntity == nil) {
        NSLog(@"baseEntity's allow null");
        return nil;
    }
    if(baseEntity.propertyNamesDataFieldDic == nil) {
        [baseEntity createPropertyNameDataFieldDic];
    }
    NSArray* propertyList = [baseEntity.propertyNamesDataFieldDic allKeys];
    NSArray* dataFieldList = [baseEntity.propertyNamesDataFieldDic objectsForKeys:propertyList
                                                                   notFoundMarker:@"not found"];
    for(int i = 0 ; i < [propertyList count] ; ++i) {
        NSString *key = [propertyList objectAtIndex:i];
        NSString *dataField = [dataFieldList objectAtIndex:i];
        id valueForKey = [resultSet objectForColumnName:dataField];
        if (!valueForKey
                || valueForKey == [NSNull null]
                || ([valueForKey isKindOfClass:[NSString class]]
                && [valueForKey isEqual:@"<null>"])) {
                continue;
            }
        [baseEntity setValue:valueForKey
                      forKey:key];
    }
    return baseEntity;
}

#pragma mark - Insert, Select, Update, Delete for using out of class scope

-(BOOL) insertRecord:(BaseEntity*) newRecord
{
    if(![newRecord isKindOfClass:self.classOfEntity]) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Input argument class have to be %@",
                           self.classOfEntity];
    }
    return  [self insertRecord:newRecord
                     tableName:[self getTableName]];
}

-(NSArray*) selectAll
{
    NSMutableArray* resultList = [[NSMutableArray alloc] init];
    NSString* query = [NSString stringWithFormat:
                                    SELECT_STATEMENT_TEMPLATE,
                                    @"*",
                                    [self getTableName],
                                    @"1"];
    FMResultSet* resultSet = [self.database executeQuery:query];
    
    while ([resultSet next]) {
        BaseEntity* selectedItem = [self baseEntityFromFMResultSet:resultSet];
        [resultList addObject:selectedItem];
    }
    return resultList;
}

-(NSArray*) selectWithQuery:(NSString *)query
{
    NSMutableArray* resultList = [[NSMutableArray alloc] init];
    FMResultSet* resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        BaseEntity* selectedItem = [self baseEntityFromFMResultSet:resultSet];
        [resultList addObject:selectedItem];
    }
    return resultList;
}

- (NSArray*) selectRecordsWithConditionsString:(NSString *)conditionsString
{
    NSString* query = [NSString stringWithFormat:
                                        SELECT_STATEMENT_TEMPLATE,
                                        @"*",
                                        [self getTableName],
                                        conditionsString];
    return [self selectWithQuery:query];
}

-(BOOL) updateRecord:(BaseEntity*) record
{
    if(![record isKindOfClass:self.classOfEntity]) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Input argument class have to be %@",
                           self.classOfEntity];
    }
    return  [self updateRecord:record
                     tableName:[self getTableName]];
}

- (BOOL) deleteRecord:(BaseEntity*) record
{
    BOOL updateResult = YES;
    NSArray* conditionArgumentNameList = [[NSMutableArray alloc] init];
    conditionArgumentNameList = [record.propertyNamesDataFieldDic objectsForKeys:record.primarKeyNameList
                                                                  notFoundMarker:@"not found"];
    NSArray* conditionArgumentValueList = [[NSMutableArray alloc] init];
    conditionArgumentValueList = [record getListOfPropertyValueByListOfPropertyName:
                                                    record.primarKeyNameList];
    @try {
        
        NSInteger index = 0;
        
        NSMutableArray *conditionArray = [[NSMutableArray alloc] init];
        
        for (NSString *primaryKey in conditionArgumentNameList) {
            NSString* argumentValue = [conditionArgumentValueList objectAtIndex:index];
            NSString* conditionStr = [NSString stringWithFormat:
                                                    DELETE_CONDITION_TEMPLATE,
                                                    primaryKey,
                                                    argumentValue];
            [conditionArray addObject:conditionStr];
            index++;
        }
        
        NSString* whereCondition = [conditionArray componentsJoinedByString:@" AND "];
        
        NSString* queryStr = [NSString stringWithFormat:
                                            DELETE_STATEMENT_TEMPLATE,
                                            [self getTableName],
                                            whereCondition];
        
        if([self.database executeUpdate:queryStr]) {
            updateResult = YES;
        } else {
            updateResult = NO;
        }
    }
    @catch (NSException *exception) {
        updateResult = NO;
        NSString *exceptionDescription = [NSString stringWithFormat:
                                                        @"Exception %@",
                                                        exception.description];
        NSLog(@"%@",exceptionDescription);
    }
    return updateResult;
}

- (BaseEntity *)selectRecordWithConditionsString:(NSString *)conditionsString {
    NSArray *arrResult = [self selectRecordsWithConditionsString:conditionsString];
    if(arrResult && [arrResult count] > 0)
        return (BaseEntity *) [arrResult objectAtIndex:0];
    
    return nil;
}
- (NSArray*)selectWithPeople:(NSString*)peopleId
{
    NSString* conditionsString = [NSString stringWithFormat:WHERE_CLAUSE_TEMPLATE,
                                  @"people_id",
                                  peopleId];
    NSString* query = [NSString stringWithFormat:
                       SELECT_STATEMENT_TEMPLATE,
                       @"*",
                       [self getTableName],
                       conditionsString];
    return [self selectWithQuery:query];
}
- (BOOL) deleteWithPeople:(NSString *)peopleId
{
    NSString* conditionsString = [NSString stringWithFormat:DELETE_CONDITION_TEMPLATE,
                                  @"people_id",
                                  peopleId];
    NSString* query = [NSString stringWithFormat:
                       DELETE_STATEMENT_TEMPLATE,
                       [self getTableName],
                       conditionsString];
    return [self.database executeUpdate:query];
}
- (BOOL) deleteAll{
    NSString* query = [NSString stringWithFormat:
                       DELETE_ALL,
                       [self getTableName]];
    return [self.database executeUpdate:query];
}
@end
