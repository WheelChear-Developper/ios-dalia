//
//  MPApnsDAO.m
//  Misepuri
//
//  Created by TUYENBQ on 12/20/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPApnsDAO.h"

@implementation MPApnsDAO
+ (MPApnsDAO*) sharedInstance
{
    static MPApnsDAO *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[MPApnsDAO alloc] init];
    }
    return sharedInstance;
}

-(id) init
{
    self = [super init];
    if (self) {
        self.classOfEntity = [MPApnsObject class];
    }
    return self;
}
-(id)initWithDatabase:(FMDatabase *)database
{
    self = [super initWithDatabase:database];
    if (self) {
        self.classOfEntity = [MPApnsObject class];
    }
    return self;
}
-(NSString*) getTableName
{
    return @"APNS";
}
@end
