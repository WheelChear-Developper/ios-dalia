//
//  MPSNSViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/04.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPSNSViewController.h"

@interface MPSNSViewController ()

@end

@implementation MPSNSViewController

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

    UINib *nib = [UINib nibWithNibName:@"MPSNSTableViewCell" bundle:nil];
    [_tbl_menulist registerNib:nib forCellReuseIdentifier:@"snsTableViewCellIdentifier"];
    [_tbl_menulist reloadData];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_coupon.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    switch (self.lng_snsType) {
        case 1:
            img_mark.image = [UIImage imageNamed:@"secondview_icon_facebook_maru.png"];
            break;
        case 2:
            img_mark.image = [UIImage imageNamed:@"secondview_icon_twitter_maru.png"];
            break;
        case 3:
            img_mark.image = [UIImage imageNamed:@"secondview_icon_line_maru.png"];
            break;

        default:
            break;
    }

    //友達クーポン
    [[ManagerDownload sharedInstance] getListShareCoupon:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
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
        case RequestType_GET_LIST_SHARECOUPON:
        {
            _list_data = param.listData;

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

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPSNSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"snsTableViewCellIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPSNSTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    MPCouponShareObject* obj_CouponShare = [_list_data objectAtIndex:indexPath.row];

    //画像設定
    if(obj_CouponShare.coupon_image && [obj_CouponShare.coupon_image length] > 0 ) {

        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{

            NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,obj_CouponShare.coupon_image];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

            dispatch_async(q_main, ^{
                [cell.img_photo setImage:image];
            });
        });
    }else{
        [cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }

    cell.lbl_head.text = obj_CouponShare.name;
    cell.lbl_comment.text = obj_CouponShare.condition;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MPCouponShareObject* obj_CouponShare = [_list_data objectAtIndex:indexPath.row];

    switch (self.lng_snsType) {
        case 1:
        {
            //Facebook
            MPSNSAreartView *snsShareView = (MPSNSAreartView*)[Utility viewInBundleWithName:@"MPSNSAreartView"];
            snsShareView.delegate = self;
            snsShareView.lng_snsType = 1;
            [snsShareView setData:@"Facebookへ投稿する" comment:obj_CouponShare.share_conten];
            [[MPAppDelegate sharedMPAppDelegate].window addSubview:snsShareView];

        }
            break;
        case 2:
        {
            //Twitter
            //Facebook
            MPSNSAreartView *snsShareView = (MPSNSAreartView*)[Utility viewInBundleWithName:@"MPSNSAreartView"];
            snsShareView.delegate = self;
            snsShareView.lng_snsType = 2;
            [snsShareView setData:@"Twitterへ投稿する" comment:obj_CouponShare.share_conten];
            [[MPAppDelegate sharedMPAppDelegate].window addSubview:snsShareView];
        }
            break;
        case 3:
        {
            //Line
            //Facebook
            MPSNSAreartView *snsShareView = (MPSNSAreartView*)[Utility viewInBundleWithName:@"MPSNSAreartView"];
            snsShareView.delegate = self;
            snsShareView.lng_snsType = 3;
            [snsShareView setData:@"Lineへ投稿する" comment:obj_CouponShare.share_conten];
            [[MPAppDelegate sharedMPAppDelegate].window addSubview:snsShareView];
        }
            break;

        default:
            break;
    }
}

-(void)postFacebook:(NSString*)comment {

    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPostVC setInitialText:comment];
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

-(void)postTwitter:(NSString*)comment {

    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterPostVC setInitialText:comment];
    [self presentViewController:twitterPostVC animated:YES completion:nil];
}

-(void)postLine:(NSString*)comment {

    NSString *textString = comment;
    textString = [textString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/text/%@",textString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LINEUrlString]];
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
