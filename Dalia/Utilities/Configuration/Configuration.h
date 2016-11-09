//
//  Configuration.h
//
//  Created by MacServer on 2015/12/04.
//  Copyright © 2015年 Mobile Innovation, LLC. All rights reserved.
//

@interface Configuration : NSObject

#pragma mark - Synchronize
+ (void)synchronize;

#pragma mark - IDSave
+ (BOOL)getFirstUserInfoSet;
+ (void)setFirstUserInfoSet:(BOOL)value;

@end
