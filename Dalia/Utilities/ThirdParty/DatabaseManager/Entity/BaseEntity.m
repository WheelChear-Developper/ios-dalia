//
//  BaseEntity.m
//  iPadReport
//
//  Created by Duc Nguyen on 10/19/12.
//  Copyright (c) 2013 TinhVan Outsourcing Technology JSC. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

@synthesize propertyNamesDataFieldDic = _propertyNamesDataFieldDic;
@synthesize primarKeyNameList = _primarKeyNameList;

-(void) createPropertyNameDataFieldDic
{
    
}

-(void) createPropertyNameDataFieldDic:(NSMutableArray*) propertyNameList
                     databaseFieldList:(NSMutableArray*) databaseFieldList
{
    self.propertyNamesDataFieldDic = [[NSMutableDictionary alloc]init];
    for(int i = 0 ; i < [propertyNameList count] ; ++i) {
        NSString* value = [databaseFieldList objectAtIndex:i];
        NSString* key = [propertyNameList objectAtIndex:i];
        [self.propertyNamesDataFieldDic setObject:value
                                           forKey:key];
    }
}

-(NSArray*) getListOfPropertyValueByListOfPropertyName:(NSArray*) listOfPropertyName
{
    NSMutableArray* mutableListOfPropertyValue = [[NSMutableArray alloc]init];
     NSString* curPropertyName = @"";
    @try {
        for(int i = 0 ; i < [listOfPropertyName count] ; ++i) {
            curPropertyName = [listOfPropertyName objectAtIndex:i];
            [mutableListOfPropertyValue addObject:[self valueForKey:[listOfPropertyName objectAtIndex:i]]];
        }
    }
    @catch (NSException *exception) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Value of property insert have to be not null: %@",
                           curPropertyName];
    }
    return mutableListOfPropertyValue;
}

@end
