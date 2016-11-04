//
//  MPGymObject.m
//  Misepuri
//
//  Created by TUYENBQ on 12/12/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPGymObject.h"

@implementation MPGymObject
- (void)createPropertyNameDataFieldDic{
    NSMutableArray* propertyNameList = [[NSMutableArray alloc]initWithObjects:
                                        @"gym_id",
                                        @"gym_date",
                                        @"gym_image",
                                        @"gym_weight",
                                        @"gym_check1",
                                        @"gym_check2",
                                        @"gym_check3",
                                        nil];
    
    NSMutableArray* databaseFieldNameList = [[NSMutableArray alloc]initWithObjects:
                                             @"gym_id",
                                             @"gym_date",
                                             @"gym_image",
                                             @"gym_weight",
                                             @"gym_check1",
                                             @"gym_check2",
                                             @"gym_check3",
                                             nil];
    [self createPropertyNameDataFieldDic:propertyNameList databaseFieldList:databaseFieldNameList];
    self.primarKeyNameList = [[NSArray alloc]initWithObjects:@"gym_id",nil];
}
@end
