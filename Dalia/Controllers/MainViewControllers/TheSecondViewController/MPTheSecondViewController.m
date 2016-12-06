//
//  MPTheSecondViewController.m
//  Misepuri
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheSecondViewController.h"

@interface MPTheSecondViewController ()
@end

@implementation MPTheSecondViewController

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

    //スライドビューインスタンス作成
    _pageView = [[MPQLPageView alloc] initWithFrame:self.view.bounds];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:YES];
    [self setImage_BasicNavigation:nil];
    [self setHiddenBackButton:YES];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:NO];
    [self setImage_CustomNavigation:[UIImage imageNamed:@"header_ttl_coupon.png"] imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    //選択タブ解除
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:1];

    [super viewWillAppear:animated];

    //クーポンデータ取得
    [[ManagerDownload sharedInstance] getListCoupon:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {

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
    NSLog(@"Scrool Potion - %f - %f",_scrollBeginingPoint.y, currentPoint.y);
    if(_scrollBeginingPoint.y < currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　クローズ
        [self setFadeOut_CustomNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //初期値
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //下方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - QLPageViewDataSource
- (NSInteger)initialIndexForPageInPageView:(MPQLPageView *)pageView
{
    return 0;
}

- (NSInteger)numberOfPagesInPageView:(MPQLPageView *)pageView
{
    return _list_data.count;
}

- (UIView *)pageView:(MPQLPageView *)pageView viewForPageAtIndex:(NSInteger)index {

    MPTheSecond_SlideView *view_slide = [MPTheSecond_SlideView myView];
    view_slide.delegate = self;

    [view_slide setNumberOfPages:_list_data.count];
    [view_slide setCurrentCount:index];

    view_slide.scr_rootview.delegate = self;

    if(index == 0){

        view_slide.view_left.hidden = YES;
    }
    if(_list_data.count == index+1){

        view_slide.view_right.hidden = YES;
    }


    MPCouponObject *couponObj = [_list_data objectAtIndex:index];
    //詳細閉じる
    view_slide.view_specialMark.hidden = NO;
    //名前
    view_slide.lbl_title.text = couponObj.name;
    //画像設定
    if (couponObj.coupon_image && [couponObj.coupon_image length] > 0 ) {

        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{

            NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,couponObj.coupon_image];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

            dispatch_async(q_main, ^{
                [view_slide.img_photo setImage:image];
            });
        });
    }else{
        [view_slide.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }
    //画像した文字列
    view_slide.lbl_name.text = couponObj.condition;
    //価格詳細
    switch (couponObj.tokuten_mode) {
        case 1:
        {
            view_slide.lbl_Info1.text = @"通常価格から";
            view_slide.lbl_Info2.text = [NSString stringWithFormat:@"%ld ％OFF", couponObj.percentage];
        }
            break;
        case 2:
        {
            view_slide.lbl_Info1.text = [NSString stringWithFormat:@"通常 %ld円を", couponObj.original_price];
            view_slide.lbl_Info2.text = [NSString stringWithFormat:@"%ld円", couponObj.open_price];
        }
            break;
        case 3:
        {

            view_slide.lbl_Info1.translatesAutoresizingMaskIntoConstraints = YES;
            CGRect rct1 = view_slide.lbl_Info1.frame;
            rct1.size.width = 0;
            view_slide.lbl_Info1.frame = rct1;

            view_slide.lbl_Info1.text = @"";
            view_slide.lbl_Info2.text = couponObj.tokuten_free_word;
        }
            break;

        default:
            break;
    }
    //回数
    if(couponObj.limit_num == 0){

        view_slide.lbl_turn.text = @"制限なし";
    }else{

        view_slide.lbl_turn.text = [NSString stringWithFormat:@"あと%ld回", couponObj.limit_num];
    }
    //スタンプ画像
    [view_slide.img_stamp setImage:nil];
    //有効期限
    switch (couponObj.is_due_date) {
        case 0:
            view_slide.lbl_date.text = @"有効期限無し";
            break;
        case 1:
            view_slide.lbl_date.text = [self setWeekday:couponObj.due_date];
            break;

        default:
            break;
    }
    //詳細メッセージ
    view_slide.lbl_message.text = couponObj.details;
    //詳細メッセージ開いた時の高さを設定
    view_slide.lng_messageHeight = view_slide.view_message.frame.size.height;

    view_slide.view_message.translatesAutoresizingMaskIntoConstraints = YES;
    CGRect rct_message = view_slide.view_message.frame;
    rct_message.size.height = 0;
    view_slide.view_message.frame = rct_message;
    
    return view_slide;
}

- (NSString*)setWeekday:(NSString*)dateString {

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    NSDate* dt = [formatter dateFromString:dateString];

    // 時刻書式指定子を設定
    NSDateFormatter* form = [[NSDateFormatter alloc] init];
    [form setDateStyle:NSDateFormatterFullStyle];
    [form setTimeStyle:NSDateFormatterNoStyle];

    // ロケールを設定
    NSLocale* loc = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [form setLocale:loc];

    // カレンダーを指定
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSJapaneseCalendar];
    [form setCalendar: cal];

    // 和暦を出力するように書式指定
    [form setDateFormat:@"GGyy年MM月dd日(EE)"];

    return [form stringFromDate:dt];
}

- (void)pageView:(MPQLPageView *)pageView didMoveToPage:(NSInteger)index {

}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_LIST_COUPON:
        {
            _list_data = param.listData;

            //スライドビュー設置
            CGRect rct_frame = self.view.frame;
            self.pageView.frame = rct_frame;
            self.pageView.pageViewStyle = MPQLPageViewButtonBarStyleWithLabel;
            self.pageView.dataSource = self;
            self.pageView.delegate = self;
            [self.view addSubview:self.pageView];

            //ナビゲーションを上にする
            [self.view bringSubviewToFront:self.view_custom_navigationView];

        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)btn_favebook {

    MPSNSViewController *vc = [[MPSNSViewController alloc] initWithNibName:@"MPSNSViewController" bundle:nil];
    vc.delegate = self;
    vc.lng_snsType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btn_twitter {

    MPSNSViewController *vc = [[MPSNSViewController alloc] initWithNibName:@"MPSNSViewController" bundle:nil];
    vc.delegate = self;
    vc.lng_snsType = 2;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btn_line {
    
    MPSNSViewController *vc = [[MPSNSViewController alloc] initWithNibName:@"MPSNSViewController" bundle:nil];
    vc.delegate = self;
    vc.lng_snsType = 3;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
