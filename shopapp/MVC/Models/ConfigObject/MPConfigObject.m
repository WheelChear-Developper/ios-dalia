//
//  MPConfigObject.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPConfigObject.h"

@implementation MPConfigObject

+ (MPConfigObject*) sharedInstance{
    static MPConfigObject* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[MPConfigObject alloc] init];
        }
    });
    
    return sharedInstance;
}

//- (NSArray*) listFunctions{
//    if (self.function_id && ![self.function_id isEqualToString:@""]) {
//        return [self.function_id componentsSeparatedByString:@"#"];
//    }
//    return nil;
//}
- (NSDictionary*) dictForPlist: (NSString*) plistPath{
    NSString *path = [[NSBundle mainBundle] pathForResource:plistPath ofType:@"plist"];
    NSDictionary *dictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    return dictionary;
}

- (MPConfigObject*) objectAfterParsedPlistFile: (NSString*) plistPath{
    NSDictionary *dictionary = [self dictForPlist:plistPath];
    self.top_image_type = [dictionary objectForKey:@"top_image_type"];
    self.templateType = [dictionary objectForKey:@"template_type"];
    self.appName = [dictionary objectForKey:@"app_name"];
    self.appId = [dictionary objectForKey:@"app_id"];
    self.function_id = [dictionary objectForKey:@"function_id"];
    self.listFunctions = [self.function_id componentsSeparatedByString:@"#"];
    return self;
}

@end
