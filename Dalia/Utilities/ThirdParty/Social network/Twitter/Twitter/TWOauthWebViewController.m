//
//  TWOauthWebViewController.m
//  Twipple
//
//  Created by NEC VIETNAM on 3/6/13.
//  Copyright (c) 2013 NECVN-BIGLOBE. All rights reserved.
//

#import "TWOauthWebViewController.h"
#define DETAIL_FIELD_HEIGHT 44
#define TEXT_FIELD_HEIGHT 44
#define BUTTON_SIZE_HIGHT 30
#define BUTTON_SIZE_WIDTH 30
#define AUTH_BUTTON_WIDTH 80


@interface TWOauthWebViewController ()

@end

@implementation TWOauthWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 戻るボタン
    
    //if (self.navigationItem.hidesBackButton == YES) {
    //TODO: Add barButtonItem
    
    self.title = @"TWITTER LOGIN";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(cancelAction:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    //}
    
    // webView
    CGRect rect = self.view.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    webView = [[UIWebView alloc] initWithFrame:rect];
    webView.delegate = self;
    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:webView];
    
    // 読み込みインジケータ
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    rect = CGRectMake(0, 0, BUTTON_SIZE_WIDTH, BUTTON_SIZE_HIGHT);
    spinner.frame = rect;
    //    self.navigationItem.titleView = spinner;
    //    [spinner startAnimating];
    // [self setCustomizeNavigationBar];
    // [self setTitleForNavigation:@"LOGIN TWITTER"];
    // [self setBarButton:[NSArray arrayWithObject:[NSNumber numberWithInt:TypeBarButton_CLOSE]]];
    // クッキーの削除
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    //TODO: bonus share LinkedIn
    NSString *urlString = @"";
    
    urlString = @"https://twitter.com";
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSEnumerator *enumerator = [[cookieStorage cookiesForURL:url] objectEnumerator];
    NSHTTPCookie *cookie = nil;
    while ((cookie = [enumerator nextObject])) {
        [cookieStorage deleteCookie:cookie];
    }
    
    
    
}

- (void) cancelAction: (UIBarButtonItem*) sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self requestToken];
}
#pragma mark - Get Twitter Consumer
- (OAConsumer *)getTwitterConsumer{
    NSString *key = @"";
    NSString *secret = @"";
    
    //TODO: share key or secret with TW
    
    key = @"rvb3fhNSbhhkPDgxW3GPBA";
    secret = @"LczlnXVkwjJgxeRi9crfQp7RkJUTrygOT9fXprp80";
    
    
    OAConsumer *com = [[OAConsumer alloc] initWithKey:key secret:secret];
    return com;
}
#pragma mark - request Token
// request token for login
- (void)requestToken{
    OAConsumer *cousumer = [self getTwitterConsumer];
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    
    //TODO: requestToken with TW
    NSString *urlString = @"";
    
    urlString = @"https://api.twitter.com/oauth/request_token";
    
    NSURL *requestUrl = [NSURL URLWithString:urlString];
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:requestUrl
                                                                   consumer:cousumer
                                                                      token:nil
                                                                      realm:nil signatureProvider:nil];
    [request setHTTPMethod:@"POST"];
    
//    if (self.shareType == ShareLinkedIn) {
//        OARequestParameter *nameParam = [[OARequestParameter alloc] initWithName:@"scope"
//                                                                           value:@"r_basicprofile+rw_nus"];
//        NSArray *params = [NSArray arrayWithObjects:nameParam, nil];
//        [request setParameters:params];
//        OARequestParameter * scopeParameter=[OARequestParameter requestParameter:@"scope" value:@"r_fullprofile rw_nus"];
//        
//        [request setParameters:[NSArray arrayWithObject:scopeParameter]];
//    }
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:didFinishWithData:)
                  didFailSelector:@selector(requestTokenTicket:didFailTwitterSubmitterWithError:)];
    
}
- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    if (ticket.didSucceed) {
        NSString *responseBody = [[NSString alloc] initWithData:data
                                                       encoding:NSUTF8StringEncoding];
        requestToken = [[OAToken alloc] initWithHTTPResponseBody:responseBody];
        
        // Link for web login
        
        //TODO: requestToken with TW
        NSString *urlString = @"";
        
        urlString = @"https://api.twitter.com/oauth/authorize";
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?oauth_token=%@",urlString,requestToken.key]];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    }else{
        [self failSaveAccount];
    }
}
- (void)requestTokenTicket:(OAServiceTicket *)ticket didFailTwitterSubmitterWithError:(NSError *)error {
    //エラー処理
    if (error.code == -1009) {
        
    }else{
        UIAlertView *alart = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"認証エラー", nil) message:NSLocalizedString(@"Twitterへのリクエストで\nエラーになりました。", nil) delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alart show];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#define TWIPPLE_OAUTH_CALLBACK_URL @"http://3si.vn"
