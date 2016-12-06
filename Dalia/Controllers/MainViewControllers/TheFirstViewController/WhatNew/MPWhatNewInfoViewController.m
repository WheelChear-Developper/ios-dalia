//
//  MPWhatNewInfoViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/21.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPWhatNewInfoViewController.h"

@interface MPWhatNewInfoViewController ()

@end

@implementation MPWhatNewInfoViewController

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

    //選択タブ解除
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:-1];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_whatsnew.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {

    _scr_rootview.delegate = self;

    [super viewDidAppear:animated];

    if (self.str_imagUrl && [self.str_imagUrl length] > 0 ) {

        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{

            NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,self.str_imagUrl];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

            dispatch_async(q_main, ^{
                [_img_photo setImage:image];
            });
        });
    }else{
        [_img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }

    _lbl_title.text = _str_title;
    _lbl_date.text = [_str_date substringToIndex:10];
    _lbl_content.text = _str_comment;

    //行間設定
    CGFloat customLineHeight = 16.0f;

    // パラグラフスタイルにlineHeightをセット
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.minimumLineHeight = customLineHeight;
    paragrahStyle.maximumLineHeight = customLineHeight;

    // NSAttributedStringを生成してパラグラフスタイルをセット
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:_str_comment];
    [attributedText addAttribute:NSParagraphStyleAttributeName
                           value:paragrahStyle
                           range:NSMakeRange(0, attributedText.length)];

    _lbl_content.numberOfLines = 0;
    _lbl_content.attributedText = attributedText;
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

        //上方向の時のアクション
        //標準ナビゲーションのクローズ
        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //初期値
        //標準ナビゲーションのオープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //下方向の時のアクション
        //標準ナビゲーションのオープン
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

- (IBAction)btn_facebook:(id)sender {

    SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [facebookPostVC setInitialText:_lbl_content.text];
    [self presentViewController:facebookPostVC animated:YES completion:nil];
}

- (IBAction)btn_twitter:(id)sender {

    SLComposeViewController *twitterPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterPostVC setInitialText:_lbl_content.text];
    [self presentViewController:twitterPostVC animated:YES completion:nil];
}

- (IBAction)btn_line:(id)sender {

    NSString *textString = _lbl_content.text;
    textString = [textString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/text/%@",textString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LINEUrlString]];
}

@end
