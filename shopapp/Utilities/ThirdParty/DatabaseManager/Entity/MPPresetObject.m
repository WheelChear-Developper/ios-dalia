//
//  MPPresetObject.m
//  Misepuri
//
//  Created by TUYENBQ on 12/11/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPPresetObject.h"

@implementation MPPresetObject
- (void)createPropertyNameDataFieldDic{
    NSMutableArray* propertyNameList = [[NSMutableArray alloc]initWithObjects:
                                        @"preset_id",
                                        @"preset_name",
                                        nil];
    
    NSMutableArray* databaseFieldNameList = [[NSMutableArray alloc]initWithObjects:
                                             @"preset_id",
                                             @"preset_name",
                                             nil];
    [self createPropertyNameDataFieldDic:propertyNameList databaseFieldList:databaseFieldNameList];
    self.primarKeyNameList = [[NSArray alloc]initWithObjects:@"preset_id",nil];
}
@end
