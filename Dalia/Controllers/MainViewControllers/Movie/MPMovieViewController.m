//
//  MPMovieViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPMovieViewController.h"

@interface MPMovieViewController ()

@end

@implementation MPMovieViewController

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
    _tbl_menulist.scrollEnabled = false;
    _tbl_menulist.estimatedRowHeight = 100.0f;
    _tbl_menulist.rowHeight = UITableViewAutomaticDimension;
    [_tbl_menulist setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib = [UINib nibWithNibName:@"MPMovieTableViewCell" bundle:nil];
    [_tbl_menulist registerNib:nib forCellReuseIdentifier:@"movieTableViewCellIdentifier"];
    [_tbl_menulist reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_movie.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //メニュー項目設定
    _ary_image = [@[@"movie_01.png", @"movie_02.png", @"movie_03.png", @"movie_04.png", @"movie_05.png"] mutableCopy];
    _ary_title = [@[@"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ"] mutableCopy];
    _ary_time = [@[@"00:45", @"00:45", @"00:45", @"00:45", @"00:45"] mutableCopy];

    _ary_love = [@[@"12", @"12", @"12", @"12", @"12"] mutableCopy];


    [_tbl_menulist reloadData];
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

        //下方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender {

    [(MPTabBarViewController*)[self.navigationController parentViewController] setTabViewIndex:0];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:0];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setUpTabBar];

    [self dismissViewControllerAnimated:YES completion:NULL];
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

    return _ary_image.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieTableViewCellIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMovieTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.img_photo.image = [UIImage imageNamed:[_ary_image objectAtIndex:indexPath.row]];
    cell.lbl_name.text = [_ary_title objectAtIndex:indexPath.row];
    cell.lbl_time.text = [_ary_time objectAtIndex:indexPath.row];
    cell.lbl_love.text = [_ary_love objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = @"";
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_menulist.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_menulist.frame = CGRectMake(_tbl_menulist.frame.origin.x, _tbl_menulist.frame.origin.y, _tbl_menulist.frame.size.width, 0);
    _tbl_menulist.frame =
    CGRectMake(_tbl_menulist.frame.origin.x,
               _tbl_menulist.frame.origin.y,
               _tbl_menulist.contentSize.width,
               MAX(_tbl_menulist.contentSize.height,
                   _tbl_menulist.bounds.size.height));
}

@end
