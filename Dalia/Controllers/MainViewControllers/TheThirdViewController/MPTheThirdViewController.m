//
//  MPTheThirdViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheThirdViewController.h"

@interface MPTheThirdViewController ()
@end

@implementation MPTheThirdViewController

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
    _tbl_menulist.estimatedRowHeight = 100;
    _tbl_menulist.rowHeight = UITableViewAutomaticDimension;

    UINib *nib = [UINib nibWithNibName:@"MPTheMenuCell" bundle:nil];
    [_tbl_menulist registerNib:nib forCellReuseIdentifier:@"menulistIdentifier"];
    [_tbl_menulist reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setBasicNavigationHidden:YES];
    [self setNavigationLogo:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationLogo:[UIImage imageNamed:@"header_ttl_menu.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] tabHidden:NO];

    [super viewWillAppear:animated];

    //メニュー項目設定
    ary_image = [@[@"menu_18.png", @"menu_26.png", @"menu_28.png", @"menu_30.png", @"menu_32.png"] mutableCopy];
    ary_title = [@[@"Cut", @"Color", @"Perm", @"Treatment", @"Other"] mutableCopy];
    ary_subTitle = [@[@"カット", @"カラー", @"パーマ", @"トリートメント", @"その他"] mutableCopy];
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
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] openTab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] openTab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] openTab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender {

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

   return ary_image.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPTheMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menulistIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPTheMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.img_photo.image = [UIImage imageNamed:[ary_image objectAtIndex:indexPath.row]];
    cell.lbl_title.text = [ary_title objectAtIndex:indexPath.row];
    cell.lbl_subtitle.text = [ary_subTitle objectAtIndex:indexPath.row];
    return cell;
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
