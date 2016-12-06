//
//  MPTheThirdViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheThirdViewController.h"
#include <objc/runtime.h>

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
    _tbl_head.scrollEnabled = false;
    _tbl_head.estimatedRowHeight = 35.0f;
    _tbl_head.rowHeight = UITableViewAutomaticDimension;
    [_tbl_head setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tbl_list.scrollEnabled = false;
    _tbl_list.estimatedRowHeight = 100.0f;
    _tbl_list.rowHeight = UITableViewAutomaticDimension;
    [_tbl_list setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib1 = [UINib nibWithNibName:@"MPTheMenuHederCell" bundle:nil];
    [_tbl_head registerNib:nib1 forCellReuseIdentifier:@"menuheaderlistIdentifier"];
    [_tbl_head reloadData];
    UINib *nib2 = [UINib nibWithNibName:@"MPTheMenuCell" bundle:nil];
    [_tbl_list registerNib:nib2 forCellReuseIdentifier:@"menulistIdentifier"];
    [_tbl_list reloadData];

    lng_ShopNo = 0;
    bln_menuOpen = NO;
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:NO];
    [self setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_menu.png"] imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    //選択タブ解除
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:2];

    [super viewWillAppear:animated];

    //メニュー取得
    [[ManagerDownload sharedInstance] getListMenu:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
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
//        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
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

            if(_ary_total_data.count > 0){

                _ary_elis_menu = [NSMutableArray new];
                for (long c = 0;c < [_ary_total_data count];c++){

                    //ショップ名
                    NSString* str_ShopName = [[_ary_total_data valueForKey:@"shopname"] objectAtIndex:c];
                    //            NSLog(@"%@",str_ShopName);
                    [_ary_elis_menu addObject:str_ShopName];

                    subItems = [NSMutableArray array];

                    //ショップ詳細
                    for (long d = 0;d < [[[_ary_total_data valueForKey:@"category"] objectAtIndex:c] count];d++){

                        NSMutableArray* subShop = [[_ary_total_data valueForKey:@"category"] objectAtIndex:c];
                        [subItems addObject:subShop];
                    }
                    [ary_elias addObject:subItems];
                }

                _arr_elia_Shop = ary_elias;

                [_tbl_head reloadData];
                [_tbl_list reloadData];
                
                [self list_resizeTable];
                [self head_resizeTable];
            }
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

    if(tableView == _tbl_head){

        return _ary_elis_menu.count;
    }

    if(tableView == _tbl_list){

        NSMutableArray* ary_groupeItems = [_arr_elia_Shop objectAtIndex:lng_ShopNo];
        NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];

        return ary_shopItems.count;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if(tableView == _tbl_list){

    }

    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_head){

        if(bln_menuOpen){

            return 35;
        }else{

            if(indexPath.row == lng_ShopNo){

                return 35;
            }else{

                return 0;
            }
        }
    }

    if(tableView == _tbl_list){

        return 100;
    }

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_head){

        MPTheMenuHederCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuheaderlistIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPTheMenuHederCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        cell.lbl_ShopName.text = [_ary_elis_menu objectAtIndex:indexPath.row];

        if(bln_menuOpen){

            cell.hidden = NO;
            cell.img_yajirushi.hidden = YES;
        }else{

            cell.img_yajirushi.hidden = NO;

            if(indexPath.row == lng_ShopNo){

                cell.hidden = NO;
            }else{

                cell.hidden = YES;
            }
        }

        return cell;

    }

    if(tableView == _tbl_list){

        MPTheMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menulistIdentifier"];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPTheMenuCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        NSMutableArray* ary_groupeItems = [_arr_elia_Shop objectAtIndex:lng_ShopNo];
        NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];

        NSString* strMainCategory = [[ary_shopItems valueForKey:@"category"] objectAtIndex:indexPath.row];
        NSString* strMainSibCategory = [[ary_shopItems valueForKey:@"sub_title"] objectAtIndex:indexPath.row];
        NSString* strImageUrl = [[ary_shopItems valueForKey:@"thumbnail"] objectAtIndex:indexPath.row];

        //画像設定
        if(strImageUrl && [strImageUrl length] > 0 ) {

            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{

                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,strImageUrl];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                dispatch_async(q_main, ^{
                    [cell.img_photo setImage:image];
                });
            });
        }else{
            [cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
        }
        
        cell.lbl_title.text = strMainCategory;
        cell.lbl_subtitle.text = strMainSibCategory;
        
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_head){

        if(bln_menuOpen){

            lng_ShopNo = indexPath.row;
            bln_menuOpen = NO;
        }else{

            bln_menuOpen = YES;
        }
        [_tbl_head reloadData];
        [self head_resizeTable];
        [_tbl_list reloadData];
        [self list_resizeTable];
    }

    if(tableView == _tbl_list){

        NSMutableArray* ary_groupeItems = [_arr_elia_Shop objectAtIndex:lng_ShopNo];
        NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];
        NSString* strSubScreenImageUrl = [[ary_shopItems valueForKey:@"image"] objectAtIndex:indexPath.row];

        MPTheThirdSumMenuViewController *vc = [[MPTheThirdSumMenuViewController alloc] initWithNibName:@"MPTheThirdSumMenuViewController" bundle:nil];
        vc.delegate = self;

        //画像設定
        if(strSubScreenImageUrl && [strSubScreenImageUrl length] > 0 ) {

            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{

                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,strSubScreenImageUrl];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                dispatch_async(q_main, ^{
                    [vc.img_head setImage:image];
                });
            });
        }else{
            [vc.img_head setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
        }

        vc.menuCount = indexPath.row;

        MPMenu_MenuObject *obj_menu = [[MPMenu_MenuObject alloc] init];
        obj_menu = [[[_arr_elia_Shop objectAtIndex:lng_ShopNo] objectAtIndex:0] objectAtIndex:indexPath.row];
        
        NSMutableArray *subItems = obj_menu.item;
        vc.ary_menuGroupe_data = subItems;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)head_resizeTable {

    if(bln_menuOpen){

        //コレクション高さをセルの最大値へセット
        _tbl_head.translatesAutoresizingMaskIntoConstraints = YES;
        _tbl_head.frame = CGRectMake(_tbl_head.frame.origin.x, _tbl_head.frame.origin.y, _tbl_head.frame.size.width, 0);
        _tbl_head.frame =
        CGRectMake(_tbl_head.frame.origin.x,
                   _tbl_head.frame.origin.y,
                   _tbl_head.contentSize.width,
                   _ary_elis_menu.count * 35);
    }else{

        //コレクション高さをセルの最大値へセット
        _tbl_head.translatesAutoresizingMaskIntoConstraints = YES;
        _tbl_head.frame = CGRectMake(_tbl_head.frame.origin.x, _tbl_head.frame.origin.y, _tbl_head.frame.size.width, 0);
        _tbl_head.frame =
        CGRectMake(_tbl_head.frame.origin.x,
                   _tbl_head.frame.origin.y,
                   _tbl_head.contentSize.width,
                   35);
    }
}

- (void)list_resizeTable {

    NSMutableArray* ary_groupeItems = [_arr_elia_Shop objectAtIndex:lng_ShopNo];
    NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];

    //コレクション高さをセルの最大値へセット
    _tbl_list.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_list.frame = CGRectMake(_tbl_list.frame.origin.x, _tbl_list.frame.origin.y, _tbl_list.frame.size.width, 0);
    _tbl_list.frame =
    CGRectMake(_tbl_list.frame.origin.x,
               _tbl_list.frame.origin.y,
               _tbl_list.contentSize.width,
               ary_shopItems.count * 100);
}

@end
