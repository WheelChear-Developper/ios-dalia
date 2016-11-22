//
//  MPWhatNewViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPWhatNewViewController.h"

@interface MPWhatNewViewController ()
@end

@implementation MPWhatNewViewController

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

    //テーブル設定
    _WhatNewsList_tableView.scrollEnabled = false;
    _WhatNewsList_tableView.estimatedRowHeight = 100.0f;
    _WhatNewsList_tableView.rowHeight = UITableViewAutomaticDimension;
    [_WhatNewsList_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib = [UINib nibWithNibName:@"MPWhatNewsCell" bundle:nil];
    [_WhatNewsList_tableView registerNib:nib forCellReuseIdentifier:@"whatNewsIdentifier"];
    [_WhatNewsList_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_whatsnew.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //テーブル選択解除
    [_WhatNewsList_tableView deselectRowAtIndexPath:[_WhatNewsList_tableView indexPathForSelectedRow] animated:YES];

    list_WhatNews = [[NSMutableArray alloc] init];
    MPWhatNewsObject *dic_menuList1 = [[MPWhatNewsObject alloc] init];
    dic_menuList1.id = @"1";
    dic_menuList1.title = @"スプリングキャンペーン";
    dic_menuList1.content = @"そろそろ春の気配がしてきましたね!!\n3月から春のキャンペーンを開催";
    dic_menuList1.is_read = 1;
    dic_menuList1.update_at = @"2017-02-20 00:00:00";
    dic_menuList1.image = @"";
    dic_menuList1.thumbnail = @"";


    MPWhatNewsObject *dic_menuList2 = [[MPWhatNewsObject alloc] init];
    dic_menuList2.id = @"2";
    dic_menuList2.title = @"謹賀新年";
    dic_menuList2.content = @"あけましておめでとうございます。昨年はご愛顧いただきありがとうござい";
    dic_menuList2.is_read = 0;
    dic_menuList2.update_at = @"2017-01-04 00:00:00";
    dic_menuList2.image = @"";
    dic_menuList2.thumbnail = @"";

    MPWhatNewsObject *dic_menuList3 = [[MPWhatNewsObject alloc] init];
    dic_menuList3.id = @"3";
    dic_menuList3.title = @"カウントダウンキャンペーン";
    dic_menuList3.content = @"早いもので今年もあと２ヶ月ですね。\n11月１日〜12月31日まで感謝を込";
    dic_menuList3.is_read = 0;
    dic_menuList3.update_at = @"2016-12-01 00:00:00";
    dic_menuList3.image = @"";
    dic_menuList3.thumbnail = @"";

    MPWhatNewsObject *dic_menuList4 = [[MPWhatNewsObject alloc] init];
    dic_menuList4.id = @"4";
    dic_menuList4.title = @"年末年始休業のお知らせ";
    dic_menuList4.content = @"12月30日(金)〜１月3日(火)は年末年始のお休みとさせて頂きます。";
    dic_menuList4.is_read = 0;
    dic_menuList4.update_at = @"2016-11-05 00:00:00";
    dic_menuList4.image = @"";
    dic_menuList4.thumbnail = @"";

    MPWhatNewsObject *dic_menuList5 = [[MPWhatNewsObject alloc] init];
    dic_menuList5.id = @"5";
    dic_menuList5.title = @"11月の定休日のお知らせ";
    dic_menuList5.content = @"11月の定休日のお知らせです。7日(月)・14日(月)・21日(月)・22日(火)・";
    dic_menuList5.is_read = 0;
    dic_menuList5.update_at = @"2016-11-01 00:00:00";
    dic_menuList5.image = @"";
    dic_menuList5.thumbnail = @"";

    MPWhatNewsObject *dic_menuList6 = [[MPWhatNewsObject alloc] init];
    dic_menuList6.id = @"6";
    dic_menuList6.title = @"インストールありがとうございます!";
    dic_menuList6.content = @"このアプリではBEAUTY SALON(サロン名)の最新情報やアプリユーザー";
    dic_menuList6.is_read = 0;
    dic_menuList6.update_at = @"2016-11-01 00:00:00";
    dic_menuList6.image = @"";
    dic_menuList6.thumbnail = @"";

    [list_WhatNews addObject:dic_menuList1];
    [list_WhatNews addObject:dic_menuList2];
    [list_WhatNews addObject:dic_menuList3];
    [list_WhatNews addObject:dic_menuList4];
    [list_WhatNews addObject:dic_menuList5];
    [list_WhatNews addObject:dic_menuList6];
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

    [self resizeTable];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        //標準ナビゲーションのオープン
        [self setFadeOut_BasicNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //初期値
        //標準ナビゲーションのオープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //下方向の時のアクション
        //標準ナビゲーションのクローズ
        [self setFadeOut_BasicNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return list_WhatNews.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPWhatNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"whatNewsIdentifier"];
    if(cell == nil){

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WhatNewsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setData:[list_WhatNews objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPWhatNewInfoViewController *vc = [[MPWhatNewInfoViewController alloc] initWithNibName:@"MPWhatNewInfoViewController" bundle:nil];
    vc.delegate = self;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _WhatNewsList_tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _WhatNewsList_tableView.frame = CGRectMake(_WhatNewsList_tableView.frame.origin.x, _WhatNewsList_tableView.frame.origin.y, _WhatNewsList_tableView.frame.size.width, 0);
    _WhatNewsList_tableView.frame =
    CGRectMake(_WhatNewsList_tableView.frame.origin.x,
               _WhatNewsList_tableView.frame.origin.y,
               _WhatNewsList_tableView.contentSize.width,
               MAX(_WhatNewsList_tableView.contentSize.height,
                   _WhatNewsList_tableView.bounds.size.height));
}

@end
