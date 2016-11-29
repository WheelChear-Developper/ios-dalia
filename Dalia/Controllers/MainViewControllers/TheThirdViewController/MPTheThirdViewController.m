//
//  MPTheThirdViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheThirdViewController.h"
#include <objc/runtime.h>

//カテゴリで機能拡張
@interface NSMutableArray (Extended)
@property (getter=isExtended) BOOL extended;
@end

@implementation NSMutableArray (Extended)
// アコーディオンが開いているかどうかを設定するところ
- (BOOL)isExtended
{
    return [objc_getAssociatedObject(self, @"extended") boolValue];
}
- (void)setExtended:(BOOL)extended
{
    objc_setAssociatedObject(self, @"extended", [NSNumber numberWithLongLong:extended], OBJC_ASSOCIATION_ASSIGN);
}
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
    _tbl_list.scrollEnabled = false;
    _tbl_list.estimatedRowHeight = 50.0f;
    _tbl_list.rowHeight = UITableViewAutomaticDimension;
    [_tbl_list setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib1 = [UINib nibWithNibName:@"MPTheMenuHederCell" bundle:nil];
    [_tbl_list registerNib:nib1 forCellReuseIdentifier:@"menuheaderlistIdentifier"];
    [_tbl_list reloadData];
    UINib *nib2 = [UINib nibWithNibName:@"MPTheMenuCell" bundle:nil];
    [_tbl_list registerNib:nib2 forCellReuseIdentifier:@"menulistIdentifier"];
    [_tbl_list reloadData];

    //メニュー取得
    [[ManagerDownload sharedInstance] getListMenu:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_menu.png"]];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];
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

- (void)backButtonClicked:(UIButton *)sender {

}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    NSMutableArray* ary_elias = [NSMutableArray array];
    NSMutableArray* subItems = [NSMutableArray array];

    switch (param.request_type) {
        case RequestType_GET_LIST_MENU:
        {
            _ary_total_data = param.listData;

            _ary_elis_menu = [NSMutableArray new];
            for (long c = 0;c < [_ary_total_data count];c++){

                //ショップ名
                NSString* str_ShopName = [[_ary_total_data valueForKey:@"shopname"] objectAtIndex:c];
                //            NSLog(@"%@",str_ShopName);
                [_ary_elis_menu addObject:str_ShopName];

                subItems = [NSMutableArray array];

                //ショップ詳細
                subItems.extended = NO;
                for (long d = 0;d < [[[_ary_total_data valueForKey:@"category"] objectAtIndex:c] count];d++){

                    NSMutableArray* subShop = [[_ary_total_data valueForKey:@"category"] objectAtIndex:c];
                    [subItems addObject:subShop];
                }
                [ary_elias addObject:subItems];
            }

            _arr_elia_Shop = ary_elias;
            [_tbl_list reloadData];

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
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    if(tableView == _tbl_list){

        return _ary_total_data.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(tableView == _tbl_list){

        if (_ary_total_data.count > 0) {

            return ((NSMutableArray*)_arr_elia_Shop[(NSUInteger) section]).extended ? [_arr_elia_Shop[(NSUInteger) section] count] + 1 : 1;
        }
        if ([MPAppDelegate sharedMPAppDelegate].networkStatus) {
            if (!_ary_total_data) {
                return 0;
            }
        }
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPTheMenuHederCell *elia_groupe_cell = [tableView dequeueReusableCellWithIdentifier:@"menuheaderlistIdentifier"];
    MPTheMenuCell *shop_cell = [tableView dequeueReusableCellWithIdentifier:@"menulistIdentifier"];

    static NSString *ParentCellIdentifier = @"menuheaderlistIdentifier";
    static NSString *ChildCellIdentifier = @"menulistIdentifier";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSMutableArray *subItems;
    subItems = _arr_elia_Shop[(NSUInteger) section];

    NSString *identifier;
    if(row == 0){
        identifier = ParentCellIdentifier;
    } else {
        identifier = ChildCellIdentifier;
    }

    //グループ用セル設定
    elia_groupe_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (elia_groupe_cell == nil) {

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPTheMenuHederCell" owner:self options:nil];
        elia_groupe_cell = [nib objectAtIndex:0];
    }

    //ショップ用セル設定
    shop_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (shop_cell == nil) {

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPTheMenuCell" owner:self options:nil];
        shop_cell = [nib objectAtIndex:0];
    }

    // ハイライトなし
    elia_groupe_cell.selectionStyle = UITableViewCellSelectionStyleNone;
    shop_cell.selectionStyle = UITableViewCellSelectionStyleGray;

    if(row == 0){

        [elia_groupe_cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        //ショップ名設定
        NSString* str_ShopName = [_ary_elis_menu objectAtIndex:indexPath.section];
        [elia_groupe_cell.lbl_ShopName setText:[NSString stringWithFormat:@"%@", str_ShopName]];
        // △ 2016年9月29日 ama 件数追加

        //オープン・クローズの状態画像変更
        if(subItems.extended == NO){

            UIImage *image = [UIImage imageNamed:@"down_white_yajirushi.png.png"];
            [elia_groupe_cell.img_yajirushi setImage:image];
        }else{

            UIImage *image = [UIImage imageNamed:@"up_white_yajirushi.png.png"];
            [elia_groupe_cell.img_yajirushi setImage:image];
        }

        return elia_groupe_cell;

    }else{

        NSMutableArray* ary_groupeItems = [_arr_elia_Shop objectAtIndex:indexPath.section];
        NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];
        NSString* strMainCategory = [[ary_shopItems valueForKey:@"category"] objectAtIndex:indexPath.row-1];
        NSString* strImageUrl = [[ary_shopItems valueForKey:@"thumbnail"] objectAtIndex:indexPath.row-1];

        //画像設定
        if(strImageUrl && [strImageUrl length] > 0 ) {

            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{

                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,strImageUrl];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                dispatch_async(q_main, ^{
                    [shop_cell.img_photo setImage:image];
                });
            });
        }else{
            [shop_cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
        }
        
        shop_cell.lbl_title.text = strMainCategory;
//        shop_cell.lbl_subtitle.text = menuObject.content;

        return shop_cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger section = indexPath.section;
    NSInteger row =indexPath.row;

    if(row == 0){

        NSMutableArray *subItems;
        subItems = _arr_elia_Shop[(NSUInteger) section];

        subItems.extended = !subItems.extended;
        if(subItems.extended == NO){

            [self collapseSubItemsAtIndex:row+1 maxRow:[subItems count]+1 section:section];
            [_tbl_list reloadData];
        }else{

            [self expandItemAtIndex:row+1 maxRow:[subItems count]+1 section:section];
            [_tbl_list reloadData];
        }
    }else{

        MPTheThirdSumMenuViewController *vc = [[MPTheThirdSumMenuViewController alloc] initWithNibName:@"MPTheThirdSumMenuViewController" bundle:nil];
        vc.delegate = self;

        vc.menuCount = indexPath.row;
        vc.ary_infoImage = _ary_infoImage;
        vc.dic_menu_data = [_dic_menu_data objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];

        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 縮小アニメーション
- (void)collapseSubItemsAtIndex:(int)firstRow maxRow:(int)maxRow section:(int)section {

    NSMutableArray *indexPaths = [NSMutableArray new];
    for(int i=firstRow;i<maxRow;i++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    [_tbl_list deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}
//拡張アニメーション
- (void)expandItemAtIndex:(int)firstRow maxRow:(int)maxRow section:(int)section {

    NSMutableArray *indexPaths = [NSMutableArray new];
    for(int i=firstRow;i<maxRow;i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    [_tbl_list insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [_tbl_list scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:firstRow - 1 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_list.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_list.frame = CGRectMake(_tbl_list.frame.origin.x, _tbl_list.frame.origin.y, _tbl_list.frame.size.width, 0);
    _tbl_list.frame =
    CGRectMake(_tbl_list.frame.origin.x,
               _tbl_list.frame.origin.y,
               _tbl_list.contentSize.width,
               MAX(_tbl_list.contentSize.height,
                   _tbl_list.bounds.size.height));
}

@end
