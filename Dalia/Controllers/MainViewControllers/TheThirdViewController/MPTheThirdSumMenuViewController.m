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
    [self setBasicNavigationHidden:NO];
    [self setNavigationLogo:[UIImage imageNamed:@"header_ttl_menu.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationLogo:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] tabHidden:NO];

    [super viewWillAppear:animated];

    _img_head.image = [UIImage imageNamed:[_ary_infoImage objectAtIndex:_menuCount]];
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
        [(MPTabBarViewController*)[self.navigationController parentViewController] fadeInTab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] fadeInTab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] custom_TopNavigationHidden:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] fadeInTab:false];
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

    return _dic_menu_data.count;
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

    NSMutableDictionary* ary_dt = [_dic_menu_data objectForKey:[NSString stringWithFormat:@"%d",indexPath.row + 1]];

    cell.lbl_title.text = [ary_dt objectForKey:@"title"];
    cell.lbl_subtitle.text = [ary_dt objectForKey:@"subTitle"];
    cell.lbl_money.text = [ary_dt objectForKey:@"money"];
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
