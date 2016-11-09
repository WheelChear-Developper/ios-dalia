//
//  MPUIConfigObject.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/5/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPUIConfigObject.h"

@implementation MPUIConfigObject
+ (MPUIConfigObject*) sharedInstance{
    static MPUIConfigObject* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[MPUIConfigObject alloc] init];
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

- (MPUIConfigObject*) objectAfterParsedPlistFile: (NSString*) plistPath{
    NSDictionary *dictionary = [self dictForPlist:[NSString stringWithFormat:@"UIConfig_%@",plistPath]];
    self.tab1 = [dictionary objectForKey:@"Tab1"];
    self.tab2 = [dictionary objectForKey:@"Tab2"];
    self.tab3 = [dictionary objectForKey:@"Tab3"];
    self.tab4 = [dictionary objectForKey:@"Tab4"];
    self.tab5 = [dictionary objectForKey:@"Tab5"];
    return self;
}
@end
