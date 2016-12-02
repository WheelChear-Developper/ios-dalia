//
//  MPTheFifthViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheFifthViewController.h"

@implementation MPTheFifthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [_contentView setHidden:YES];

    //load cell xib and attach with collectionView
    UINib *nib1 = [UINib nibWithNibName:@"TheFifth_nick_name_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib1 forCellReuseIdentifier:@"first_nickname_Identifier"];
    UINib *nib2 = [UINib nibWithNibName:@"TheFifth_gender_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib2 forCellReuseIdentifier:@"first_gender_Identifier"];
    UINib *nib3 = [UINib nibWithNibName:@"TheFifth_mail_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib3 forCellReuseIdentifier:@"first_mail_Identifier"];
    UINib *nib4 = [UINib nibWithNibName:@"TheFifth_job_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib4 forCellReuseIdentifier:@"first_job_Identifier"];
    UINib *nib5 = [UINib nibWithNibName:@"TheFifth_zipcode_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib5 forCellReuseIdentifier:@"first_zipcode_Identifier"];
    UINib *nib6 = [UINib nibWithNibName:@"TheFifth_address_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib6 forCellReuseIdentifier:@"first_address_Identifier"];
    UINib *nib7 = [UINib nibWithNibName:@"TheFifth_name_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib7 forCellReuseIdentifier:@"first_name_Identifier"];
    UINib *nib8 = [UINib nibWithNibName:@"TheFifth_furigana_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib8 forCellReuseIdentifier:@"first_furigana_Identifier"];
    UINib *nib9 = [UINib nibWithNibName:@"TheFifth_tel_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib9 forCellReuseIdentifier:@"first_tel_Identifier"];
    UINib *nib10 = [UINib nibWithNibName:@"TheFifth_generation_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib10 forCellReuseIdentifier:@"first_generation_Identifier"];
    UINib *nib11 = [UINib nibWithNibName:@"TheFifth_shop_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib11 forCellReuseIdentifier:@"first_shop_Identifier"];
    UINib *nib12 = [UINib nibWithNibName:@"TheFifth_birthday_TableViewCell" bundle:nil];
    [_tbl_userSetting registerNib:nib12 forCellReuseIdentifier:@"first_birthday_Identifier"];
    [_tbl_userSetting reloadData];

    _lbl_version.text =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:NO];
    [self setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_setting.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    sw_newsNotification.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_recommended.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_recommendedMenu.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_catalog.transform = CGAffineTransformMakeScale(0.9, 0.9);
    sw_curpon.transform = CGAffineTransformMakeScale(0.9, 0.9);

    //会員情報保存項目取得
    [[ManagerDownload sharedInstance] getMemberInfo:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

    _scr_rootview.delegate = nil;

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
}

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [self setFadeOut_CustomNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
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

    return 40;
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

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_nick_name_TableViewCell" owner:self options:nil];
                cell_nick_name = [nib objectAtIndex:0];
            }

            cell_nick_name.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_nick_name;
        }

        //性別
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"gender"]){

            cell_gender = [tableView dequeueReusableCellWithIdentifier:@"first_gender_Identifier"];
            if(cell_gender == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_gender_TableViewCell" owner:self options:nil];
                cell_gender = [nib objectAtIndex:0];
            }

            cell_gender.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_gender;
        }

        //メール
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"mail"]){

            cell_mail = [tableView dequeueReusableCellWithIdentifier:@"first_mail_Identifier"];
            if(cell_mail == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_mail_TableViewCell" owner:self options:nil];
                cell_mail = [nib objectAtIndex:0];
            }

            cell_mail.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_mail;
        }

        //職業
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"job"]){

            cell_job = [tableView dequeueReusableCellWithIdentifier:@"first_job_Identifier"];
            if(cell_job == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_job_TableViewCell" owner:self options:nil];
                cell_job = [nib objectAtIndex:0];
            }

            cell_job.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_job;
        }

        //郵便番号
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"zipcode"]){

            cell_zipcode = [tableView dequeueReusableCellWithIdentifier:@"first_zipcode_Identifier"];
            if(cell_zipcode == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_zipcode_TableViewCell" owner:self options:nil];
                cell_zipcode = [nib objectAtIndex:0];
            }

            cell_zipcode.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_zipcode;
        }

        //住所
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"address"]){

            cell_address = [tableView dequeueReusableCellWithIdentifier:@"first_address_Identifier"];
            if(cell_address == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_address_TableViewCell" owner:self options:nil];
                cell_address = [nib objectAtIndex:0];
            }

            cell_address.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_address;
        }

        //名前
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"name1"]){

            cell_name = [tableView dequeueReusableCellWithIdentifier:@"first_name_Identifier"];
            if(cell_name == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_name_TableViewCell" owner:self options:nil];
                cell_name = [nib objectAtIndex:0];
            }

            cell_name.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_name;
        }

        //ふりがな
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"furigana1"]){

            cell_furigana = [tableView dequeueReusableCellWithIdentifier:@"first_furinaga_Identifier"];
            if(cell_furigana == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_furigana_TableViewCell" owner:self options:nil];
                cell_furigana = [nib objectAtIndex:0];
            }

            cell_furigana.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_furigana;
        }

        //電話
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"tel"]){

            cell_tel = [tableView dequeueReusableCellWithIdentifier:@"first_tel_Identifier"];
            if(cell_tel == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_tel_TableViewCell" owner:self options:nil];
                cell_tel = [nib objectAtIndex:0];
            }

            cell_tel.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_tel;
        }

        //年代
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"generation"]){

            cell_generation = [tableView dequeueReusableCellWithIdentifier:@"first_generation_Identifier"];
            if(cell_generation == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_generation_TableViewCell" owner:self options:nil];
                cell_generation = [nib objectAtIndex:0];
            }

            cell_generation.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_generation;
        }

        //利用店舗
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"shop"]){

            cell_shop = [tableView dequeueReusableCellWithIdentifier:@"first_shop_Identifier"];
            if(cell_shop == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_shop_TableViewCell" owner:self options:nil];
                cell_shop = [nib objectAtIndex:0];
            }

            cell_shop.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_shop;
        }

        //誕生日
        if([[memberObj.fld_name objectAtIndex:indexPath.row] isEqualToString:@"birthday"]){

            cell_birthday = [tableView dequeueReusableCellWithIdentifier:@"first_birthday_Identifier"];
            if(cell_birthday == nil){

                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TheFifth_birthday_TableViewCell" owner:self options:nil];
                cell_birthday = [nib objectAtIndex:0];
            }

            cell_birthday.lbl_name.text = [memberObj.fld_colom objectAtIndex:indexPath.row];

            return cell_birthday;
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


- (void)backButtonClicked:(UIButton *)sender {

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


        default:
            break;
    }
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

- (void)downloadDataFail:(DownloadParam *)param {
}

- (IBAction)sw_newsNotification:(id)sender {
}

- (IBAction)sw_recommended:(id)sender {
}

- (IBAction)sw_recommendedMenu:(id)sender {
}

- (IBAction)sw_catalog:(id)sender {
}

- (IBAction)sw_curpon:(id)sender {
}

- (IBAction)btn_transfer:(id)sender {

    MPTransferViewController *vc = [[MPTransferViewController alloc] initWithNibName:@"MPTransferViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn_teams:(id)sender {

    MPTermsViewController *vc = [[MPTermsViewController alloc] initWithNibName:@"MPTermsViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btn_porisir:(id)sender {
}

@end
