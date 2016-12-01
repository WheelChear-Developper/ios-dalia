//
//  FirstSettingViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "FirstSettingViewController.h"

@interface FirstSettingViewController ()
@end

@implementation FirstSettingViewController

@synthesize FirstSettingViewControllerDelegate = _FirstSettingViewControllerDelegate;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示切り替え
    [_contentView setHidden:YES];

    //load cell xib and attach with collectionView
    UINib *nib1 = [UINib nibWithNibName:@"MPFirstSetting_nick_name_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib1 forCellReuseIdentifier:@"first_nickname_Identifier"];
    UINib *nib2 = [UINib nibWithNibName:@"MPFirstSetting_gender_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib2 forCellReuseIdentifier:@"first_gender_Identifier"];
    UINib *nib3 = [UINib nibWithNibName:@"MPFirstSetting_mail_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib3 forCellReuseIdentifier:@"first_mail_Identifier"];
    UINib *nib4 = [UINib nibWithNibName:@"MPFirstSetting_job_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib4 forCellReuseIdentifier:@"first_job_Identifier"];
    UINib *nib5 = [UINib nibWithNibName:@"MPFirstSetting_zipcode_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib5 forCellReuseIdentifier:@"first_zipcode_Identifier"];
    UINib *nib6 = [UINib nibWithNibName:@"MPFirstSetting_address_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib6 forCellReuseIdentifier:@"first_address_Identifier"];
    UINib *nib7 = [UINib nibWithNibName:@"MPFirstSetting_name_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib7 forCellReuseIdentifier:@"first_name_Identifier"];
    UINib *nib8 = [UINib nibWithNibName:@"MPFirstSetting_furigana_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib8 forCellReuseIdentifier:@"first_furigana_Identifier"];
    UINib *nib9 = [UINib nibWithNibName:@"MPFirstSetting_tel_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib9 forCellReuseIdentifier:@"first_tel_Identifier"];
    UINib *nib10 = [UINib nibWithNibName:@"MPFirstSetting_generation_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib10 forCellReuseIdentifier:@"first_generation_Identifier"];
    UINib *nib11 = [UINib nibWithNibName:@"MPFirstSetting_shop_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib11 forCellReuseIdentifier:@"first_shop_Identifier"];
    UINib *nib12 = [UINib nibWithNibName:@"MPFirstSetting_birthday_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib12 forCellReuseIdentifier:@"first_birthday_Identifier"];
    [_tbl_userSetting reloadData];







/*


    [self.txt_farstName setTintColor:UIColor.whiteColor];
    [self.txt_lastName setTintColor:UIColor.whiteColor];
    [self.txt_nickName setTintColor:UIColor.whiteColor];
    [self.txt_birthday setTintColor:UIColor.whiteColor];
    [self.txt_zipCode setTintColor:UIColor.whiteColor];
    [self.txt_introductionCode setTintColor:UIColor.whiteColor];
    [self.txt_machineChengeCode setTintColor:UIColor.whiteColor];

    //ヒント文字色設定
    UIColor *color = [UIColor colorWithRed:124/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    self.txt_farstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"姓"
                                                                           attributes:@{ NSForegroundColorAttributeName:color }];
    self.txt_lastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"名"
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];
    self.txt_nickName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];
    self.txt_birthday.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"月・日は記入せず、４ケタの数字をご入力ください。例：0620"
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];
    self.txt_zipCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"ハイフンはなしでご入力ください"
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];
    self.txt_introductionCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"例：123456"
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];
    self.txt_machineChengeCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"例：12345678"
                                                                               attributes:@{ NSForegroundColorAttributeName:color }];

    //DataPicker 設定
    datePicker_Birthday = [[UIDatePicker alloc] init];
    datePicker_Birthday.datePickerMode=UIDatePickerModeDate;
    datePicker_Birthday.maximumDate = [NSDate date];
    datePicker_Birthday.backgroundColor = [UIColor whiteColor];
    datePicker_Birthday.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [datePicker_Birthday addTarget:self action:@selector(dateSet_Birthday:) forControlEvents:UIControlEventValueChanged];
    self.txt_birthday.inputView = datePicker_Birthday;

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
*/
    // キーボードアクション追加
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];

    // キーボード表示を検知
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
//    self.txt_zipCode.inputAccessoryView = numbaer_toolbar;
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴navigation表示
    [self setHidden_BasicNavigation:YES];
    [self setHidden_CustomNavigation:YES];

    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    [super viewWillAppear:animated];

    //会員情報保存項目取得
    [[ManagerDownload sharedInstance] getMemberInfo:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void)dateSet_Birthday:(UIDatePicker *)picker {
    
    NSDate *selectDate=picker.date;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyy-MM-dd";
    NSString *stringDate=[formatter stringFromDate:selectDate];
    
//    self.txt_birthday.text = stringDate;
}

-(void)previousBtnClick {
    
//    [self.txt_birthday resignFirstResponder];
}
-(void)numbaerBtnClick {
    
//    [self.txt_zipCode resignFirstResponder];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    switch (param.request_type) {
        case RequestType_GET_MEMBER_INFO:
        {
            if(param.listData.count > 0){
                
                memberObj = param.listData[0];

                [_tbl_userSetting reloadData];

                [self resizeTable];
            }
        }
            break;

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

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [memberObj.fld_colom count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 67;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_userSetting){

        //ニックネーム
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"nick_name"]){

            MPFirstSetting_nick_name_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_nickname_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_nick_name_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];
            
            return cell;
        }

        //性別
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"gender"]){

            MPFirstSetting_gender_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_gender_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_gender_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //メール
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"mail"]){

            MPFirstSetting_mail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_mail_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_mail_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //職業
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"job"]){

            MPFirstSetting_job_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_job_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_job_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //郵便番号
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"zipcode"]){

            MPFirstSetting_zipcode_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_zipcode_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_zipcode_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //住所
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"address"]){

            MPFirstSetting_address_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_address_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_address_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //名前
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"name1"]){

            MPFirstSetting_name_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_name_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_name_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //ふりがな
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"furigana1"]){

            MPFirstSetting_furigana_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_furinaga_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_furigana_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //電話
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"tel"]){

            MPFirstSetting_tel_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_tel_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_tel_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //年代
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"generation"]){

            MPFirstSetting_generation_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_generation_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_generation_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //利用店舗
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"shop"]){

            MPFirstSetting_shop_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_shop_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_shop_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }

        //誕生日
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"birthday"]){

            MPFirstSetting_birthday_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first_birthday_Identifier"];
            if(cell == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_birthday_TableViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }

            cell.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell;
        }
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

     if(tableView == _RecommendMenuList_tableView){

     MPRecommendMenuInfoViewController *vc = [[MPRecommendMenuInfoViewController alloc] initWithNibName:@"MPRecommendMenuInfoViewController" bundle:nil];
     vc.delegate = self;

     [self.navigationController pushViewController:vc animated:YES];
     }

     if(tableView == _WhatsNew_tableView){

     MPWhatNewInfoViewController *vc = [[MPWhatNewInfoViewController alloc] initWithNibName:@"MPWhatNewInfoViewController" bundle:nil];
     vc.delegate = self;
     
     [self.navigationController pushViewController:vc animated:YES];
     }
     */
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_userSetting.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_userSetting.frame = CGRectMake(_tbl_userSetting.frame.origin.x, _tbl_userSetting.frame.origin.y, _tbl_userSetting.frame.size.width, 0);
    _tbl_userSetting.frame =
    CGRectMake(_tbl_userSetting.frame.origin.x,
               _tbl_userSetting.frame.origin.y,
               _tbl_userSetting.contentSize.width,
               MAX(_tbl_userSetting.contentSize.height,
                   _tbl_userSetting.bounds.size.height));

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"scrool:%f",scrollView.contentOffset.y);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    NSLog(@"height : %f", rect_screen.size.height);
/*
    if(textField == self.txt_farstName){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 0;
    }
    
    if(textField == self.txt_lastName){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 0;
    }
    
    if(textField == self.txt_nickName){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 254;
    }

    if(textField == self.txt_birthday){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 254;
    }

    if(textField == self.txt_zipCode){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 314;
    }
    
    if(textField == self.txt_introductionCode){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 374;
    }
    
    if(textField == self.txt_machineChengeCode){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 434;
    }
    
    kb_type = textField.keyboardType;
    */
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
//    [self.txt_farstName resignFirstResponder];
//    [self.txt_lastName resignFirstResponder];
//    [self.txt_nickName resignFirstResponder];
//    [self.txt_birthday resignFirstResponder];
//    [self.txt_zipCode resignFirstResponder];
//    [self.txt_introductionCode resignFirstResponder];
//    [self.txt_machineChengeCode resignFirstResponder];
}

