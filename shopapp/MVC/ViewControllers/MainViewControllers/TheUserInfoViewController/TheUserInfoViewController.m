//
//  TheUserInfoViewController.m
//  Misepuri
//
//  Created by AMA on 2016/09/04.
//

#import "TheUserInfoViewController.h"

@interface TheUserInfoViewController ()
@end

@implementation TheUserInfoViewController

@synthesize TheUserInfoViewControllerDelegate = _TheUserInfoViewControllerDelegate;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //タイトルのグラデーション
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, self.view_title.frame.size.width, self.view_title.frame.size.height);
    gradient.colors = @[
                        (id)[UIColor colorWithRed:0.992 green:0.937 blue:0.831 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.894 green:0.820 blue:0.694 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.780 green:0.706 blue:0.576 alpha:1].CGColor
                        ];
    [self.view_title.layer addSublayer:gradient];
    
    [contentView setHidden:YES];
    
    // INSERT BY ama 2016.09.30 START
    //日付設定用ピッカー設置
    //DataPicker 設定
    datePicker_Birthday = [[UIDatePicker alloc] init];
    datePicker_Birthday.datePickerMode=UIDatePickerModeDate;
    datePicker_Birthday.maximumDate = [NSDate date];
    datePicker_Birthday.backgroundColor = [UIColor whiteColor];
    datePicker_Birthday.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [datePicker_Birthday addTarget:self action:@selector(dateSet_Birthday:) forControlEvents:UIControlEventValueChanged];
    self.txt_birthday.inputView = datePicker_Birthday;
    
    datePicker_ChildeBirthday1 = [[UIDatePicker alloc] init];
    datePicker_ChildeBirthday1.datePickerMode=UIDatePickerModeDate;
    datePicker_ChildeBirthday1.maximumDate = [NSDate date];
    datePicker_ChildeBirthday1.backgroundColor = [UIColor whiteColor];
    datePicker_ChildeBirthday1.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [datePicker_ChildeBirthday1 addTarget:self action:@selector(dateSet_childrenBirthday1:) forControlEvents:UIControlEventValueChanged];
    self.txt_childrenBirthday1.inputView = datePicker_ChildeBirthday1;
    
    datePicker_ChildeBirthday2 = [[UIDatePicker alloc] init];
    datePicker_ChildeBirthday2.datePickerMode=UIDatePickerModeDate;
    datePicker_ChildeBirthday2.maximumDate = [NSDate date];
    datePicker_ChildeBirthday2.backgroundColor = [UIColor whiteColor];
    datePicker_ChildeBirthday2.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [datePicker_ChildeBirthday2 addTarget:self action:@selector(dateSet_childrenBirthday2:) forControlEvents:UIControlEventValueChanged];
    self.txt_childrenBirthday2.inputView = datePicker_ChildeBirthday2;
    //DataPicker上部バー作成
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.backgroundColor = [UIColor whiteColor];
    toolbar.frame=CGRectMake(0, 0, 320, 44);
    //DataPicker上部バーボタン設定
    UIBarButtonItem *item0=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *item3=[[UIBarButtonItem alloc] initWithTitle:@"完了" style:UIBarButtonItemStylePlain target:self action:@selector(previousBtnClick)];
    item3.tintColor = [UIColor blackColor];
    toolbar.items=@[item0,item1,item2,item3];
    //DataPicker上部バー設定
    self.txt_birthday.inputAccessoryView = toolbar;
    self.txt_childrenBirthday1.inputAccessoryView = toolbar;
    self.txt_childrenBirthday2.inputAccessoryView = toolbar;
    // INSERT BY ama 2016.09.30 END
    
    // INSERT BY ama 2016.10.13 START
    // キーボードアクション追加
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    // キーボード表示を検知。
    [nc addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    
    // キーボード収納を検知。
    [nc addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
    
    //NumberPicker上部バー作成
    UIToolbar *numbaer_toolbar = [[UIToolbar alloc] init];
    numbaer_toolbar.backgroundColor = [UIColor whiteColor];
    numbaer_toolbar.frame=CGRectMake(0, 0, 320, 44);
    //DataPicker上部バーボタン設定
    UIBarButtonItem *numbaer_item0=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *numbaer_item1=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *numbaer_item2=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *numbaer_item3=[[UIBarButtonItem alloc] initWithTitle:@"完了" style:UIBarButtonItemStylePlain target:self action:@selector(numbaerBtnClick)];
    numbaer_item3.tintColor = [UIColor blackColor];
    numbaer_toolbar.items=@[numbaer_item0,numbaer_item1,numbaer_item2,numbaer_item3];
    //DataPicker上部バー設定
    self.txt_zipcode.inputAccessoryView = numbaer_toolbar;
    // INSERT BY ama 2016.10.13 END
    
    //性別設定（初期：男）
    lng_sexflag = 1;
    [self setSexChenge:lng_sexflag];

    // INSERT BY ama 2016.10.30 START
    // キーボードアクション追加
    self.txt_nickname.layer.borderWidth=1.0;
    self.txt_nickname.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    self.txt_birthday.layer.borderWidth=1.0;
    self.txt_birthday.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    self.txt_zipcode.layer.borderWidth=1.0;
    self.txt_zipcode.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    self.txt_childrenname1.layer.borderWidth=1.0;
    self.txt_childrenname1.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    self.txt_childrenBirthday1.layer.borderWidth=1.0;
    self.txt_childrenBirthday1.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    self.txt_childrenname2.layer.borderWidth=1.0;
    self.txt_childrenname2.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    self.txt_childrenBirthday2.layer.borderWidth=1.0;
    self.txt_childrenBirthday2.layer.borderColor=[[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0] CGColor];
    // INSERT BY ama 2016.10.30 END
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:YES];
    
    // INSERT BY ama 2016.09.30 START
    //ユーザー情報取得
    [[ManagerDownload sharedInstance] getMemberInfo:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
    // INSERT BY ama 2016.09.30 END
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

// INSERT BY ama 2016.09.30 START
//日付設定用ピッカー設置
-(void)dateSet_Birthday:(UIDatePicker *)picker {
    
    NSDate *selectDate=picker.date;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyy-MM-dd";
    NSString *stringDate=[formatter stringFromDate:selectDate];
    
    self.txt_birthday.text = stringDate;
}
-(void)dateSet_childrenBirthday1:(UIDatePicker *)picker {
    
    NSDate *selectDate=picker.date;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyy-MM-dd";
    NSString *stringDate=[formatter stringFromDate:selectDate];
    
    self.txt_childrenBirthday1.text = stringDate;
}
-(void)dateSet_childrenBirthday2:(UIDatePicker *)picker {
    
    NSDate *selectDate=picker.date;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyy-MM-dd";
    NSString *stringDate=[formatter stringFromDate:selectDate];
    
    self.txt_childrenBirthday2.text = stringDate;
}
-(void)previousBtnClick {
    
    [self.txt_birthday resignFirstResponder];
    [self.txt_childrenBirthday1 resignFirstResponder];
    [self.txt_childrenBirthday2 resignFirstResponder];
}
-(void)numbaerBtnClick {
    
    [self.txt_zipcode resignFirstResponder];
}
// INSERT BY ama 2016.09.30 END

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    switch (param.request_type) {
        // INSERT BY ama 2016.09.30 START
        //新規登録でもユーザー情報を取得するように変更
        case RequestType_GET_MEMBER_INFO:
        {
            if(param.listData.count > 0){
                
                memberObj = param.listData[0];
                
                str_ID = memberObj.id;
                self.txt_nickname.text = memberObj.nick_name;
                lng_sexflag = memberObj.gender;
                [self setSexChenge:lng_sexflag];
                self.txt_birthday.text = memberObj.birthday;
                // INSERTED BY M.ama 2016.10.28 START
                //子供の誕生日設定済みの場合編集出来なくする
                if(![memberObj.birthday isEqualToString:@""]){
                    self.txt_birthday.enabled = NO;
                }
                // INSERTED BY M.ama 2016.10.28 END
                self.txt_zipcode.text = memberObj.zipcode;
                self.txt_childrenname1.text = memberObj.child1_name;
                self.txt_childrenBirthday1.text = memberObj.child1_birthday;
                // INSERT BY ama 2016.09.30 START
                //子供の誕生日設定済みの場合編集出来なくする
                if(![memberObj.child1_birthday isEqualToString:@""]){
                    self.txt_childrenBirthday1.enabled = NO;
                }
                // INSERT BY ama 2016.09.30 END
                self.txt_childrenname2.text = memberObj.child2_name;
                self.txt_childrenBirthday2.text = memberObj.child2_birthday;
                // INSERT BY ama 2016.09.30 START
                //子供の誕生日設定済みの場合編集出来なくする
                if(![memberObj.child2_birthday isEqualToString:@""]){
                    self.txt_childrenBirthday2.enabled = NO;
                }
                // INSERT BY ama 2016.09.30 END
                
            }else{
                
                UIAlertController *alert =
                [UIAlertController alertControllerWithTitle:@"読み込みエラー"
                                                    message:@"サーバーからデータ取得できませんでした。"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            
                                                        }]];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
            break;
        // INSERT BY ama 2016.09.30 END
        case RequestType_SET_MEMBER_INFO:
        {
            // 初期値コミット
            [Configuration setFirstUserInfoSet:YES];
            
            //画面クローズ
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

// INSERT BY ama 2016.10.13 START
// キーボードアクション追加
-(void)setSexChenge:(long)flag {
    
    //キーボードクローズ
    [self.txt_nickname resignFirstResponder];
    [self.txt_birthday resignFirstResponder];
    [self.txt_zipcode resignFirstResponder];
    [self.txt_childrenname1 resignFirstResponder];
    [self.txt_childrenBirthday1 resignFirstResponder];
    [self.txt_childrenname2 resignFirstResponder];
    [self.txt_childrenBirthday2 resignFirstResponder];
    
    switch (flag) {
        case 1:
            
            [self.btnF_boy setTitle:@"男 ◉" forState:UIControlStateNormal];
            [self.btnF_girl setTitle:@"女 ○" forState:UIControlStateNormal];
            break;
            
        case 2:
            
            [self.btnF_boy setTitle:@"男 ○" forState:UIControlStateNormal];
            [self.btnF_girl setTitle:@"女 ◉" forState:UIControlStateNormal];
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"scrool:%f",scrollView.contentOffset.y);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    NSLog(@"height : %f", rect_screen.size.height);
    
    if(textField == self.txt_nickname){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 74;
    }
    
    if(textField == self.txt_birthday){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 194;
    }
    
    if(textField == self.txt_zipcode){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 254;
    }
    
    if(textField == self.txt_childrenname1){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 314;
    }
    
    if(textField == self.txt_childrenBirthday1){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 374;
    }
    
    if(textField == self.txt_childrenname2){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 434;
    }
    
    if(textField == self.txt_childrenBirthday2){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 494;
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
    
    [self.scr_view setContentOffset:cgpoint_reset animated:YES];
}

- (void)enterButton:(UIButton*)sender {
    
    //キーボードクローズ
    [self.txt_nickname resignFirstResponder];
    [self.txt_birthday resignFirstResponder];
    [self.txt_zipcode resignFirstResponder];
    [self.txt_childrenname1 resignFirstResponder];
    [self.txt_childrenBirthday1 resignFirstResponder];
    [self.txt_childrenname2 resignFirstResponder];
    [self.txt_childrenBirthday2 resignFirstResponder];
}

- (void)hideKeyboard:(NSNotification*)notification {
    
    //キーボードクローズ
    [self.txt_nickname resignFirstResponder];
    [self.txt_birthday resignFirstResponder];
    [self.txt_zipcode resignFirstResponder];
    [self.txt_childrenname1 resignFirstResponder];
    [self.txt_childrenBirthday1 resignFirstResponder];
    [self.txt_childrenname2 resignFirstResponder];
    [self.txt_childrenBirthday2 resignFirstResponder];
}
// INSERT BY ama 2016.10.13 END

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

// REPLACED BY M.ama 2016.10.09 START
// 郵便番号にて数字以外入れれないように
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //space remove
    if (![string compare:@" "]) {
        return NO;
    }
    
    // 変更前のtextを取得
    NSMutableString *tmp =[textField.text mutableCopy];
    // 編集後のtext
    [tmp replaceCharactersInRange:range withString:string];
    
    // INSERT BY ama 2016.09.30 START
    // 入力文字数制限
    
    //ニックネーム入力規制
    if(textField == self.txt_nickname){
        
        return [tmp lengthOfBytesUsingEncoding:NSShiftJISStringEncoding] <= 20;
    }
    
    //郵便番号入力規制
    if(textField == self.txt_zipcode){
        
        if(![self containsOnlyDecimalNumbers1:tmp]){
            
            return NO;
        }
        
        return [tmp lengthOfBytesUsingEncoding:NSShiftJISStringEncoding] <= 7;
    }
    // INSERT BY ama 2016.09.30 END
    
    return YES;
}

- (BOOL)containsOnlyDecimalNumbers1:(NSString *)string
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:string];
    return [[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:characterSet];

}
// REPLACED BY M.ama 2016.10.09 END

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.txt_nickname){
        
        // 受け取った入力をラベルに代入
        self.txt_nickname.text = textField.text;
    }
    
    if(textField == self.txt_birthday){
        
        // 受け取った入力をラベルに代入
        self.txt_birthday.text = textField.text;
    }
    
    if(textField == self.txt_zipcode){
        
        // 受け取った入力をラベルに代入
        self.txt_zipcode.text = textField.text;
    }
    
    if(textField == self.txt_childrenname1){
        
        // 受け取った入力をラベルに代入
        self.txt_childrenname1.text = textField.text;
    }
    
    if(textField == self.txt_childrenBirthday1){
        
        // 受け取った入力をラベルに代入
        self.txt_childrenBirthday1.text = textField.text;
    }
    
    if(textField == self.txt_childrenname2){
        
        // 受け取った入力をラベルに代入
        self.txt_childrenname2.text = textField.text;
    }
    
    if(textField == self.txt_childrenBirthday2){
        
        // 受け取った入力をラベルに代入
        self.txt_childrenBirthday2.text = textField.text;
    }
    
    // キーボードを閉じる
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)btn_boy:(id)sender {
    
    //性別変更
    lng_sexflag = 1;
    [self setSexChenge:lng_sexflag];
}

- (IBAction)btn_girl:(id)sender {
    
    //性別変更
    lng_sexflag = 2;
    [self setSexChenge:lng_sexflag];
}

- (IBAction)btn_start:(id)sender {
    
    // INSERT BY ama 2016.09.30 START
    // 文字チェック追加
    //文字数チェック
    BOOL bln_LengthCheck = YES;
    if(self.txt_nickname.text.length == 0){
        
        bln_LengthCheck = NO;
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"ニックネームが設定されていません。"
                                            message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    if(self.txt_birthday.text.length < 4){
        
        bln_LengthCheck = NO;
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"生年月日が設定されていません。"
                                            message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    if(self.txt_zipcode.text.length < 7){
        
        bln_LengthCheck = NO;
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"郵便番号の入力桁数が足りません。"
                                            message:@"7桁で入力してください。"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    if(![self.txt_childrenname1.text isEqualToString:@""]){
        
        if(self.txt_childrenBirthday1.text.length == 0){
            
            bln_LengthCheck = NO;
            
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"お子様（１）の生年月日が設定されていません。"
                                                message:@""
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        
        if(self.txt_childrenBirthday1.text.length > 0){
            
            bln_LengthCheck = NO;
            
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"お子様（１）の生年月日が設定されていますが、名前が設定されていません。"
                                                message:@""
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if(![self.txt_childrenname2.text isEqualToString:@""]){
        
        if(self.txt_childrenBirthday2.text.length == 0){
            
            bln_LengthCheck = NO;
            
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"お子様（２）の生年月日が設定されていません。"
                                                message:@""
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        
        if(self.txt_childrenBirthday2.text.length > 0){
            
            bln_LengthCheck = NO;
            
            UIAlertController *alert =
            [UIAlertController alertControllerWithTitle:@"お子様（２）の生年月日が設定されていますが、名前が設定されていません。"
                                                message:@""
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    if(bln_LengthCheck == YES){

        // INSERTED BY M.ama 2016.10.27 START
        // アラートカスタマイズ
        MPSettingAlertView *alertView = (MPSettingAlertView*) [Utility viewInBundleWithName:@"MPSettingAlertView"];
        alertView.delegate = self;
        [[MPAppDelegate sharedMPAppDelegate].window addSubview:alertView];
        // INSERTED BY M.ama 2016.10.27 END
    }
    // INSERT BY ama 2016.09.30 END
}

// INSERT BY ama 2016.10.27 START
// カスタムアラート
-(void)setUserData {

    //ユーザー情報取得
    [[ManagerDownload sharedInstance] setMemberInfo:str_ID withAppID:[Utility getAppID] withMemberNO:[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_NO] withDeviceID:[Utility getDeviceID] withNickName:self.txt_nickname.text withGender:lng_sexflag withBirthday:self.txt_birthday.text withZipcode:self.txt_zipcode.text withChild1Name:self.txt_childrenname1.text withChild1Birthday:self.txt_childrenBirthday1.text withChild2Name:self.txt_childrenname2.text withChild2Birthday:self.txt_childrenBirthday2.text delegate:self];
}
// INSERT BY ama 2016.10.27 END

- (IBAction)btn_skip:(id)sender {

    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@""
                                        message:@"ユーザ情報は設定画面よりいつでも登録できます。\nご登録いただくとお得なクーポンが貰えます"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"確 認"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                
                                                // 初期値コミット
                                                [Configuration setFirstUserInfoSet:YES];
                                                
                                                //画面クローズ
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
