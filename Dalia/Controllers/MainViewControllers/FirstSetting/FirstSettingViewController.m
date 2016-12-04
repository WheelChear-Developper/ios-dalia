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

    [self.txt_introductionCode setTintColor:UIColor.whiteColor];

    if(self.txt_introductionCode.placeholder != nil){
        UIColor *color = [UIColor colorWithRed:124/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
        self.txt_introductionCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.txt_introductionCode.placeholder                                                                           attributes:@{ NSForegroundColorAttributeName:color }];
    }





/*


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

            cell_nick_name = [tableView dequeueReusableCellWithIdentifier:@"first_nickname_Identifier"];
            if(cell_nick_name == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_nick_name_TableViewCell" owner:self options:nil];
                cell_nick_name = [nib objectAtIndex:0];
            }
            cell_nick_name.txt_field.delegate = self;

            cell_nick_name.IndexPathRow = indexPath.row;

            cell_nick_name.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_nick_name.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_nick_name.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];
            
            return cell_nick_name;
        }

        //性別
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"gender"]){

            cell_gender = [tableView dequeueReusableCellWithIdentifier:@"first_gender_Identifier"];
            if(cell_gender == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_gender_TableViewCell" owner:self options:nil];
                cell_gender = [nib objectAtIndex:0];
            }
            cell_gender.txt_field.delegate = self;

            cell_gender.IndexPathRow = indexPath.row;

            cell_gender.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_gender.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_gender.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_gender;
        }

        //メール
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"mail"]){

            cell_mail = [tableView dequeueReusableCellWithIdentifier:@"first_mail_Identifier"];
            if(cell_mail == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_mail_TableViewCell" owner:self options:nil];
                cell_mail = [nib objectAtIndex:0];
            }
            cell_mail.txt_field.delegate = self;

            cell_mail.IndexPathRow = indexPath.row;

            cell_mail.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_mail.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_mail.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_mail;
        }

        //職業
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"job"]){

            cell_job = [tableView dequeueReusableCellWithIdentifier:@"first_job_Identifier"];
            if(cell_job == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_job_TableViewCell" owner:self options:nil];
                cell_job = [nib objectAtIndex:0];
            }
            cell_job.txt_field.delegate = self;

            cell_job.IndexPathRow = indexPath.row;

            cell_job.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_job.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_job.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_job;
        }

        //郵便番号
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"zipcode"]){

            cell_zipcode = [tableView dequeueReusableCellWithIdentifier:@"first_zipcode_Identifier"];
            if(cell_zipcode == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_zipcode_TableViewCell" owner:self options:nil];
                cell_zipcode = [nib objectAtIndex:0];
            }
            cell_zipcode.txt_field.delegate = self;

            cell_zipcode.IndexPathRow = indexPath.row;

            cell_zipcode.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_zipcode.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_zipcode.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_zipcode;
        }

        //住所
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"address"]){

            cell_address = [tableView dequeueReusableCellWithIdentifier:@"first_address_Identifier"];
            if(cell_address == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_address_TableViewCell" owner:self options:nil];
                cell_address = [nib objectAtIndex:0];
            }
            cell_address.txt_field.delegate = self;

            cell_address.IndexPathRow = indexPath.row;

            cell_address.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_address.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_address.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_address;
        }

        //名前
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"name1"]){

            cell_name = [tableView dequeueReusableCellWithIdentifier:@"first_name_Identifier"];
            if(cell_name == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_name_TableViewCell" owner:self options:nil];
                cell_name = [nib objectAtIndex:0];
            }
            cell_name.txt_field1.delegate = self;
            cell_name.txt_field2.delegate = self;

            cell_name.IndexPathRow = indexPath.row;

            cell_name.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_name.txt_field1.text = [Utility checkNULL:[[memberObj.fld_value objectAtIndex:indexPath.row] objectAtIndex:0]];
            cell_name.txt_field2.text = [Utility checkNULL:[[memberObj.fld_value objectAtIndex:indexPath.row] objectAtIndex:1]];

            [cell_name.txt_field1 addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];
            [cell_name.txt_field2 addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_name;
        }

        //ふりがな
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"furigana1"]){

            cell_furigana = [tableView dequeueReusableCellWithIdentifier:@"first_furinaga_Identifier"];
            if(cell_furigana == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_furigana_TableViewCell" owner:self options:nil];
                cell_furigana = [nib objectAtIndex:0];
            }
            cell_furigana.txt_field1.delegate = self;
            cell_furigana.txt_field2.delegate = self;

            cell_furigana.IndexPathRow = indexPath.row;

            cell_furigana.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_furigana.txt_field1.text = [Utility checkNULL:[[memberObj.fld_value objectAtIndex:indexPath.row] objectAtIndex:0]];
            cell_furigana.txt_field2.text = [Utility checkNULL:[[memberObj.fld_value objectAtIndex:indexPath.row] objectAtIndex:1]];

            [cell_furigana.txt_field1 addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];
            [cell_furigana.txt_field2 addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_furigana;
        }

        //電話
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"tel"]){

            cell_tel = [tableView dequeueReusableCellWithIdentifier:@"first_tel_Identifier"];
            if(cell_tel == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_tel_TableViewCell" owner:self options:nil];
                cell_tel = [nib objectAtIndex:0];
            }
            cell_tel.txt_field.delegate = self;

            cell_tel.IndexPathRow = indexPath.row;

            cell_tel.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_tel.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_tel.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_tel;
        }

        //年代
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"generation"]){

            cell_generation = [tableView dequeueReusableCellWithIdentifier:@"first_generation_Identifier"];
            if(cell_generation == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_generation_TableViewCell" owner:self options:nil];
                cell_generation = [nib objectAtIndex:0];
            }
            cell_generation.txt_field.delegate = self;

            cell_generation.IndexPathRow = indexPath.row;

            cell_generation.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_generation.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_generation.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_generation;
        }

        //利用店舗
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"shop"]){

            cell_shop = [tableView dequeueReusableCellWithIdentifier:@"first_shop_Identifier"];
            if(cell_shop == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_shop_TableViewCell" owner:self options:nil];
                cell_shop = [nib objectAtIndex:0];
            }
            cell_shop.txt_field.delegate = self;

            cell_shop.IndexPathRow = indexPath.row;

            cell_shop.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_shop.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_shop.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_shop;
        }

        //誕生日
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"birthday"]){

            cell_birthday = [tableView dequeueReusableCellWithIdentifier:@"first_birthday_Identifier"];
            if(cell_birthday == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPFirstSetting_birthday_TableViewCell" owner:self options:nil];
                cell_birthday = [nib objectAtIndex:0];
            }
            cell_birthday.txt_field.delegate = self;

            cell_birthday.IndexPathRow = indexPath.row;

            cell_birthday.lbl_name.text = [Utility checkNULL:[memberObj.fld_colom objectAtIndex:indexPath.row]];
            cell_birthday.txt_field.text = [Utility checkNULL:[memberObj.fld_value objectAtIndex:indexPath.row]];

            [cell_birthday.txt_field addTarget:self action:@selector(getTextfield) forControlEvents:UIControlEventEditingDidEnd];

            return cell_birthday;
        }
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)getTextfield {

    //会員情報保存項目取得
    NSMutableArray* ary_field = [[NSMutableArray alloc] init];
    for(long l=0;l<memberObj.fld_value.count;l++){

        if([[memberObj.fld_name objectAtIndex:l] isEqualToString:@"name1"]){

            NSMutableArray* ary1 = [[NSMutableArray alloc] init];
            [ary1 addObject:@"name1"];
            [ary1 addObject:[[memberObj.fld_value objectAtIndex:l] objectAtIndex:0]];

            [ary_field addObject:ary1];

            NSMutableArray* ary2 = [[NSMutableArray alloc] init];
            [ary2 addObject:@"name2"];
            [ary2 addObject:[[memberObj.fld_value objectAtIndex:l] objectAtIndex:1]];

            [ary_field addObject:ary2];
        }else
        if([[memberObj.fld_name objectAtIndex:l] isEqualToString:@"furigana1"]){

            NSMutableArray* ary1 = [[NSMutableArray alloc] init];
            [ary1 addObject:@"furigana1"];
            [ary1 addObject:[[memberObj.fld_value objectAtIndex:l] objectAtIndex:0]];

            [ary_field addObject:ary1];

            NSMutableArray* ary2 = [[NSMutableArray alloc] init];
            [ary2 addObject:@"furigana2"];
            [ary2 addObject:[[memberObj.fld_value objectAtIndex:l] objectAtIndex:1]];

            [ary_field addObject:ary2];
        }else{

            NSMutableArray* ary = [[NSMutableArray alloc] init];
            [ary addObject:[memberObj.fld_name objectAtIndex:l]];
            [ary addObject:[memberObj.fld_value objectAtIndex:l]];

            [ary_field addObject:ary];
        }
    }
    
    //    [[ManagerDownload sharedInstance] setMemberInfo:[Utility getAppID] withDeviceID:[Utility getDeviceID] withShrareCode:@"" withfield:ary_field delegate:self];
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

    if(textField == cell_nick_name.txt_field){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_nick_name.IndexPathRow * 67 + 30;
    }
    
    if(textField == cell_gender.txt_field){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_gender.IndexPathRow * 67 + 30;
    }
    
    if(textField == cell_mail.txt_field){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_mail.IndexPathRow * 67 + 30;
    }

    if(textField == cell_job.txt_field){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_job.IndexPathRow * 67 + 30;
    }

    if(textField == cell_zipcode.txt_field){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_zipcode.IndexPathRow * 67 + 30;
    }
    
    if(textField == cell_address.txt_field){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_address.IndexPathRow * 67 + 30;
    }
    
    if(textField == cell_name.txt_field1){
        
        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_name.IndexPathRow * 67 + 30;
    }

    if(textField == cell_name.txt_field2){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_name.IndexPathRow * 67 + 30;
    }

    if(textField == cell_furigana.txt_field1){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_furigana.IndexPathRow * 67 + 30;
    }

    if(textField == cell_furigana.txt_field2){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_furigana.IndexPathRow * 67 + 30;
    }

    if(textField == cell_tel.txt_field){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_tel.IndexPathRow * 67 + 30;
    }

    if(textField == cell_generation.txt_field){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_generation.IndexPathRow * 67 + 30;
    }


    if(textField == cell_shop.txt_field){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_shop.IndexPathRow * 67 + 30;
    }

    if(textField == cell_birthday.txt_field){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + cell_birthday.IndexPathRow * 67 + 30;
    }

    if(textField == self.txt_introductionCode){

        cgpoint_tf.x = 0.0f;
        cgpoint_tf.y = 130 + [memberObj.fld_colom count] * 67 + 30 + 50;
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
    [cell_nick_name.txt_field resignFirstResponder];
    [cell_gender.txt_field resignFirstResponder];
    [cell_mail.txt_field resignFirstResponder];
    [cell_job.txt_field resignFirstResponder];
    [cell_zipcode.txt_field resignFirstResponder];
    [cell_address.txt_field resignFirstResponder];
    [cell_name.txt_field1 resignFirstResponder];
    [cell_name.txt_field2 resignFirstResponder];
    [cell_furigana.txt_field1 resignFirstResponder];
    [cell_furigana.txt_field2 resignFirstResponder];
    [cell_generation.txt_field resignFirstResponder];
    [cell_shop.txt_field resignFirstResponder];
    [cell_birthday.txt_field resignFirstResponder];
}

- (void)hideKeyboard:(NSNotification*)notification {
    
    //キーボードクローズ
    [cell_nick_name.txt_field resignFirstResponder];
    [cell_gender.txt_field resignFirstResponder];
    [cell_mail.txt_field resignFirstResponder];
    [cell_job.txt_field resignFirstResponder];
    [cell_zipcode.txt_field resignFirstResponder];
    [cell_address.txt_field resignFirstResponder];
    [cell_name.txt_field1 resignFirstResponder];
    [cell_name.txt_field2 resignFirstResponder];
    [cell_furigana.txt_field1 resignFirstResponder];
    [cell_furigana.txt_field2 resignFirstResponder];
    [cell_generation.txt_field resignFirstResponder];
    [cell_shop.txt_field resignFirstResponder];
    [cell_birthday.txt_field resignFirstResponder];
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
