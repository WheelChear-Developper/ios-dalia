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
    
    //🔴contentView 高さ自動調整　幅自動調整
    [_contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //XIB表示のため、contentViewを非表示
    [_contentView setHidden:YES];

    //横スクロールイメージビュー追加（商品紹介）
    _topImageView = (MPTopImagesView*)[Utility viewInBundleWithName:@"MPTopImagesView"];
    _topImageView.delegate = self;
    if ([[(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] top_image_type] isEqualToString:@"rectangular"]) {
        _topImageView.isSquare = NO;
    }else{
        _topImageView.isSquare = YES;
    }

    CGRect topImageViewFrame = _topImageView.frame;
    topImageViewFrame.origin.x = 2;
    topImageViewFrame.origin.y = 2;
    topImageViewFrame.size.width = _topimg_rootView.frame.size.width - 4;
    topImageViewFrame.size.height = _topimg_rootView.frame.size.height - 4;
    _topImageView.frame = topImageViewFrame;
    [_topimg_rootView addSubview:_topImageView];

    //ボタン画像Fix
    btn_block1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block2.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block3.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block4.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn_block5.imageView.contentMode = UIViewContentModeScaleAspectFit;

    //load cell xib and attach with collectionView
    UINib *cellNib = [UINib nibWithNibName:@"MPMenuListCollectionCell" bundle:nil];
    [_item_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:[UIImage imageNamed:@"header_logo.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //トップ画面情報取得
    [[ManagerDownload sharedInstance] getTopInfo:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    NSLog(@"Scrool Potion - %f - %f",_scrollBeginingPoint.y, currentPoint.y);
    if(_scrollBeginingPoint.y < currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //初期値
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - TopImageDelegate
- (void)showWebView:(NSString*)text isUrlOpen:(NSString*)openFlg {

    if([openFlg isEqualToString:@"0"]){

        MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
        webViewVC.linkUrl = text;
        [self.navigationController pushViewController:webViewVC animated:YES];

    }else if([openFlg isEqualToString:@"0"]){

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:text]];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView == _RecommendMenuList_tableView){

        return _list_RecommendMenu.count;
    }

    if(tableView == _WhatsNew_tableView){

        return _list_news.count;
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

        MPMenuRecommendMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuRecommendMenuIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMenuRecommendMenuCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        [cell setData:[_list_RecommendMenu objectAtIndex:indexPath.row]];
        return cell;
    }

    if(tableView == _WhatsNew_tableView){

        MPMenuNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeNewsIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMenuNewsCell" owner:self options:nil];
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

    if(tableView == _RecommendMenuList_tableView){

        MPRecommendMenuInfoViewController *vc = [[MPRecommendMenuInfoViewController alloc] initWithNibName:@"MPRecommendMenuInfoViewController" bundle:nil];
        vc.delegate = self;

        [self.navigationController pushViewController:vc animated:YES];
    }

    if(tableView == _WhatsNew_tableView){



    }
 }

#pragma mark - UICollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(100.0f, 100.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _list_RecommendItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    MPMenuListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    [cell setImage:[UIImage imageNamed:@"home_btn_reserve.png"]];

     return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked %ld-%ld",indexPath.section,indexPath.row);
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _item_collectionView.translatesAutoresizingMaskIntoConstraints = YES;
    _item_collectionView.frame = CGRectMake(_item_collectionView.frame.origin.x, _item_collectionView.frame.origin.y, _item_collectionView.frame.size.width, 0);
    _item_collectionView.frame =
    CGRectMake(_item_collectionView.frame.origin.x,
               _item_collectionView.frame.origin.y,
               _item_collectionView.contentSize.width,
               MAX(_item_collectionView.contentSize.height,
                   _item_collectionView.bounds.size.height));

    //テーブル高さをセルの最大値へセット
    _RecommendMenuList_tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _RecommendMenuList_tableView.frame = CGRectMake(_RecommendMenuList_tableView.frame.origin.x, _RecommendMenuList_tableView.frame.origin.y, _RecommendMenuList_tableView.frame.size.width, 0);
    _RecommendMenuList_tableView.frame =
    CGRectMake(_RecommendMenuList_tableView.frame.origin.x,
               _RecommendMenuList_tableView.frame.origin.y,
               _RecommendMenuList_tableView.contentSize.width,
               MAX(_RecommendMenuList_tableView.contentSize.height,
                   _RecommendMenuList_tableView.bounds.size.height));

    _WhatsNew_tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _WhatsNew_tableView.frame = CGRectMake(_WhatsNew_tableView.frame.origin.x, _WhatsNew_tableView.frame.origin.y, _WhatsNew_tableView.frame.size.width, 0);
    _WhatsNew_tableView.frame =
    CGRectMake(_WhatsNew_tableView.frame.origin.x,
               _WhatsNew_tableView.frame.origin.y,
               _WhatsNew_tableView.contentSize.width,
               MAX(_WhatsNew_tableView.contentSize.height,
                   _WhatsNew_tableView.bounds.size.height));
}



#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_TOP_INFO:
        {
            MPMenuTopinfoObject* listObject = [param.listData objectAtIndex:0];

            NSMutableArray* obj_item = listObject.recommend_item;
            _list_RecommendItem = [[NSMutableArray alloc] init];
            for (MPMenuRecommend_itemObject *obj in obj_item) {

                [_list_RecommendItem addObject:obj];
            }

            NSMutableArray* obj_menu = listObject.recommend_menu;
            _list_RecommendMenu = [[NSMutableArray alloc] init];
            for (MPMenuRecommend_menuObject *obj in obj_menu) {

                [_list_RecommendMenu addObject:obj];
            }

            NSMutableArray* obj_new = listObject.news;
            _list_news = [[NSMutableArray alloc] init];
            for (MPMenuNewsObject *obj in obj_new) {

                [_list_news addObject:obj];
            }
/*
            if(list_RecommendItem.count == 0){
                //        view_item.hidden = YES;
                view_item.translatesAutoresizingMaskIntoConstraints = YES;
                view_item.frame = CGRectMake(view_item.frame.origin.x, view_item.frame.origin.y, view_item.frame.size.width, 0);
            }

            if(list_RecommendMenu.count == 0){
//                view_recommend.hidden = YES;
                view_recommend.translatesAutoresizingMaskIntoConstraints = YES;
                view_recommend.frame = CGRectMake(view_recommend.frame.origin.x, view_recommend.frame.origin.y, view_recommend.frame.size.width, 0);
            }

            if(list_news.count == 0){
                //        view_news.hidden = YES;
                view_news.translatesAutoresizingMaskIntoConstraints = YES;
                view_news.frame = CGRectMake(view_news.frame.origin.x, view_news.frame.origin.y, view_news.frame.size.width, 0);
            }
*/
            [_item_collectionView reloadData];
            [_RecommendMenuList_tableView reloadData];
            [_WhatsNew_tableView reloadData];

            [self resizeTable];

            //通知件数取得
            [[ManagerDownload sharedInstance] getDefaultNotification:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];

        }
            break;
        case RequestType_GET_DEFAULT_NOTIFICATION:
        {
            NSLog(@"%@",[param.listData lastObject]);
            MPApnsObject *obj = [param.listData lastObject];

            long couponBadge = [obj.apns_cp integerValue];
            long totalBadge = [obj.apns_badge integerValue];

            //通知件数セット
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:totalBadge];

            // 通知件数を新着件数に設定
//            [(MPTabBarViewController*)[self.navigationController parentViewController] setNewsCount:false];
//            [(MPTabBarViewController*)[self.navigationController parentViewController] setCouponCount:false];

            //通知設定
            long lng_notification_position = 4;
            img_notification_block1.hidden = YES;
            img_notification_block2.hidden = YES;
            img_notification_block3.hidden = YES;
            img_notification_block4.hidden = YES;
            img_notification_block5.hidden = YES;
            switch (lng_notification_position) {
                case 1:
                    if(totalBadge > 0){

                        img_notification_block1.hidden = NO;
                        //TABの通知マーク設定
                        [(MPTabBarViewController*)[self.navigationController parentViewController] setTabNotificationHidden:false];
                    }
                    break;
                case 2:
                    if(totalBadge > 0){

                        img_notification_block2.hidden = NO;
                        //TABの通知マーク設定
                        [(MPTabBarViewController*)[self.navigationController parentViewController] setTabNotificationHidden:false];
                    }
                    break;
                case 3:
                    if(totalBadge > 0){

                        img_notification_block3.hidden = NO;
                        //TABの通知マーク設定
                        [(MPTabBarViewController*)[self.navigationController parentViewController] setTabNotificationHidden:false];
                    }
                    break;
                case 4:
                    if(totalBadge > 0){

                        img_notification_block4.hidden = NO;
                        //TABの通知マーク設定
                        [(MPTabBarViewController*)[self.navigationController parentViewController] setTabNotificationHidden:false];
                    }
                    break;
                case 5:
                    if(totalBadge > 0){

                        img_notification_block5.hidden = NO;
                        //TABの通知マーク設定
                        [(MPTabBarViewController*)[self.navigationController parentViewController] setTabNotificationHidden:false];
                    }
                    break;
                    
                default:
                    break;
            }
        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)backButtonClicked:(UIButton *)sender {

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

    MPRecommendMenuViewController *vc = [[MPRecommendMenuViewController alloc] initWithNibName:@"MPRecommendMenuViewController" bundle:nil];
    vc.delegate = self;

    [self.navigationController pushViewController:vc animated:YES];
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
