//
//  CustomColor.h
//  
//
//  Created by TuyenBQ on 6/19/13.
//  Copyright (c) 2013 TuyenBQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(HexString)
+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
+ (UIColor *) colorWithHexString: (NSString *) hexString;
@end
