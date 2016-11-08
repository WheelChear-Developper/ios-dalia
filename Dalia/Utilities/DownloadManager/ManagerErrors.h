//
//  ManagerErrors.h
//  Oromo
//
//  Created by TUYENBQ on 10/16/13.
//  Copyright (c) 2013 TUYENBQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadParam.h"

#pragma mark - Status code HTTP
#define ERROR_HTTP_DONT_NETWORK         0
#define NOT_ERROR_HTTP                  200
#define ERROR_HTTP_REQUESTIME_OUT       408
#define ERROR_NOT_MODIFIER              304 //There was no new data to return.
#define ERROR_BAD_REQUEST               400 //Bad Request	The request was invalid.
#define ERROR_UNAUTHORIZED              401 //Authentication credentials were missing or incorrect.
#define ERROR_FORBIDDEN                 403 //This code is used when requests are being denied due to update limits.
#define ERROR_NOT_FOUND                 404 //The URI requested is invalid or the resource requested, such as a user, does not exists.
#define ERROR_NOT_ACCEPTABLE            406 //Returned by the Search API when an invalid format is specified in the request.
#define ERROR_RESOURCE_GONE             410 //This resource is gone. Used to indicate that an API endpoint has been turned off.
#define ERROR_ENHANCE_YOUR_CALM         420 //Returned by the version 1 Search and Trends APIs when you are being rate limited.
#define ERROR_UNPROCESSABLE             422 //Returned when an image uploaded to POST account/update_profile_banner is unable to be processed.
#define ERROR_TOO_MANY_REQUEST          429 //Returned in API v1.1 when a request cannot be served due to the application's rate limit having been exhausted for the resource. See Rate Limiting in API v1.1.
#define ERROR_INTERNAL_SERVER           500 //Something is broken. Please post to the group so the Twitter team can investigate.
#define ERROR_BAD_GATE_WAY              502 //Twitter is down or being upgraded.
#define ERROR_SERVICE_UNAVAILABLE       503 //The Twitter servers are up, but overloaded with requests. Try again later.
#define ERROR_GATEWAY_TIMEOUT           504 //The Twitter servers are up, but the request couldn't be serviced due to some failure within our stack. Try again later.

@interface ManagerErrors : NSObject
{
    UIAlertView *alert;
}

+ (ManagerErrors *)sharedInstance;
- (BOOL)errorRequestFromParameter:(DownloadParam *)param; // check request success or not
- (void)alertNoNetwork;
@end
