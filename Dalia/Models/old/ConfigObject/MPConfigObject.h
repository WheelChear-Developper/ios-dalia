//
//  MPConfigObject.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPConfigObject : NSObject
@property (nonatomic, strong) NSString *top_image_type;
@property (nonatomic, strong) NSString *templateType;
@property(nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *function_id;
@property (nonatomic,strong) NSArray *listFunctions;

+ (MPConfigObject*) sharedInstance;
- (MPConfigObject*) objectAfterParsedPlistFile: (NSString*) plistPath;
- (NSDictionary*) dictForPlist: (NSString*) plistPath;
@end
