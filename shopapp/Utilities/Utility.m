//
//  Utility.m
//  Oromo
//
//  Created by Le Ngoc Thanh on 9/28/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import "Utility.h"
#import "Base64.h"
#import "MPConfigObject.h"
#import "NSString+URLEncoding.h"
#import "KeychainItemWrapper.h"

@implementation Utility
+ (UIView *)viewInBundleWithName:(NSString *)strName{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:strName owner:self options:nil];
    if ([arr count]>0) {
        return [arr lastObject];
    }
    return nil;
}

+ (CGSize) sizeWithFont: (UIFont*) font width:(float)width value: (NSString*) value{
    
//    return [value sizeWithFont:font
//             constrainedToSize:CGSizeMake(width, MAXFLOAT)
//                 lineBreakMode:NSLineBreakByWordWrapping];

    return [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName:font}
                              context:nil].size;
}
+ (NSDictionary *)dictionaryFromFilePlist:(NSString *)path{
    NSDictionary *theDict = [NSDictionary dictionaryWithContentsOfFile:path];
    return theDict;
}

+ (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths lastObject] : nil;
    return basePath;
}

+ (BOOL) createFileName: (NSString*) fileName{
    NSString *document = [self applicationDocumentsDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[document stringByAppendingPathComponent:fileName]]) {
        return [fileManager createDirectoryAtPath:[document stringByAppendingPathComponent:fileName] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}

+ (BOOL) saveImageToFile: (NSString*) fileRoot imageName: (NSString*) imageName actualImage:(UIImage *)actualImage{
    NSString *doc = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:fileRoot];
     NSData *data = nil;
    if (actualImage) {
        
    }else{
        actualImage = [UIImage imageNamed:UNAVAILABLE_IMAGE];
        
    }
   data =  UIImagePNGRepresentation(actualImage);
    
    return [data writeToFile:[doc stringByAppendingPathComponent:imageName] atomically:NO];
}

+ (UIImage*) imageReadByDirectory: (NSString*) directory{
    NSString *doc = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",directory]];
    UIImage *img = [UIImage imageWithContentsOfFile:doc];
    UIGraphicsBeginImageContext(CGSizeMake(270, 250));
    [img drawInRect:CGRectMake(0, 0, 270, 250)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)deviceID {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.Misepuri" accessGroup:nil];
    [wrapper setObject:@"com.Misepuri" forKey:(__bridge id)kSecAttrService];
    
    NSString* uniqueIdentifier = [wrapper objectForKey:(__bridge id)(kSecValueData)];
    
    if( [uniqueIdentifier isEqualToString:@""] ) {
        uniqueIdentifier = nil;
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        if (uuid) {
            uniqueIdentifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
            CFRelease(uuid);
        }
        uniqueIdentifier = [uniqueIdentifier stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [wrapper setObject:uniqueIdentifier forKey:(__bridge id)(kSecValueData)];
    }
    return uniqueIdentifier;
}

+ (id )checkNULL:(id)obj{
    return [obj isKindOfClass:[NSNull class]]?nil:obj;
}

+ (id) checkNIL: (id) obj{
    return obj?obj:@"";
}

+ (NSString*) getAppID{
    return [(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] appId];
}

+ (NSString *)getDeviceID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DEVICE_ID_USER_DEFAULT];
}

+ (NSString*) getPatternType{
    return [(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] templateType];
}

+ (NSString*) formatDateToString: (NSDate*) date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

+ (NSString*) formatDateToStringSpecial: (NSDate*) date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

+ (NSString *)dateDisplayedOnUI:(NSString *)dateValue{
    NSArray *arr = [dateValue componentsSeparatedByString:@" "];
    NSArray *arr1 = [[arr objectAtIndex:0] componentsSeparatedByString:@"-"];
    
    return [NSString stringWithFormat:@"%@年%@月%@日まで",[Utility checkNIL:[arr1 objectAtIndex:0]],[Utility checkNIL:[arr1 objectAtIndex:1]],[Utility checkNIL:[arr1 objectAtIndex:2]]];
    
}

+ (NSDate*) dateFromString: (NSString*) string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [formatter dateFromString:string];
}

