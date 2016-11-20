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
    _tbl_menulist.scrollEnabled = false;
    _tbl_menulist.estimatedRowHeight = 100.0f;
    _tbl_menulist.rowHeight = UITableViewAutomaticDimension;
    [_tbl_menulist setSeparatorStyle:UITableViewCellSeparatorStyleNone];

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
    _ary_image = [@[@"menu_18.png", @"menu_26.png", @"menu_28.png", @"menu_30.png", @"menu_32.png"] mutableCopy];
    _ary_title = [@[@"Cut", @"Color", @"Perm", @"Treatment", @"Other"] mutableCopy];
    _ary_subTitle = [@[@"カット", @"カラー", @"パーマ", @"トリートメント", @"その他"] mutableCopy];

    _ary_infoImage = [@[@"menu_cut.png", @"menu_color.png", @"menu_perm.png", @"menu_teatment.png", @"menu_other.png"] mutableCopy];

    NSMutableDictionary *dic_menuset1 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dic_menuList1 = [[NSMutableDictionary alloc] init];
    [dic_menuList1 setValue:@"ディレクターズカット" forKey:@"title"];
    [dic_menuList1 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList1 setValue:@"¥6,000" forKey:@"money"];

    NSMutableDictionary *dic_menuList2 = [[NSMutableDictionary alloc] init];
    [dic_menuList2 setValue:@"トップスタイリストカット" forKey:@"title"];
    [dic_menuList2 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList2 setValue:@"¥5,000" forKey:@"money"];

    NSMutableDictionary *dic_menuList3 = [[NSMutableDictionary alloc] init];
    [dic_menuList3 setValue:@"スタイリストカット" forKey:@"title"];
    [dic_menuList3 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList3 setValue:@"¥4,500" forKey:@"money"];

    NSMutableDictionary *dic_menuList4 = [[NSMutableDictionary alloc] init];
    [dic_menuList4 setValue:@"前髪カット" forKey:@"title"];
    [dic_menuList4 setValue:@"シャンプー・ブロー別" forKey:@"subTitle"];
    [dic_menuList4 setValue:@"¥1,000" forKey:@"money"];
    [dic_menuset1 setValue:dic_menuList1 forKey:@"1"];
    [dic_menuset1 setValue:dic_menuList2 forKey:@"2"];
    [dic_menuset1 setValue:dic_menuList3 forKey:@"3"];
    [dic_menuset1 setValue:dic_menuList4 forKey:@"4"];

    NSMutableDictionary *dic_menuset2 = [[NSMutableDictionary alloc] init];
    dic_menuList1 = [[NSMutableDictionary alloc] init];
    [dic_menuList1 setValue:@"ディレクターズカット" forKey:@"title"];
    [dic_menuList1 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList1 setValue:@"¥6,000" forKey:@"money"];

    dic_menuList2 = [[NSMutableDictionary alloc] init];
    [dic_menuList2 setValue:@"トップスタイリストカット" forKey:@"title"];
    [dic_menuList2 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList2 setValue:@"¥5,000" forKey:@"money"];

    dic_menuList3 = [[NSMutableDictionary alloc] init];
    [dic_menuList3 setValue:@"ディレクターズカット" forKey:@"title"];
    [dic_menuList3 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList3 setValue:@"¥4,500" forKey:@"money"];

    dic_menuList4 = [[NSMutableDictionary alloc] init];
    [dic_menuList4 setValue:@"前髪カット" forKey:@"title"];
    [dic_menuList4 setValue:@"シャンプー・ブロー別" forKey:@"subTitle"];
    [dic_menuList4 setValue:@"¥1,000" forKey:@"money"];
    [dic_menuset2 setValue:dic_menuList1 forKey:@"1"];
    [dic_menuset2 setValue:dic_menuList2 forKey:@"2"];
    [dic_menuset2 setValue:dic_menuList3 forKey:@"3"];
    [dic_menuset2 setValue:dic_menuList4 forKey:@"4"];

    NSMutableDictionary *dic_menuset3 = [[NSMutableDictionary alloc] init];
    dic_menuList1 = [[NSMutableDictionary alloc] init];
    [dic_menuList1 setValue:@"ディレクターズカット" forKey:@"title"];
    [dic_menuList1 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList1 setValue:@"¥6,000" forKey:@"money"];

    dic_menuList2 = [[NSMutableDictionary alloc] init];
    [dic_menuList2 setValue:@"トップスタイリストカット" forKey:@"title"];
    [dic_menuList2 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList2 setValue:@"¥5,000" forKey:@"money"];

    dic_menuList3 = [[NSMutableDictionary alloc] init];
    [dic_menuList3 setValue:@"スタイリストカット" forKey:@"title"];
    [dic_menuList3 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList3 setValue:@"¥6,000" forKey:@"money"];

    dic_menuList4 = [[NSMutableDictionary alloc] init];
    [dic_menuList4 setValue:@"前髪カット" forKey:@"title"];
    [dic_menuList4 setValue:@"シャンプー・ブロー別" forKey:@"subTitle"];
    [dic_menuList4 setValue:@"¥1,000" forKey:@"money"];
    [dic_menuset3 setValue:dic_menuList1 forKey:@"1"];
    [dic_menuset3 setValue:dic_menuList2 forKey:@"2"];
    [dic_menuset3 setValue:dic_menuList3 forKey:@"3"];
    [dic_menuset3 setValue:dic_menuList4 forKey:@"4"];

    NSMutableDictionary *dic_menuset4 = [[NSMutableDictionary alloc] init];
    dic_menuList1 = [[NSMutableDictionary alloc] init];
    [dic_menuList1 setValue:@"ディレクターズカット" forKey:@"title"];
    [dic_menuList1 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList1 setValue:@"¥6,000" forKey:@"money"];

    dic_menuList2 = [[NSMutableDictionary alloc] init];
    [dic_menuList2 setValue:@"トップスタイリストカット" forKey:@"title"];
    [dic_menuList2 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList2 setValue:@"¥5,000" forKey:@"money"];

    dic_menuList3 = [[NSMutableDictionary alloc] init];
    [dic_menuList3 setValue:@"スタイリストカット" forKey:@"title"];
    [dic_menuList3 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList3 setValue:@"¥4,500" forKey:@"money"];

    dic_menuList4 = [[NSMutableDictionary alloc] init];
    [dic_menuList4 setValue:@"前髪カット" forKey:@"title"];
    [dic_menuList4 setValue:@"シャンプー・ブロー別" forKey:@"subTitle"];
    [dic_menuList4 setValue:@"¥1,000" forKey:@"money"];
    [dic_menuset4 setValue:dic_menuList1 forKey:@"1"];
    [dic_menuset4 setValue:dic_menuList2 forKey:@"2"];
    [dic_menuset4 setValue:dic_menuList3 forKey:@"3"];
    [dic_menuset4 setValue:dic_menuList4 forKey:@"4"];

    NSMutableDictionary *dic_menuset5 = [[NSMutableDictionary alloc] init];
    dic_menuList1 = [[NSMutableDictionary alloc] init];
    [dic_menuList1 setValue:@"ディレクターズカット" forKey:@"title"];
    [dic_menuList1 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList1 setValue:@"¥6,000" forKey:@"money"];

    dic_menuList2 = [[NSMutableDictionary alloc] init];
    [dic_menuList2 setValue:@"トップスタイリストカット" forKey:@"title"];
    [dic_menuList2 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList2 setValue:@"¥5,000" forKey:@"money"];

    dic_menuList3 = [[NSMutableDictionary alloc] init];
    [dic_menuList3 setValue:@"スタイリストカット" forKey:@"title"];
    [dic_menuList3 setValue:@"シャンプー・ブロー込" forKey:@"subTitle"];
    [dic_menuList3 setValue:@"¥4,500" forKey:@"money"];

    dic_menuList4 = [[NSMutableDictionary alloc] init];
    [dic_menuList4 setValue:@"前髪カット" forKey:@"title"];
    [dic_menuList4 setValue:@"シャンプー・ブロー別" forKey:@"subTitle"];
    [dic_menuList4 setValue:@"¥1,000" forKey:@"money"];
    [dic_menuset5 setValue:dic_menuList1 forKey:@"1"];
    [dic_menuset5 setValue:dic_menuList2 forKey:@"2"];
    [dic_menuset5 setValue:dic_menuList3 forKey:@"3"];
    [dic_menuset5 setValue:dic_menuList4 forKey:@"4"];

    _dic_menu_data = [@{
                        @"0" : dic_menuset1,
                        @"1" : dic_menuset2,
                        @"2" : dic_menuset3,
                        @"3" : dic_menuset4,
                        @"4" : dic_menuset5
                        } mutableCopy];

    [_tbl_menulist reloadData];
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

   return _ary_image.count;
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

    cell.img_photo.image = [UIImage imageNamed:[_ary_image objectAtIndex:indexPath.row]];
    cell.lbl_title.text = [_ary_title objectAtIndex:indexPath.row];
    cell.lbl_subtitle.text = [_ary_subTitle objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPTheThirdSumMenuViewController *vc = [[MPTheThirdSumMenuViewController alloc] initWithNibName:@"MPTheThirdSumMenuViewController" bundle:nil];
    vc.delegate = self;

    vc.menuCount = indexPath.row;
    vc.ary_infoImage = _ary_infoImage;
    vc.dic_menu_data = [_dic_menu_data objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
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
