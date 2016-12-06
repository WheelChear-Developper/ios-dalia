//
//  MPWhatNewViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPWhatNewViewController.h"

// リスト取得件数変更
#define LIMIT_RECORD_MESSAGE_RECEIVED @"-1"

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
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //テーブル選択解除
    [_WhatNewsList_tableView deselectRowAtIndexPath:[_WhatNewsList_tableView indexPathForSelectedRow] animated:YES];

    //ニュースデータ取得
    [[ManagerDownload sharedInstance] getListMessage:[Utility getDeviceID] withAppID:[Utility getAppID] withLimit:LIMIT_RECORD_MESSAGE_RECEIVED delegate:self];
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
        //標準ナビゲーションのクローズ
//        [self setFadeOut_BasicNavigation:true];

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
        //標準ナビゲーションのオープン
//        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_MESSAGES:
        {
            list_WhatNews = param.listData;
            [_WhatNewsList_tableView reloadData];

            //テーブル高さ調整
            [self resizeTable];
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

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.0;
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
    MPNewHomeObject *newObj = [list_WhatNews objectAtIndex:indexPath.row];
    vc.str_title = newObj.title;
    vc.str_imagUrl = newObj.image;
    vc.str_date = newObj.update_at;
    vc.str_comment = newObj.content;

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
