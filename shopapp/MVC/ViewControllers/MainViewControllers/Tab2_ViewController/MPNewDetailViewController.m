//
//  MPNewDetailViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/29/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPNewDetailViewController.h"
#import "MPUIConfigObject.h"
#import "MPTabBarViewController.h"

@interface MPNewDetailViewController ()
@end

@implementation MPNewDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //XIB表示のため、contentViewを非表示
    [contentView setHidden:YES];
    
    //非同期画像セット
    if (newHomeObject.thumbnail) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,newHomeObject.image]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   UIImage *image = nil;
                                   if (!error){
                                       image = [[UIImage alloc] initWithData:data];
                                       // do whatever you want with image
                                   }else{
                                       image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
                                   }
                                   [image_title setImage:image];
                               }];
    }else{

        image_title.translatesAutoresizingMaskIntoConstraints = YES;
        CGRect orig = image_title.frame;
        orig.size.height = 0;
        image_title.frame = orig;
    }
    
    //時間設定
    if(newHomeObject.update_at != nil){
        if(![newHomeObject.update_at isEqualToString:@""]){
            NSArray *dateArr1 = [[[newHomeObject.update_at componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"];
            NSArray *dateArr2 = [[[newHomeObject.update_at componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"];
            [lbl_date setText:[NSString stringWithFormat:@"%@ 年 %@ 月 %@ 日（%@）%@ 時 %@ 分", [dateArr1 objectAtIndex:0], [dateArr1 objectAtIndex:1], [dateArr1 objectAtIndex:2], [self getWeekday:newHomeObject.update_at], [dateArr2 objectAtIndex:0], [dateArr2 objectAtIndex:1]]];
        }
    }
    
    //タイトル
    [lbl_title setText:newHomeObject.title];
    
    //メッセージ設定
    [lbl_message setText:newHomeObject.content];
    [txt_message setText:newHomeObject.content];

    // TEXTFIELDのマージンを０に設定
    txt_message.textContainerInset = UIEdgeInsetsZero;
    txt_message.textContainer.lineFragmentPadding = 0;

    txt_message.delegate=self;
    txt_message.dataDetectorTypes = UIDataDetectorTypeLink;
}

// URL文字列でのサイト表示用
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{

    MPHomeWebViewViewController *webViewVC = [[MPHomeWebViewViewController alloc] initWithNibName:@"MPHomeWebViewViewController" bundle:nil];
    webViewVC.linkUrl = [URL absoluteString];
    [self.navigationController pushViewController:webViewVC animated:YES];

    return NO;
}

//曜日取得
- (NSString*)getWeekday:(NSString*)dateString {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comps = [calendar components:NSWeekdayCalendarUnit
                                          fromDate:[formatter dateFromString:dateString]];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    
    //comps.weekdayは 1-7の値が取得できるので-1する
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    
    return weekDayStr;
}

- (void)setData:(MPNewHomeObject *)newObject {
    
    newHomeObject = newObject;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    if (newHomeObject) {
        
        if (newHomeObject.is_read == 0) {
            //reset badge app here
            if ([MPAppDelegate sharedMPAppDelegate].totalBadge > 0) {
                [MPAppDelegate sharedMPAppDelegate].totalBadge -=1;
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:[MPAppDelegate sharedMPAppDelegate].totalBadge];
            }
            //did read message
            [[ManagerDownload sharedInstance] readMessage:[Utility getDeviceID] withAppID:[Utility getAppID] withMessageID:newHomeObject.id delegate:self];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)backButtonClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
