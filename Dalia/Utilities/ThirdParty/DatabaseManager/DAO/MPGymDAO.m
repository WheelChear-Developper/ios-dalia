//
//  MPGymDAO.m
//  Misepuri
//
//  Created by TUYENBQ on 12/12/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPGymDAO.h"

@implementation MPGymDAO
+ (MPGymDAO*) sharedInstance
{
    static MPGymDAO *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[MPGymDAO alloc] init];
    }
    return sharedInstance;
}

-(id) init
{
    self = [super init];
    if (self) {
        self.classOfEntity = [MPGymObject class];
    }
    return self;
}
-(id)initWithDatabase:(FMDatabase *)database
{
    self = [super initWithDatabase:database];
    if (self) {
        self.classOfEntity = [MPGymObject class];
    }
    return self;
}
-(NSString*) getTableName
{
    return @"gym";
}
@end
