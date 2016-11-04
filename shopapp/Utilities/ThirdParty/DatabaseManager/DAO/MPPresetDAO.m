//
//  MPPresetDAO.m
//  Misepuri
//
//  Created by TUYENBQ on 12/11/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPPresetDAO.h"

@implementation MPPresetDAO
+ (MPPresetDAO*) sharedInstance
{
    static MPPresetDAO *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[MPPresetDAO alloc] init];
    }
    return sharedInstance;
}

-(id) init
{
    self = [super init];
    if (self) {
        self.classOfEntity = [MPPresetObject class];
    }
    return self;
}
-(id)initWithDatabase:(FMDatabase *)database
{
    self = [super initWithDatabase:database];
    if (self) {
        self.classOfEntity = [MPPresetObject class];
    }
    return self;
}
-(NSString*) getTableName
{
    return @"presetManagement";
}

- (BOOL) updatePreset: (NSString*) preset_id withName:(NSString *)preset_name{
    NSString* conditionsString1 = [NSString stringWithFormat:UPDATE_SET_CLAUSE_TEMPLATE,
                                   @"preset_name",
                                   preset_name];
    
    NSString* conditionsString2 = [NSString stringWithFormat:WHERE_CLAUSE_TEMPLATE,
                                   @"preset_id",
                                   preset_id];
    
    NSString* query = [NSString stringWithFormat:
                       UPDATE_STATEMENT_TEMPLATE,
                       [self getTableName],
                       conditionsString1,conditionsString2];
    
    return [self.database executeUpdate:query];
}
@end
