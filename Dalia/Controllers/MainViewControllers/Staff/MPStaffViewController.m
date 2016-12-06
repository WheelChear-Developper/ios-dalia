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

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_STAFF:
        {
            _list_data = param.listData[0];

            _lbl_shopName.text = [_list_data objectForKey:@"shopname"];

            _ary_image = [NSMutableArray new];
            _ary_name = [NSMutableArray new];
            _ary_subname = [NSMutableArray new];
            NSMutableArray* ary_staff = [_list_data objectForKey:@"staffs"];
            for (long c = 0;c < [ary_staff count];c++){

                //スタッフ名
                NSString* str_staffName1 = [NSString stringWithFormat:@"%@ %@",[[ary_staff valueForKey:@"name1"] objectAtIndex:c], [[ary_staff valueForKey:@"name2"] objectAtIndex:c]];
                [_ary_name addObject:str_staffName1];
                NSString* str_staffName2 = [[ary_staff valueForKey:@"post"] objectAtIndex:c];
                [_ary_subname addObject:str_staffName2];

                //画像
                NSString* str_imageurl = [[ary_staff valueForKey:@"image"] objectAtIndex:c];
                [_ary_image addObject:str_imageurl];
            }

            [_tbl_menulist reloadData];

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

    //画像設定
    if([_ary_image objectAtIndex:indexPath.row] && [[_ary_image objectAtIndex:indexPath.row] length] > 0 ) {

        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{

            NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,[_ary_image objectAtIndex:indexPath.row]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

            dispatch_async(q_main, ^{
                [cell.img_photo setImage:image];
            });
        });
    }else{
        [cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }

    cell.lbl_name.text = [_ary_name objectAtIndex:indexPath.row];
    cell.lbl_subname.text = [_ary_subname objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPStaffInfoViewController *vc = [[MPStaffInfoViewController alloc] initWithNibName:@"MPStaffInfoViewController" bundle:nil];
    vc.delegate = self;
    vc.obj_staff = [[_list_data objectForKey:@"staffs"] objectAtIndex:indexPath.row];
    vc.ary_photoImage = _ary_image;

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

