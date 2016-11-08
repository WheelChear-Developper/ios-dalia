//
//  MPUIConfigObject.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/5/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPUIConfigObject : NSObject
@property (nonatomic, strong) NSDictionary *tab1;
@property (nonatomic, strong) NSDictionary *tab2;
@property (nonatomic, strong) NSDictionary *tab3;
@property (nonatomic, strong) NSDictionary *tab4;
@property (nonatomic, strong) NSDictionary *tab5;
+ (MPUIConfigObject*) sharedInstance;
- (MPUIConfigObject*) objectAfterParsedPlistFile: (NSString*) plistPath;
- (NSDictionary*) dictForPlist: (NSString*) plistPath;
@end
