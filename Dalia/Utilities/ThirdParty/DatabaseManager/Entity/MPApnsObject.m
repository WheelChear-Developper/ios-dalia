//
//  MPApnsObject.m
//  Misepuri
//
//  Created by TUYENBQ on 12/20/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPApnsObject.h"

@implementation MPApnsObject
- (void)createPropertyNameDataFieldDic{
    NSMutableArray* propertyNameList = [[NSMutableArray alloc]initWithObjects:
                                        @"apns_id",
                                        @"apns_badge",
                                        @"apns_cp",
                                        @"apns_type",
                                        nil];
    
    NSMutableArray* databaseFieldNameList = [[NSMutableArray alloc]initWithObjects:
                                             @"apns_id",
                                             @"apns_badge",
                                             @"apns_cp",
                                             @"apns_type",
                                             nil];
    [self createPropertyNameDataFieldDic:propertyNameList databaseFieldList:databaseFieldNameList];
    self.primarKeyNameList = [[NSArray alloc]initWithObjects:@"apns_id",nil];
}
@end
