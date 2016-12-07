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
    _tbl_shopflist.scrollEnabled = false;
    _tbl_shopflist.estimatedRowHeight = 35.0f;
    _tbl_shopflist.rowHeight = UITableViewAutomaticDimension;
    [_tbl_shopflist setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tbl_stafflist.scrollEnabled = false;
    _tbl_stafflist.estimatedRowHeight = 100.0f;
    _tbl_stafflist.rowHeight = UITableViewAutomaticDimension;
    [_tbl_stafflist setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    UINib *nib1 = [UINib nibWithNibName:@"MPStaffHeadCell" bundle:nil];
    [_tbl_shopflist registerNib:nib1 forCellReuseIdentifier:@"staffHeadIdentifier"];
    [_tbl_shopflist reloadData];
    UINib *nib2 = [UINib nibWithNibName:@"MPStaffCell" bundle:nil];
    [_tbl_stafflist registerNib:nib2 forCellReuseIdentifier:@"staffIdentifier"];
    [_tbl_stafflist reloadData];

    lng_ShopNo = 0;
    bln_menuOpen = NO;
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_staff.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //会員書情報取得
    [[ManagerDownload sharedInstance] getStaff:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
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
        //標準ナビゲーションのクローズ
        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    NSMutableArray* ary_elias = [NSMutableArray array];
    NSMutableArray* subItems = [NSMutableArray array];

    switch (param.request_type) {
        case RequestType_GET_LIST_STAFF:
        {
            _ary_total_data = param.listData;

            if(_ary_total_data.count > 0){

                _ary_elis_Shop = [NSMutableArray new];
                for (long c = 0;c < [_ary_total_data count];c++){

                    //ショップ名
                    NSString* str_ShopName = [[_ary_total_data valueForKey:@"shopname"] objectAtIndex:c];
                    //            NSLog(@"%@",str_ShopName);
                    [_ary_elis_Shop addObject:str_ShopName];

                    subItems = [NSMutableArray array];

                    //ショップ詳細
                    for (long d = 0;d < [[[_ary_total_data valueForKey:@"category"] objectAtIndex:c] count];d++){

                        NSMutableArray* subShop = [[_ary_total_data valueForKey:@"category"] objectAtIndex:c];
                        [subItems addObject:subShop];
                    }
                    [ary_elias addObject:subItems];
                }

                _arr_elia_Staff = ary_elias;

                [_tbl_shopflist reloadData];
                [_tbl_stafflist reloadData];
                
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

    if(tableView == _tbl_shopflist){

        return [[_ary_elis_Shop objectAtIndex:0] count];
    }

    if(tableView == _tbl_stafflist){

        NSMutableArray* ary_staff = [[[_arr_elia_Staff objectAtIndex:0] objectAtIndex:0] objectAtIndex:lng_ShopNo];

        return ary_staff.count;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_shopflist){

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

    if(tableView == _tbl_stafflist){
        
        return 100;
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_shopflist){

        MPStaffHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"staffHeadIdentifier"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPStaffHeadCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        cell.lbl_ShopName.text = [[_ary_elis_Shop objectAtIndex:0] objectAtIndex:indexPath.row];

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

    if(tableView == _tbl_stafflist){

        MPStaffCell *cell = [tableView dequeueReusableCellWithIdentifier:@"staffIdentifier"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPStaffCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        NSMutableArray* ary_staff = [[[_arr_elia_Staff objectAtIndex:0] objectAtIndex:0] objectAtIndex:lng_ShopNo];
        MPStafflistObject* obj_staff = [ary_staff objectAtIndex:indexPath.row];

        //画像設定
        if(obj_staff.image && [obj_staff.image length] > 0 ) {

            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{

                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,obj_staff.image];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                dispatch_async(q_main, ^{
                    [cell.img_photo setImage:image];
                });
            });
        }else{
            [cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
        }

        cell.lbl_name.text = [NSString stringWithFormat:@"%@ %@", obj_staff.name1, obj_staff.name2];
        cell.lbl_subname.text = obj_staff.post;
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(tableView == _tbl_shopflist){

        if(bln_menuOpen){

            lng_ShopNo = indexPath.row;
            bln_menuOpen = NO;
        }else{

            bln_menuOpen = YES;
        }
        [_tbl_shopflist reloadData];
        [self head_resizeTable];
        [_tbl_stafflist reloadData];
        [self list_resizeTable];
    }

    if(tableView == _tbl_stafflist){

        MPStaffInfoViewController *vc = [[MPStaffInfoViewController alloc] initWithNibName:@"MPStaffInfoViewController" bundle:nil];
        vc.delegate = self;

        NSMutableArray* ary_staff = [[[_arr_elia_Staff objectAtIndex:0] objectAtIndex:0] objectAtIndex:lng_ShopNo];
        MPStafflistObject* obj_staff = [ary_staff objectAtIndex:indexPath.row];
        vc.obj_staff = obj_staff;
        vc.ary_SHOP = ary_staff;

        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)head_resizeTable {

    if(bln_menuOpen){

        //コレクション高さをセルの最大値へセット
        _tbl_shopflist.translatesAutoresizingMaskIntoConstraints = YES;
        _tbl_shopflist.frame = CGRectMake(_tbl_shopflist.frame.origin.x, _tbl_shopflist.frame.origin.y, _tbl_shopflist.frame.size.width, 0);
        _tbl_shopflist.frame =
        CGRectMake(_tbl_shopflist.frame.origin.x,
                   _tbl_shopflist.frame.origin.y,
                   _tbl_shopflist.contentSize.width,
                   [[_ary_elis_Shop objectAtIndex:0] count] * 35);
    }else{

        //コレクション高さをセルの最大値へセット
        _tbl_shopflist.translatesAutoresizingMaskIntoConstraints = YES;
        _tbl_shopflist.frame = CGRectMake(_tbl_shopflist.frame.origin.x, _tbl_shopflist.frame.origin.y, _tbl_shopflist.frame.size.width, 0);
        _tbl_shopflist.frame =
        CGRectMake(_tbl_shopflist.frame.origin.x,
                   _tbl_shopflist.frame.origin.y,
                   _tbl_shopflist.contentSize.width,
                   35);
    }
}

- (void)list_resizeTable {

    //コレクション高さをセルの最大値へセット
    _tbl_stafflist.translatesAutoresizingMaskIntoConstraints = YES;
    _tbl_stafflist.frame = CGRectMake(_tbl_stafflist.frame.origin.x, _tbl_stafflist.frame.origin.y, _tbl_stafflist.frame.size.width, 0);
    _tbl_stafflist.frame =
    CGRectMake(_tbl_stafflist.frame.origin.x,
               _tbl_stafflist.frame.origin.y,
               _tbl_stafflist.contentSize.width,
               MAX(_tbl_stafflist.contentSize.height,
                   _tbl_stafflist.bounds.size.height));
}

@end

