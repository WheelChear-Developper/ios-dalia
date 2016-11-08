//
//  MPTransferViewController.m
//  
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTransferViewController.h"

@interface MPTransferViewController () <UITextFieldDelegate> {
    NSString* transfer_code;
}

@property (strong, nonatomic) IBOutlet UIScrollView *baseView;
@property (strong, nonatomic) IBOutlet UILabel *labelTransferCode;
@property (strong, nonatomic) IBOutlet UITextField *activeTextFeild;
@property (strong, nonatomic) IBOutlet UIView *inputView;
@property (strong, nonatomic) IBOutlet UIButton *btnTransfer;
@property (strong, nonatomic) IBOutlet UITextField *textTransferCode;

@end

@implementation MPTransferViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //🔴navigation表示
    [self setBasicNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //xib表示設定
    [contentView setHidden:YES];
    
    // Do any additional setup after loading the view from its nib.
    [[ManagerDownload sharedInstance] getTransferCode:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
    
    NSString *isTransfer = [[NSUserDefaults standardUserDefaults] objectForKey:IS_TRANSFER];
    if ( [isTransfer isEqualToString:@"OK"] ){
        [self closeTransfer];
    }

    // キーボードアクション追加
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    // キーボード表示を検知。
    [nc addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];

    // キーボード収納を検知。
    [nc addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:YES];
}

-(void)viewWillDisappear:(BOOL)animated {

}

- (void)downloadDataSuccess:(DownloadParam *)param {

    NSLog(@"listData = %@", param.listData);
    UIAlertView* alertView;
    switch(param.request_type){
        case RequestType_SET_TRANSFER_DIVESE:
        case RequestType_DEL_TRANSFER_CODE:
            NSLog(@"param = %@", param);
            if ( [param.listData count] <= 0 ){
                NSLog(@"NO");
                alertView = [[UIAlertView alloc] initWithTitle:nil message:@"旧端末からの引継ぎ設定をもう一度やり直してください。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }else if ( [param.listData[0][@"result"] isEqualToString:@"transfer"] ){
                NSLog(@"YES");
                
                [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:IS_TRANSFER];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self closeTransfer];

                alertView = [[UIAlertView alloc] initWithTitle:nil message:@"旧端末からの引継ぎ設定が完了しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
        default:
            if ( param.result_code == 202 ) {
                transfer_code = @"";
                [[NSUserDefaults standardUserDefaults] setObject:@"OK" forKey:IS_TRANSFER];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:MEMBER_NO];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self closeTransfer];
                //alertView = [[UIAlertView alloc] initWithTitle:nil message:@"デバイスが未登録です。\nアプリを再起動してください" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //[alertView show];
            }else{
                transfer_code = param.listData[0][@"transfer_code"];
            }
            [self updateTermCondition];
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
    
    [self updateTermCondition];
}

- (void)backButtonClicked:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    NSLog(@"height : %f", rect_screen.size.height);

    if(textField == self.activeTextFeild){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 190;
    }
    kb_type = textField.keyboardType;

    return YES;
}

- (void)showKeyboard:(NSNotification*)notification {

    // ステータスバーをのぞいた画面高さ
    float afh = [[UIScreen mainScreen] applicationFrame].size.height;

    // キーボード高さ
    CGRect keyboard;
    keyboard = [[notification.userInfo
                 objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float kbh = keyboard.size.height;

    CGPoint cgpoint_reset = cgpoint_tf;

    float flt_SetScreenSize = (afh - 44 - 33 - kbh);
    float flt_SetScroolPoint = 8 + cgpoint_tf.y + 60;

    if(flt_SetScroolPoint < flt_SetScreenSize){

        cgpoint_reset.y = 0;
    }else{

        cgpoint_reset.y = flt_SetScroolPoint - flt_SetScreenSize + 7;
    }

    [self.baseView setContentOffset:cgpoint_reset animated:YES];
}

- (void)enterButton:(UIButton*)sender {

    //キーボードクローズ
    [self.activeTextFeild resignFirstResponder];
    [self.baseView setContentOffset:CGPointMake(0, -20) animated:YES];
}

- (void)hideKeyboard:(NSNotification*)notification {

    //キーボードクローズ
    [self.activeTextFeild resignFirstResponder];
    [self.baseView setContentOffset:CGPointMake(0, -20) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    // キーボードを閉じる
    [textField resignFirstResponder];
    [self.baseView setContentOffset:CGPointMake(0, -20) animated:YES];
    return YES;
}

- (void) updateTermCondition {
    
    _labelTransferCode.text = transfer_code;
    
    [self setHiddenBackButton:NO];
}

- (IBAction)changeTransferButtonClicked:(UIButton *)sender {
    
    UIAlertView* alertView;
    if ( _activeTextFeild.text.length <= 0 ){
        alertView = [[UIAlertView alloc] initWithTitle:nil message:@"引継ぎコードを入力してください。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    NSLog(@"getDeviceID = %@", [Utility getDeviceID]);
    [[ManagerDownload sharedInstance] setTransferDevice:[Utility getDeviceID] withAppID:[Utility getAppID] transfer_code:_activeTextFeild.text delegate:self];
}

-(void)closeTransfer {
    
    _btnTransfer.hidden = YES;
    _textTransferCode.enabled = NO;
}

@end
