//
//  MPTheThirdSumMenuViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/19.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheThirdSumMenuViewController.h"

@interface MPTheThirdSumMenuViewController ()
@end

@implementation MPTheThirdSumMenuViewController

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
    _tbl_menu.scrollEnabled = false;
    _tbl_menu.estimatedRowHeight = 80.0f;
    _tbl_menu.rowHeight = UITableViewAutomaticDimension;
    [_tbl_menu setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib = [UINib nibWithNibName:@"MPTheSubMenuCell" bundle:nil];
    [_tbl_menu registerNib:nib forCellReuseIdentifier:@"submenulistIdentifier"];
    [_tbl_menu reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_menu.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];
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
//        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

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
//        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _ary_menuGroupe_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPTheSubMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"submenulistIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPTheSubMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    MPMenu_ItemObject* ary_dt = [_ary_menuGroupe_data objectAtIndex:indexPath.row];

    cell.lbl_title.text = ary_dt.title;
    cell.lbl_subtitle.text = ary_dt.sub_title;
    cell.lbl_money.text = ary_dt.price;

    return cell;
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_menu.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_menu.frame = CGRectMake(_tbl_menu.frame.origin.x, _tbl_menu.frame.origin.y, _tbl_menu.frame.size.width, 0);
    _tbl_menu.frame =
    CGRectMake(_tbl_menu.frame.origin.x,
               _tbl_menu.frame.origin.y,
               _tbl_menu.contentSize.width,
               MAX(_tbl_menu.contentSize.height,
                   _tbl_menu.bounds.size.height));
}

@end