#pragma mark - webview Delegate
- (void)webViewDidFinishLoad:(UIWebView *)_webView {
    // finished loading, hide the activity indicator in the status bar
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    
    NSURL *url = [NSURL URLWithString:[_webView stringByEvaluatingJavaScriptFromString:@"document.URL"]];
    [spinner stopAnimating];
    NSLog(@"url:%@ - %@",url.host,[[NSURL URLWithString:TWIPPLE_OAUTH_CALLBACK_URL] host]);
    if ([[url host] isEqualToString:[[NSURL URLWithString:TWIPPLE_OAUTH_CALLBACK_URL] host]]) {
        [spinner startAnimating];
        
        // request access token
        OAToken *token = [[OAToken alloc] initWithHTTPResponseBody:[url query]];
        OAConsumer *cousumer = [self getTwitterConsumer];
        OADataFetcher *fetcher = [[OADataFetcher alloc] init];
        
        //TODO: requestToken with TW
        NSString *urlString = @"";
        
        urlString = @"https://api.twitter.com/oauth/access_token";
        NSURL *requestUrl = [NSURL URLWithString:urlString];
        OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:requestUrl
                                                                       consumer:cousumer
                                                                          token:token
                                                                          realm:nil signatureProvider:nil];
        [request setHTTPMethod:@"POST"];
        [fetcher fetchDataWithRequest:request
                             delegate:self
                    didFinishSelector:@selector(requestTokenTicket:didFinishfetchAccessToken:)
                      didFailSelector:@selector(requestTokenTicket:didFailAccessTokenWithError:)];
    }
}

