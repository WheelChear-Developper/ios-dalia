//
//  Utility.h
//  Oromo
//
//  Created by Le Ngoc Thanh on 9/28/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//
typedef NS_ENUM(NSInteger, DEVICE_TYPE) {
    DEVICE_TYPE_iPhone5Retina,
    DEVICE_TYPE_iPhone4Retina,
    DEVICE_TYPE_iPhone,
    DEVICE_TYPE_iPadRetina,
    DEVICE_TYPE_iPad
    
};
#import <Foundation/Foundation.h>
@interface Utility : NSObject
+ (UIView *)viewInBundleWithName:(NSString *)strName;
+ (CGSize) sizeWithFont: (UIFont*) font width:(float)width value: (NSString*) value;
+ (NSDictionary *)dictionaryFromFilePlist:(NSString *)path;

+ (NSString *)applicationDocumentsDirectory;
+ (BOOL) createFileName: (NSString*) fileName;
+ (BOOL) saveImageToFile: (NSString*) fileRoot imageName: (NSString*) imageName actualImage: (UIImage*) actualImage;
+ (UIImage*) imageReadByDirectory: (NSString*) directory;
+ (NSString *)deviceID;
+ (id )checkNULL:(id)obj;
+ (id) checkNIL: (id) obj;
+ (NSString *)stringParamWithMethodHTTPGET:(NSDictionary *)param moreParam:(BOOL)more;
+ (void)setParamWithMethodPost:(NSDictionary *)param forRequest:(NSMutableURLRequest *)request;
+ (NSString*) getAppID;
+ (NSString*) getDeviceID;
+ (NSString*) getPatternType;
+ (NSString*) formatDateToString: (NSDate*) date;
+ (NSString*) formatDateToStringSpecial: (NSDate*) date;
+ (NSString*) dateDisplayedOnUI: (NSString*) dateValue;
+ (NSDate*) dateFromString: (NSString*) string;
+ (NSString*) numberDayOfWeek: (NSDate*) date;
+ (BOOL) compareTwoDate: (NSDate*) date1 withDate: (NSDate*) date2;
+ (long) deviceType;
@end
