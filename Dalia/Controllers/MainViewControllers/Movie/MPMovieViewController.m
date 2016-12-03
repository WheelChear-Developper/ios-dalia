//
//  MPMovieViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPMovieViewController.h"

@interface MPMovieViewController ()

@end

@implementation MPMovieViewController

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

    UINib *nib = [UINib nibWithNibName:@"MPMovieTableViewCell" bundle:nil];
    [_tbl_menulist registerNib:nib forCellReuseIdentifier:@"movieTableViewCellIdentifier"];
    [_tbl_menulist reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_movie.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //会員書情報取得
    [[ManagerDownload sharedInstance] getVideo:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];

    //メニュー項目設定
//    _ary_image = [@[@"movie_01.png", @"movie_02.png", @"movie_03.png", @"movie_04.png", @"movie_05.png"] mutableCopy];
//    _ary_title = [@[@"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ", @"2分でできる!!\nミディアムヘアを簡単ヘアアレンジ"] mutableCopy];
//    _ary_time = [@[@"00:45", @"00:45", @"00:45", @"00:45", @"00:45"] mutableCopy];

//    _ary_love = [@[@"12", @"12", @"12", @"12", @"12"] mutableCopy];


//    [_tbl_menulist reloadData];
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
//        [selfsetFadeOut_CustomNavigation:false];

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
        case RequestType_GET_LIST_VIDEO:
        {
            _list_data = param.listData[0];

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

    return _list_data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieTableViewCellIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPMovieTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    MPVideolistObject* obj_video = [_list_data objectAtIndex:indexPath.row];

    NSMutableDictionary* dic_thumbnail = obj_video.thumbnail;

    //画像設定
    if([dic_thumbnail objectForKey:@"url"] && [[dic_thumbnail objectForKey:@"url"] length] > 0 ) {

        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{

            NSString *imageURL = [dic_thumbnail objectForKey:@"url"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

            dispatch_async(q_main, ^{
                [cell.img_photo setImage:image];
            });
        });
    }else{
        [cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }

//    cell.img_photo.image = [UIImage imageNamed:[_ary_image objectAtIndex:indexPath.row]];
    cell.lbl_name.text = obj_video.title;
    cell.lbl_time.text = obj_video.time;
    cell.lbl_love.text = @"";//[NSString stringWithFormat:@"%ld",obj_video.isLike];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = @"";
    [self.navigationController pushViewController:webViewVC animated:YES];
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
