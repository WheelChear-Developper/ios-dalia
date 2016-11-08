//
//  MPHospitalObject.m
//  Misepuri
//
//  Created by TUYENBQ on 12/12/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPHospitalObject.h"

@implementation MPHospitalObject
- (void)createPropertyNameDataFieldDic{
    NSMutableArray* propertyNameList = [[NSMutableArray alloc]initWithObjects:
                                        @"history_id",
                                        @"history_date",
                                        nil];
    
    NSMutableArray* databaseFieldNameList = [[NSMutableArray alloc]initWithObjects:
                                             @"history_id",
                                             @"history_date",
                                             nil];
    [self createPropertyNameDataFieldDic:propertyNameList databaseFieldList:databaseFieldNameList];
    self.primarKeyNameList = [[NSArray alloc]initWithObjects:@"history_id",nil];
}
@end
