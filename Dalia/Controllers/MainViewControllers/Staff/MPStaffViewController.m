//
//  MPStaffViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPStaffViewController.h"

@interface MPStaffViewController ()
@end

@implementation MPStaffViewController

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

    UINib *nib = [UINib nibWithNibName:@"MPStaffCell" bundle:nil];
    [_tbl_menulist registerNib:nib forCellReuseIdentifier:@"staffIdentifier"];
    [_tbl_menulist reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_staff.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //メニュー項目設定
    _ary_image = [@[@"staff_01.png", @"staff_02.png", @"staff_03.png", @"staff_04.png", @"staff_05.png"] mutableCopy];
    _ary_name = [@[@"Tarou Yamada", @"Hanako Satou", @"Aki Suzuki", @"Misa Kawatani", @"Other"] mutableCopy];
    _ary_subname = [@[@"代表", @"ディレクター", @"トップスタイリスト", @"トップスタイリスト", @"その他"] mutableCopy];

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

    return _ary_name.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPStaffCell *cell = [tableView dequeueReusableCellWithIdentifier:@"staffIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPStaffCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.img_photo.image = [UIImage imageNamed:[_ary_image objectAtIndex:indexPath.row]];
    cell.lbl_name.text = [_ary_name objectAtIndex:indexPath.row];
    cell.lbl_subname.text = [_ary_subname objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPStaffInfoViewController *vc = [[MPStaffInfoViewController alloc] initWithNibName:@"MPStaffInfoViewController" bundle:nil];
    vc.delegate = self;

//    vc.menuCount = indexPath.row;
//    vc.ary_infoImage = _ary_infoImage;
//    vc.dic_menu_data = [_dic_menu_data objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];

    [self.navigationController pushViewController:vc animated:YES];

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