+ (NSString*)numberDayOfWeek:(NSDate *)date{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    long weekday = [comps weekday];
    NSString *dateString = @"";
    switch (weekday) {
        case 1:
            dateString = @"日";
            break;
            
        case 2:
            dateString = @"月";
            break;
            
        case 3:
            dateString = @"火";
            break;
            
        case 4:
            dateString = @"水";
            break;
            
        case 5:
            dateString = @"木";
            break;
            
        case 6:
            dateString = @"金";
            break;
            
        case 7:
            dateString = @"土";
            break;
            
        default:
            break;
    }
    return dateString;
}

+ (BOOL)compareTwoDate:(NSDate *)date1 withDate:(NSDate *)date2{
    return ([date1 compare:date2] == NSOrderedSame);
}

+ (long) deviceType
{
    long deviceType;
    CGSize result = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [UIScreen mainScreen].scale;
    result = CGSizeMake(result.width * scale, result.height * scale);
    
    if(result.height == 1136) {
        deviceType = DEVICE_TYPE_iPhone5Retina;
    }
    
    else if(result.height == 960) {
        deviceType = DEVICE_TYPE_iPhone4Retina;
    }
    
    else if (result.height == 480) {
        deviceType = DEVICE_TYPE_iPhone;
    }
    
    else if (result.height == 2048) {
        deviceType = DEVICE_TYPE_iPadRetina;
    }
    
    else if(result.height == 1024) {
        deviceType = DEVICE_TYPE_iPad;
    }
    
    else {
        deviceType = 100;
    }
    
    return deviceType;
}

#pragma mark - Embed YouTube
+ (void)embedYouTube:(NSString*)url webview: (UIWebView*) videoView frame:(CGRect)frame {
    NSString* embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
        background-color: transparent;\
    color: white;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"%@\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString* html = [NSString stringWithFormat:embedHTML, url,@"application/x-shockwave-flash", frame.size.width, frame.size.height];
//    if(videoView == nil) {
//        videoView = [[UIWebView alloc] initWithFrame:frame];
//        [self.view addSubview:videoView];
//    }
    [videoView loadHTMLString:html baseURL:nil];
}

#pragma mark - Utility
+ (NSString *)stringParamWithMethodHTTPGET:(NSDictionary *)param moreParam:(BOOL)more{
    //NSlog(@"%s",__func__);
    NSMutableString *stringParam = [[NSMutableString alloc] init];
    NSArray *arrKey = [param allKeys];
    if ([arrKey count]>0) {
        if (more) {
            [stringParam appendString:@"&"];
        }else{
            [stringParam appendString:@"?"];
        }
        
        for (NSString *key in arrKey) {
            if ([[param objectForKey:key] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [param objectForKey:key];
                for (NSObject *str in arr) {
                    if ([str isKindOfClass:[NSString class]]) {
                        [stringParam appendFormat:@"%@[]=%@&",key,[(NSString*)str encodedURLParameterString]];
                    }else if ([str isKindOfClass:[NSNumber class]]){
                        [stringParam appendFormat:@"%@[]=%@&",key,[[(NSNumber *)str stringValue] encodedURLParameterString]];
                    }
                }
            }else{
                [stringParam appendFormat:@"%@=%@&",key,[[param objectForKey:key] encodedURLParameterString]];
            }
        }
        [stringParam replaceCharactersInRange:NSMakeRange([stringParam length]-1, 1) withString:@""];
    }
    return stringParam;
}
+ (void)setParamWithMethodPost:(NSDictionary *)param forRequest:(NSMutableURLRequest *)request{
    //NSlog(@"%s",__func__);
    NSArray *arrKey = [param allKeys];
    
    if ([arrKey count]>0) {;
        // define boundary and content-type of file in header of request
        NSString* boundary = @"----Misepuri";
        NSString* contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        // Create entire body
        NSMutableData* dataRequestBody = [NSMutableData data];
        
        for (NSString *key in arrKey) {
            id value = [param objectForKey:key];
            if ([value isKindOfClass:[NSData class]]) {
                [dataRequestBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [dataRequestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"upload.jpg\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
                [dataRequestBody appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [dataRequestBody appendData:[NSData dataWithData:value]];
                [dataRequestBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            }else if ([value isKindOfClass:[NSString class]]){
                [dataRequestBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [dataRequestBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
                [dataRequestBody appendData:[[NSString stringWithFormat:@"%@\r\n",value] dataUsingEncoding:NSUTF8StringEncoding]];
            }else{
                //NSlog(@"=======>Other Class<======");
            }
        }
        
        [dataRequestBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:dataRequestBody];
        
    }
}
@end