#pragma mark - requet Access Token
- (void)requestTokenTicket:(OAServiceTicket *)ticket didFinishfetchAccessToken:(NSData *)data {
    if (ticket.didSucceed) {
        NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // key1=value1&key2=value2
        NSArray *pairs = [body componentsSeparatedByString:@"&"];
        
        NSString *token = nil;
        NSString *secret = nil;
        NSNumber *userID = nil;
        
        for (NSString *pair in pairs) {
            // key=value
            NSRange range = [pair rangeOfString:@"="];
            if (range.length == 0) {
                // なんかおかしい
                continue;
            }
            NSString *key = [pair substringToIndex:range.location];
            NSString *value = [pair substringFromIndex:(range.location + 1)];
            if ([key isEqualToString:@"oauth_token"]) {
                token = value;
            } else if ([key isEqualToString:@"oauth_token_secret"]) {
                secret = value;
            }  else if ([key isEqualToString:@"screen_name"]) {
                screenName = value;
            }else if ([key isEqualToString:@"user_id"]){
                userID = [NSNumber numberWithUnsignedLongLong:[value longLongValue]];
            }
        }
        // save account login with accsess token
        dispatch_async(dispatch_get_main_queue(), ^{
            [MPAppDelegate sharedMPAppDelegate].twitterToken = [[OAToken alloc] initWithKey:token secret:secret];
            [self requestComplete];
        });
        
    }else{
        [self failSaveAccount];
    }
}
- (void)requestTokenTicket:(OAServiceTicket *)ticket didFailAccessTokenWithError:(NSError *)error {
    //エラー処理
    
    if (error.code == -1009) {
        
    }else{
        UIAlertView *alart = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"認証エラー", nil) message:NSLocalizedString(@"Twitterへのリクエストで\nエラーになりました。", nil) delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alart show];
    }
    
    [spinner stopAnimating];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)failSaveAccount{
    [self requestComplete];
    [spinner stopAnimating];
}
- (void)finishSaveAccount{
    [self requestComplete];
    [spinner stopAnimating];
}
- (void)requestComplete{
    [self dismissViewControllerAnimated:YES completion:^{
                    //TODO: post status or image to TW
                    [self sendTweet:self.content medias:nil];
    }];
}
//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark - Share data to Twitter
- (void)sendTweet:(NSString *)content medias:(UIImage *)image{
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:content forKey:@"status"];
    if (image) {
        NSData *dataImage = UIImageJPEGRepresentation(image, 1.0f);
        [param setValue:dataImage forKey:@"media"];
        NSString *strUrl = [NSString stringWithFormat:@"https://api.twitter.com/1.1/%@",@"statuses/update_with_media.json"];
        OAMutableURLRequest *request = [self getRequestWithUrl:strUrl method:MedthodRequestPost withParam:param];
        //[self baseRequestJSON:request parameter:userInfo];
        [NSURLConnection sendAsynchronousRequest:request queue:[[MPAppDelegate sharedMPAppDelegate] mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
            
        }];
    }else{
        NSString *strUrl = [NSString stringWithFormat:@"https://api.twitter.com/1.1/%@",@"statuses/update.json"];
        OAMutableURLRequest *request = [self getRequestWithUrl:strUrl method:MedthodRequestPost withParam:param];
        [NSURLConnection sendAsynchronousRequest:request queue:[[MPAppDelegate sharedMPAppDelegate] mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *err){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate resultOfShareContentProcess:err];
            });
            
        }];
    }
}

- (OAMutableURLRequest *)getRequestWithUrl:(NSString *)url method:(MedthodRequest)method withParam:(NSDictionary *)param{
    OAMutableURLRequest *request;
    NSString *methodString = @"GET";
    NSString *requestString = @"";
    OAConsumer *cousumer = [self getTwitterConsumer];
    OAToken *token = [MPAppDelegate sharedMPAppDelegate].twitterToken;
    
    if (method == MedthodRequestGet) {
        methodString = @"GET";
        requestString = [NSString stringWithFormat:@"%@%@",url,[self stringParamWithMethodHTTPGET:param moreParam:NO]];
        requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        NSURL *requestUrl = [NSURL URLWithString:requestString];
        request = [[OAMutableURLRequest alloc] initWithURL:requestUrl
                                                  consumer:cousumer
                                                     token:token
                                                     realm:nil signatureProvider:nil];
        [request setHTTPMethod:methodString];
        [request prepare];
        
    }else{
        requestString = url;
        NSURL *requestUrl = [NSURL URLWithString:requestString];
        request = [[OAMutableURLRequest alloc] initWithURL:requestUrl
                                                  consumer:cousumer
                                                     token:token
                                                     realm:nil signatureProvider:nil];
        
        methodString = @"POST";
        [request setHTTPMethod:methodString];
        [request prepare];
        [self setParamWithMethodPost:param forRequest:request];
        
    }
    
    return request;
}


#pragma mark - Utility
- (NSString *)stringParamWithMethodHTTPGET:(NSDictionary *)param moreParam:(BOOL)more{
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
                        [stringParam appendFormat:@"%@[]=%@&",key,str];
                    }else if ([str isKindOfClass:[NSNumber class]]){
                        [stringParam appendFormat:@"%@[]=%@&",key,[(NSNumber *)str stringValue]];
                    }
                    
                }
            }else{
                [stringParam appendFormat:@"%@=%@&",key,[param objectForKey:key]];
            }
        }
        [stringParam replaceCharactersInRange:NSMakeRange([stringParam length]-1, 1) withString:@""];
    }
    return [stringParam stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
- (void)setParamWithMethodPost:(NSDictionary *)param forRequest:(NSMutableURLRequest *)request{
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