- (void)hideKeyboard:(NSNotification*)notification {
    
    //キーボードクローズ
//    [self.txt_farstName resignFirstResponder];
//    [self.txt_lastName resignFirstResponder];
//    [self.txt_nickName resignFirstResponder];
//    [self.txt_birthday resignFirstResponder];
//    [self.txt_zipCode resignFirstResponder];
//    [self.txt_introductionCode resignFirstResponder];
//    [self.txt_machineChengeCode resignFirstResponder];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //space remove
    if (![string compare:@" "]) {
        return NO;
    }
    
    // 変更前のtextを取得
    NSMutableString *tmp =[textField.text mutableCopy];
    // 編集後のtext
    [tmp replaceCharactersInRange:range withString:string];
/*
    //ニックネーム入力規制
    if(textField == self.txt_nickName){
        
        return [tmp lengthOfBytesUsingEncoding:NSShiftJISStringEncoding] <= 20;
    }
    
    //郵便番号入力規制
    if(textField == self.txt_zipCode){
        
        if(![self containsOnlyDecimalNumbers1:tmp]){
            
            return NO;
        }
        
        return [tmp lengthOfBytesUsingEncoding:NSShiftJISStringEncoding] <= 7;
    }
*/
    return YES;
}

- (BOOL)containsOnlyDecimalNumbers1:(NSString *)string
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:string];
    return [[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:characterSet];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
/*
    if(textField == self.txt_farstName){
        
        // 受け取った入力をラベルに代入
        self.txt_farstName.text = textField.text;
    }
    
    if(textField == self.txt_lastName){
        
        // 受け取った入力をラベルに代入
        self.txt_lastName.text = textField.text;
    }
    
    if(textField == self.txt_nickName){
        
        // 受け取った入力をラベルに代入
        self.txt_nickName.text = textField.text;
    }

    if(textField == self.txt_birthday){

        // 受け取った入力をラベルに代入
        self.txt_birthday.text = textField.text;
    }

    if(textField == self.txt_zipCode){
        
        // 受け取った入力をラベルに代入
        self.txt_zipCode.text = textField.text;
    }
    
    if(textField == self.txt_introductionCode){
        
        // 受け取った入力をラベルに代入
        self.txt_introductionCode.text = textField.text;
    }
    
    if(textField == self.txt_machineChengeCode){
        
        // 受け取った入力をラベルに代入
        self.txt_machineChengeCode.text = textField.text;
    }
*/
    // キーボードを閉じる
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)btn_start:(id)sender {
/*
    //文字数チェック
    BOOL bln_LengthCheck = YES;
    if(self.txt_nickName.text.length == 0){
        
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
    if(self.txt_zipCode.text.length < 7){
        
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
    
    if(bln_LengthCheck == YES){

//        MPSettingAlertView *alertView = (MPSettingAlertView*) [Utility viewInBundleWithName:@"MPSettingAlertView"];
//        alertView.delegate = self;
//        [[MPAppDelegate sharedMPAppDelegate].window addSubview:alertView];

    }
*/

}

-(void)setUserData {

    //ユーザー情報取得
//    [[ManagerDownload sharedInstance] setMemberInfo:str_ID withAppID:[Utility getAppID] withMemberNO:[[NSUserDefaults standardUserDefaults] objectForKey:MEMBER_NO] withDeviceID:[Utility getDeviceID] withNickName:self.txt_nickname.text withGender:lng_sexflag withBirthday:self.txt_birthday.text withZipcode:self.txt_zipcode.text withChild1Name:self.txt_childrenname1.text withChild1Birthday:self.txt_childrenBirthday1.text withChild2Name:self.txt_childrenname2.text withChild2Birthday:self.txt_childrenBirthday2.text delegate:self];
}

- (IBAction)btn_skip:(id)sender {
/*
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
 */

    //初期値コミット
    [Configuration setFirstUserInfoSet:YES];

    //画面クローズ
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
