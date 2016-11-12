//
//  MPHomeViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPHomeViewController.h"

@interface MPHomeViewController ()
@end

@implementation MPHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //アカウント画面呼び出し
    if([Configuration getFirstUserInfoSet] == false){
        
        TheUserInfoViewController *initialViewController = [[TheUserInfoViewController alloc] initWithNibName:@"TheUserInfoViewController" bundle:nil];
        initialViewController.TheUserInfoViewControllerDelegate = self;
        [self presentViewController:initialViewController animated:NO completion:nil];
    }

    //🔴navigation表示
    [self setBasicNavigationHiden:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] SetCustomNavigationLogo:[UIImage imageNamed:@"header_logo.png"]];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [contentView setHidden:YES];

    //ボタン画像Fix
    btn_block1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block5.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

    [self resizeTable];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_close_TopNavigation:NO];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] open_Tab:NO];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_open_TopNavigation:NO];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] open_Tab:NO];

    }else{

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_open_TopNavigation:NO];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] close_Tab:NO];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView == _RecommendMenuList_tableView){

        return 3;
    }

    if(tableView == _WhatsNew_tableView){

        return 4;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if(tableView == _RecommendMenuList_tableView){

    }

    if(tableView == _WhatsNew_tableView){

    }

    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView == _RecommendMenuList_tableView){

        return 100.0;
    }

    if(tableView == _WhatsNew_tableView){

        return 100.0;
    }

    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _RecommendMenuList_tableView){

        MPMenuListHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newMenuListIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMenuListHomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

//        [cell setData:[self.listObject objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];

        return cell;
    }

    if(tableView == _WhatsNew_tableView){

        MPNewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newHomeIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPNewHomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        //        [cell setData:[self.listObject objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];

        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
/*
    MPNewDetailViewController *newDetailVC = [[MPNewDetailViewController alloc] initWithNibName:@"MPNewDetailViewController" bundle:nil];
    [newDetailVC setData:[self.listObject objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:newDetailVC animated:YES];
*/
 }



- (void)showWebView:(NSString *)text {
/*
    MPHomeWebViewViewController *webViewVC = [[MPHomeWebViewViewController alloc] initWithNibName:@"MPHomeWebViewViewController" bundle:nil];
    webViewVC.linkUrl = text;
    [self.navigationController pushViewController:webViewVC animated:YES];
*/
}

- (void)backButtonClicked:(UIButton *)sender {

}

-(void)push_block1:(UIButton*)button {

}

-(void)push_block2:(UIButton*)button {

}

-(void)push_block3:(UIButton*)button {

}

-(void)push_block4:(UIButton*)button {

}

-(void)push_block5:(UIButton*)button {

}

-(void)push_recomend1:(UIButton*)button {

}

-(void)push_recomend2:(UIButton*)button {

}

-(void)push_recomend3:(UIButton*)button {

}

-(void)push_recomend4:(UIButton*)button {

}

-(void)push_recomend5:(UIButton*)button {

}

-(void)push_recomend6:(UIButton*)button {
    
}

-(void)push_recomend_Item_More:(UIButton*)button {

}

-(void)push_recomend_Menu_More:(UIButton*)button {

}

- (void)resizeTable {

    //テーブル高さをセルの最大値へセット
    _RecommendMenuList_tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _RecommendMenuList_tableView.frame = CGRectMake(_RecommendMenuList_tableView.frame.origin.x, _RecommendMenuList_tableView.frame.origin.y, _RecommendMenuList_tableView.frame.size.width, 0);
    _RecommendMenuList_tableView.frame =
    CGRectMake(_RecommendMenuList_tableView.frame.origin.x,
               _RecommendMenuList_tableView.frame.origin.y,
               _RecommendMenuList_tableView.contentSize.width,
               MAX(_RecommendMenuList_tableView.contentSize.height,
                   _RecommendMenuList_tableView.bounds.size.height));

    NSLog(@"%f",_RecommendMenuList_tableView.bounds.size.height);

    //Recommend moreボタン位置
//    CGRect cg_Recomend_Menu_more = btn_Recommend_Menu_More.frame;
//    cg_Recomend_Menu_more.origin.y = _RecommendMenuList_tableView.frame.origin.y + _RecommendMenuList_tableView.frame.size.height + 5;
//    iv_Recommend_Menu_More.frame = cg_Recomend_Menu_more;
//    btn_Recommend_Menu_More.frame = cg_Recomend_Menu_more;

    //Recommend_Menuサイズ修正
//    CGRect cg_Recomend_Menu = view_Recommend_Menu.frame;
//    cg_Recomend_Menu.size.height = btn_Recommend_Menu_More.frame.origin.y + btn_Recommend_Menu_More.frame.size.height;
//    view_Recommend_Menu.frame = cg_Recomend_Menu;

    //WhatsNew位置修正
//    CGRect cg_WhatsNew = view_WhatsNew.frame;
//    cg_WhatsNew.origin.y = view_Recommend_Menu.frame.origin.y + view_Recommend_Menu.frame.size.height;
//    view_WhatsNew.frame = cg_WhatsNew;

    //エリアテーブル位置設定
    _WhatsNew_tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _WhatsNew_tableView.frame = CGRectMake(_WhatsNew_tableView.frame.origin.x, _WhatsNew_tableView.frame.origin.y, _WhatsNew_tableView.frame.size.width, 0);
    _WhatsNew_tableView.frame =
    CGRectMake(_WhatsNew_tableView.frame.origin.x,
               _WhatsNew_tableView.frame.origin.y,
               _WhatsNew_tableView.contentSize.width,
               MAX(_WhatsNew_tableView.contentSize.height,
                   _WhatsNew_tableView.bounds.size.height));

    //Recommend moreボタン位置
//    CGRect cg_WhatsNew_more = btn_WhatsNew_More.frame;
//    cg_WhatsNew_more.origin.y = _WhatsNew_tableView.frame.origin.y + _WhatsNew_tableView.frame.size.height + 5;
//    iv_WhatsNew_More.frame = cg_WhatsNew_more;
//   btn_WhatsNew_More.frame = cg_WhatsNew_more;

    //WhatsNew位置修正
//    btn_WhatsNew_More.frame = iv_WhatsNew_More.frame;
//    cg_WhatsNew = view_WhatsNew.frame;
//    cg_WhatsNew.size.height = btn_WhatsNew_More.frame.origin.y + btn_WhatsNew_More.frame.size.height;
//    view_WhatsNew.frame = cg_WhatsNew;

//    [_scr_inView setFrame:CGRectMake(0, 0, _scr_inView.frame.size.width, view_WhatsNew.frame.origin.y + view_WhatsNew.frame.size.height)];
//    _scr_rootview.contentSize = _scr_inView.bounds.size;
}


#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_COUPON:
        {


        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (IBAction)btn_block1:(id)sender {
}

- (IBAction)btn_block2:(id)sender {
}

- (IBAction)btn_block3:(id)sender {
}

- (IBAction)btn_block4:(id)sender {
}

- (IBAction)btn_block5:(id)sender {
}

- (IBAction)btn_Recommend_Menu_More:(id)sender {
}

- (IBAction)btn_WhatsNew_More:(id)sender {
}

- (IBAction)btn_Recomend1:(id)sender {
}

- (IBAction)btn_Recomend2:(id)sender {
}

- (IBAction)btn_Recomend3:(id)sender {
}

- (IBAction)btn_Recomend4:(id)sender {
}

- (IBAction)btn_Recomend5:(id)sender {
}

- (IBAction)btn_Recomend6:(id)sender {
}
@end
