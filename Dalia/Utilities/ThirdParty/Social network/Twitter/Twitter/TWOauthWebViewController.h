//
//  TWOauthWebViewController.h
//  Twipple
//
//  Created by NEC VIETNAM on 3/6/13.
//  Copyright (c) 2013 NECVN-BIGLOBE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"
typedef enum {
    MedthodRequestGet,
    MedthodRequestPost
} MedthodRequest;

//typedef NS_ENUM(NSInteger,ShareType){
//    
//    ShareTwitter = 200,
//    ShareLinkedIn = 300
//};
@protocol TWOauthWebViewControllerDelegate <NSObject>

- (void) resultOfShareContentProcess:(NSError*) error;

@end
@interface TWOauthWebViewController : UIViewController <UIWebViewDelegate, UITextFieldDelegate>{
	UIActivityIndicatorView *spinner;
	UIWebView *webView;
	OAToken *requestToken;
    NSString *screenName;
}
@property (nonatomic,strong) NSString *content;
@property (nonatomic, assign) id<TWOauthWebViewControllerDelegate> delegate;
//@property (nonatomic, weak) id<UIViewControllerPresentDelegate> delegate;
@end
