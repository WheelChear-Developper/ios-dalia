//
//  MPMembersCardViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/24.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPMembersCardViewController.h"
// INSERTED BY M.FUJII 2016.12.06 START
#import "MPMemberCardObject.h"
// INSERTED BY M.FUJII 2016.12.06 END

@interface MPMembersCardViewController ()

// INSERTED BY M.FUJII 2016.12.06 START
// QRコード画像表示
@property (strong, nonatomic) IBOutlet UIImageView *imageQRCode;
@property (strong, nonatomic) IBOutlet UIImageView *imageNameTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UIView *separatorView;
@property (strong, nonatomic) IBOutlet UILabel *labelRankName;
@property (strong, nonatomic) IBOutlet UIImageView *imageRankBack;

// INSERTED BY M.FUJII 2016.12.06 END
@end

@implementation MPMembersCardViewController

// INSERTED BY M.FUJII 2016.12.06 START
NSString *const SOME_CONSTANT_ARRAY[] = { @"members_bg_platinum.png", @"members_bg_gold.png", @"members_bg_silver.png", @"members_bg_blonze.png", @"members_bg_green.png", @"members_bg_pink.png", @"members_bg_blue.png", @"members_bg_purple.png", @"members_bg_orange.png" };
NSUInteger const SIZE_OF_SOME_CONSTANT_ARRAY = 9;
// INSERTED BY M.FUJII 2016.12.06 END

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
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_memberscard.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //会員書情報取得
    [[ManagerDownload sharedInstance] getMemberCard:[Utility getAppID] withDeviceID:[Utility getDeviceID] delegate:self];
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

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //トップナビゲーション　クローズ
        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //トップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //トップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {

    switch (param.request_type) {
        case RequestType_GET_MEMBER_CARD:
        {
            MPMemberCardObject* list_data = (MPMemberCardObject*)param.listData[0];
            NSLog(@"%@", [NSString stringWithFormat:BASE_PREFIX_URL, list_data.qrcode]);
            NSLog(@"%d", (int)list_data.rank_id);
            
            _labelName.text = [NSString stringWithFormat:@"%@ 様", list_data.member_name];
            if ( list_data.name_disp == 0 ){
                _imageNameTitle.hidden = YES;
                _labelName.hidden = YES;
                _separatorView.hidden = YES;
            }
            _labelRankName.text = list_data.rank_name;
            
            NSLog(@"%@", SOME_CONSTANT_ARRAY[0]);
            NSLog(@"%@", SOME_CONSTANT_ARRAY[0]);
            
            _imageRankBack.image = [UIImage imageNamed:SOME_CONSTANT_ARRAY[list_data.rank_id - 1]];
            
            // この部分が重要
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{
                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL, list_data.qrcode];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
                
                dispatch_async(q_main, ^{
                    _imageQRCode.image = image;
                });
            });

        }
            break;

        default:
            break;
    }
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
