//
//  MPHospitalDAO.m
//  Misepuri
//
//  Created by TUYENBQ on 12/12/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPHospitalDAO.h"

@implementation MPHospitalDAO
+ (MPHospitalDAO*) sharedInstance
{
    static MPHospitalDAO *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[MPHospitalDAO alloc] init];
    }
    return sharedInstance;
}

-(id) init
{
    self = [super init];
    if (self) {
        self.classOfEntity = [MPHospitalObject class];
    }
    return self;
}
-(id)initWithDatabase:(FMDatabase *)database
{
    self = [super initWithDatabase:database];
    if (self) {
        self.classOfEntity = [MPHospitalObject class];
    }
    return self;
}
-(NSString*) getTableName
{
    return @"hospitalHistory";
}
- (NSArray*) listHospitalHistory25DaysAgo:(NSString *)datePast current:(NSString *)currentDate{

    NSString* conditionsString = [NSString stringWithFormat:BETWEEN_STATEMENT_TEMPLATE,@"history_date",currentDate,@"history_date",datePast,@"history_date"];
    
    
    NSString* query = [NSString stringWithFormat:
                       SELECT_STATEMENT_TEMPLATE,
                       @"*",
                       [self getTableName],
                       conditionsString];
    return [self selectWithQuery:query];
}

- (NSArray*) listHospitalOrderBy{
    NSString* query = [NSString stringWithFormat:
                       SELECT_ORDERBY_STATEMENT,
                       @"*",
                       [self getTableName],
                       @"history_date"];
    return [self selectWithQuery:query];
}

- (NSArray*) getNumber{
    //SELECT (julianday(Date('now')) - julianday(MIN(history_date) )) FROM hospitalHistory;
    NSString* query = [NSString stringWithFormat:
                       SELECT_GET_NUMBER_DATE,
                       @"history_date",
                       [self getTableName]];
    
    return [self selectWithQuery:query];
}

@end
