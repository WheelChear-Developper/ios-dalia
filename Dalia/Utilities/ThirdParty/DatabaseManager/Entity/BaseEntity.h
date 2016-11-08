//
//  BaseEntity.h
//  iPadReport
//
//  Created by Duc Nguyen on 10/19/12.
//  Copyright (c) 2013 TinhVan Outsourcing Technology JSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEntity : NSObject

@property (strong, nonatomic) NSMutableDictionary* propertyNamesDataFieldDic;
@property (strong, nonatomic) NSArray* primarKeyNameList;

-(void) createPropertyNameDataFieldDic;
-(void) createPropertyNameDataFieldDic:(NSMutableArray*) propertyNameList
                     databaseFieldList:(NSMutableArray*) databaseFieldList;

-(NSArray*) getListOfPropertyValueByListOfPropertyName:(NSArray*) ListOfPropertyName;

@end
