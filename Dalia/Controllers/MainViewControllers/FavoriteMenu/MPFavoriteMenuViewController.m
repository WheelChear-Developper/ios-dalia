//
//  MPFavoriteMenuViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPFavoriteMenuViewController.h"

@interface MPFavoriteMenuViewController ()
@end

@implementation MPFavoriteMenuViewController

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
    _RecommendMenuList_tableView.scrollEnabled = false;
    _RecommendMenuList_tableView.estimatedRowHeight = 100.0f;
    _RecommendMenuList_tableView.rowHeight = UITableViewAutomaticDimension;
    [_RecommendMenuList_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib = [UINib nibWithNibName:@"MPMenuRecommendMenuCell" bundle:nil];
    [_RecommendMenuList_tableView registerNib:nib forCellReuseIdentifier:@"menuRecommendMenuIdentifier"];
    [_RecommendMenuList_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setBasicNavigationHidden:NO];
    [self setNavigationLogo:[UIImage imageNamed:@"header_ttl_recommendmenu.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationLogo:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] tabHidden:NO];

    [super viewWillAppear:animated];

    list_RecommendMenu = [[NSMutableArray alloc] init];
    MPMenuRecommend_menuObject *dic_menuList1 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList1.id = @"1";
    dic_menuList1.title = @"イルミナカラー";
    dic_menuList1.image = @"";
    dic_menuList1.content = @"ダメージゼロで実現。外国人風のやわらかで透明感とツヤのある髪色に...";
    dic_menuList1.thumbnail = @"";
    dic_menuList1.updated_at = @"2016-11-18 10:19:33";

    MPMenuRecommend_menuObject *dic_menuList2 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList2.id = @"2";
    dic_menuList2.title = @"オーガニックヘッドスパ";
    dic_menuList2.image = @"";
    dic_menuList2.content = @"頭皮を健やかに髪を美しく、心を癒す、頑張っているあなたへのご褒美メニュー";
    dic_menuList2.thumbnail = @"";
    dic_menuList2.updated_at = @"2016-11-18 10:19:33";

    MPMenuRecommend_menuObject *dic_menuList3 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList3.id = @"3";
    dic_menuList3.title = @"艶カラー";
    dic_menuList3.image = @"";
    dic_menuList3.content = @"ダメージゼロで実現。外国人風のやわらかで透明感とツヤのある髪色に...";
    dic_menuList3.thumbnail = @"";
    dic_menuList3.updated_at = @"2016-11-18 10:19:33";

    MPMenuRecommend_menuObject *dic_menuList4 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList4.id = @"4";
    dic_menuList4.title = @"炭酸シャンプー";
    dic_menuList4.image = @"";
    dic_menuList4.content = @"ダメージゼロで実現。外国人風のやわらかで透明感とツヤのある髪色に...";
    dic_menuList4.thumbnail = @"";
    dic_menuList4.updated_at = @"2016-11-18 10:19:33";

    MPMenuRecommend_menuObject *dic_menuList5 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList5.id = @"5";
    dic_menuList5.title = @"コスメカール";
    dic_menuList5.image = @"";
    dic_menuList5.content = @"ダメージゼロで実現。外国人風のやわらかで透明感とツヤのある髪色に...";
    dic_menuList5.thumbnail = @"";
    dic_menuList5.updated_at = @"2016-11-18 10:19:33";

    MPMenuRecommend_menuObject *dic_menuList6 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList6.id = @"6";
    dic_menuList6.title = @"極上ムコタトリートメント";
    dic_menuList6.image = @"";
    dic_menuList6.content = @"ダメージゼロで実現。外国人風のやわらかで透明感とツヤのある髪色に...";
    dic_menuList6.thumbnail = @"";
    dic_menuList6.updated_at = @"2016-11-18 10:19:33";

    MPMenuRecommend_menuObject *dic_menuList7 = [[MPMenuRecommend_menuObject alloc] init];
    dic_menuList7.id = @"7";
    dic_menuList7.title = @"極上ムコタトリートメント";
    dic_menuList7.image = @"";
    dic_menuList7.content = @"ダメージゼロで実現。外国人風のやわらかで透明感とツヤのある髪色に...";
    dic_menuList7.thumbnail = @"";
    dic_menuList7.updated_at = @"2016-11-18 10:19:33";

    [list_RecommendMenu addObject:dic_menuList1];
    [list_RecommendMenu addObject:dic_menuList2];
    [list_RecommendMenu addObject:dic_menuList3];
    [list_RecommendMenu addObject:dic_menuList4];
    [list_RecommendMenu addObject:dic_menuList5];
    [list_RecommendMenu addObject:dic_menuList6];
    [list_RecommendMenu addObject:dic_menuList7];
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
        //標準ナビゲーションのクローズ
        [self close_TopNavigation];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] fadeInTab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //標準ナビゲーションのオープン
        [self open_TopNavigation];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] fadeInTab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //標準ナビゲーションのオープン
        [self open_TopNavigation];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] fadeInTab:false];
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

   return list_RecommendMenu.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPMenuRecommendMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuRecommendMenuIdentifier"];
    if(cell == nil){

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMenuRecommendMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setData:[list_RecommendMenu objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
/*
    MPTheThirdSumMenuViewController *vc = [[MPTheThirdSumMenuViewController alloc] initWithNibName:@"MPTheThirdSumMenuViewController" bundle:nil];
    vc.delegate = self;

    vc.menuCount = indexPath.row;
    vc.ary_infoImage = _ary_infoImage;
    vc.dic_menu_data = [_dic_menu_data objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];
 */
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _RecommendMenuList_tableView.translatesAutoresizingMaskIntoConstraints = YES;
    _RecommendMenuList_tableView.frame = CGRectMake(_RecommendMenuList_tableView.frame.origin.x, _RecommendMenuList_tableView.frame.origin.y, _RecommendMenuList_tableView.frame.size.width, 0);
    _RecommendMenuList_tableView.frame =
    CGRectMake(_RecommendMenuList_tableView.frame.origin.x,
               _RecommendMenuList_tableView.frame.origin.y,
               _RecommendMenuList_tableView.contentSize.width,
               MAX(_RecommendMenuList_tableView.contentSize.height,
                   _RecommendMenuList_tableView.bounds.size.height));
}

@end
