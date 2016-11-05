//
//  MPTheThirdViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTheThirdViewController.h"
#import "MPTabBarViewController.h"
#import "ProgressView.h"

@interface MPTheThirdViewController ()
@end

@implementation MPTheThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Bluetooth設定確認
    [self detectBluetooth];

    //🔴navigation表示
    [self setNavigationHiden:NO];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //XIB表示のため、contentViewを非表示
    [contentView setHidden:YES];
    
    //会員番号
    self.lbl_recipe.textAlignment = NSTextAlignmentCenter;
    NSString *member_no = [[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_NO];
    if ( [member_no length] > 0 ){
        self.lbl_recipe.text = [NSString stringWithFormat:@"会員ＩＤ %@", member_no];
    }

    [couponStampView removeFromSuperview];
    couponStampView = (MPCouponStampView*)[Utility viewInBundleWithName:@"MPCouponStampView"];
    couponStampView.delegate = self;
    [couponStampView setFrame:CGRectMake(0, 0, self.view_stamp.frame.size.width, self.view_stamp.frame.size.height)];
    [self.view_stamp addSubview:couponStampView];
    [self.view_stamp bringSubviewToFront:couponStampView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
}

#pragma mark - MPCouponStampViewDelegate
- (void)backToCouponTab {
    
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:1];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:1];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backButtonClicked:(UIButton *)sender {

}

- (void)getCurponButtonClicked:(long)No {
    
    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:1];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:3];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUserIDColor:(NSString*)colorNo {
    
    if(![colorNo isEqualToString:@""]){
        
        UIColor* clr_rgb = [self colourFromHexString:colorNo];
        self.view_IdBackColor.backgroundColor = clr_rgb;
    }else{
        
        //カラーコードが無い場合は透明
        self.view_IdBackColor.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    }
}

- (UIColor *)colourFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(void)setInfomation:(NSString*)comment {

    lbl_Infomation.text = comment;
}

- (void)detectBluetooth {
    
    if(!bluetoothManager)
    {
        // Put on main queue so we can call UIAlertView from delegate callbacks.
        bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    [self centralManagerDidUpdateState:bluetoothManager]; // Show initial state
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch(bluetoothManager.state)
    {
        case CBCentralManagerStateResetting:
            NSLog(@"The connection with the system service was momentarily lost, update imminent.");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"The platform doesn't support Bluetooth Low Energy.");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"The app is not authorized to use Bluetooth Low Energy.");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"Bluetooth is currently powered off.");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"Bluetooth is currently powered on and available to use.");
            break;
        default:
            NSLog(@"State unknown, update imminent.");
            break;
    }
}

- (void)setArertCurpon:(NSString*)no {
    
    // 土台設定修正
    //クーポンVIEW表示
    [couponStampView removeFromSuperview];
    couponStampView = (MPCouponStampView*)[Utility viewInBundleWithName:@"MPCouponStampView"];
    // REPLACED BY ama 2016.10.08 END
    couponStampView.delegate = self;
    [couponStampView setFrame:CGRectMake(0, 0, self.view_stamp.frame.size.width, self.view_stamp.frame.size.height)];
    [self.view_stamp addSubview:couponStampView];
    [self.view_stamp bringSubviewToFront:couponStampView];
    
    if([no integerValue] > 0){
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"クーポンを %@ 枚獲得しました\nクーポンを確認しますか？",no]
                                            message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"キャンセル"
                                                  style:UIAlertActionStyleCancel
                                                handler:^(UIAlertAction *action) {
                                                    
                                                }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"確認する"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:1];
                                                    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:3];
                                                    [self.navigationController popViewControllerAnimated:YES];
                                                    
                                                }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)arert_StampErr {
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"認証出来ませんでした。再度お試しください。"
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"閉じる"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)arert_AllStamp:(NSString*)strFromInt UUID:(NSString *)uuid{

    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"スタンプを %@ 個押します。\nよろしいですか？",strFromInt]
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"いいえ"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action) {

                                                [[ProgressView sharedInstance] removeHUD];

                                            }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"はい"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {

                                                [couponStampView setTotalStamp:uuid];

                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)setNotStampForm {

    //スタンプ日付追加
    UILabel* lbl_notStamp = [[UILabel alloc] init];
    lbl_notStamp.frame = CGRectMake(0, 30, couponStampView.frame.size.width, 36);
    lbl_notStamp.backgroundColor = [UIColor clearColor];
    lbl_notStamp.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lbl_notStamp.textColor = [UIColor blackColor];
    lbl_notStamp.textAlignment = NSTextAlignmentCenter;
    lbl_notStamp.text = @"現在スタンプカードはご利用になれません。";
    [couponStampView addSubview:lbl_notStamp];

    scr_inView.translatesAutoresizingMaskIntoConstraints = YES;
    [scr_inView setFrame:CGRectMake(0, 0, scr_inView.frame.size.width, 300)];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
