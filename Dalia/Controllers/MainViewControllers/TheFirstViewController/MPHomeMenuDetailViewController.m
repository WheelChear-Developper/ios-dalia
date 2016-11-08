//
//  MPHomeMenuDetailViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPHomeMenuDetailViewController.h"
#import "MPTabBarViewController.h"

@interface MPHomeMenuDetailViewController ()
@end

@implementation MPHomeMenuDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //🔴navigation表示
    [self setBasicNavigationHiden:NO];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setCustomNavigationHiden:YES];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    //スクロールビュー作成
    _scr_rootview = [[UIScrollView alloc] initWithFrame:contentView.bounds];
    _scr_rootview.delegate = self;
    _scr_rootview.backgroundColor = [UIColor colorWithRed:246/255.0 green:229/255.0 blue:203/255.0 alpha:1.0];
    [_scr_rootview setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    scr_inView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 1000)];
    [_scr_rootview addSubview:scr_inView];
    _scr_rootview.contentSize = scr_inView.bounds.size;
    [contentView addSubview:_scr_rootview];

    cornerView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, scr_inView.frame.size.width-16, scr_inView.frame.size.height-16)];
    cornerView.backgroundColor = [UIColor whiteColor];
    cornerView.layer.cornerRadius = 8.0;
    cornerView.clipsToBounds = YES;
    [cornerView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [scr_inView addSubview:cornerView];

    imageMenu = [[UIImageView alloc] init];
    imageMenu.contentMode = UIViewContentModeScaleAspectFit;
    imageMenu.frame = CGRectMake(15, 15, cornerView.frame.size.width - 30, 0);
    [cornerView addSubview:imageMenu];

    titleMenu = [[UILabel alloc] init];
    titleMenu.frame = CGRectMake(15, imageMenu.frame.origin.y + imageMenu.frame.size.height + 10, cornerView.frame.size.width - 30, 24);
    titleMenu.backgroundColor = [UIColor clearColor];
    titleMenu.textColor = [UIColor blackColor];
    titleMenu.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    titleMenu.textAlignment = NSTextAlignmentLeft;
    titleMenu.numberOfLines = 0;
    titleMenu.lineBreakMode = NSLineBreakByTruncatingTail;
    [cornerView addSubview:titleMenu];

    priceMenu = [[UILabel alloc] init];
    priceMenu.frame = CGRectMake(15, titleMenu.frame.origin.y + titleMenu.frame.size.height + 10, cornerView.frame.size.width - 30, 14);
    priceMenu.backgroundColor = [UIColor clearColor];
    priceMenu.textColor = [UIColor blackColor];
    priceMenu.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    priceMenu.textAlignment = NSTextAlignmentLeft;
    [cornerView addSubview:priceMenu];

    lbl_contentMenu = [[UILabel alloc] init];
    lbl_contentMenu.frame = CGRectMake(15, priceMenu.frame.origin.y + priceMenu.frame.size.height + 10, cornerView.frame.size.width - 30, 24);
    lbl_contentMenu.backgroundColor = [UIColor clearColor];
    lbl_contentMenu.textColor = [UIColor blackColor];
    lbl_contentMenu.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    lbl_contentMenu.textAlignment = NSTextAlignmentLeft;
    lbl_contentMenu.numberOfLines = 0;
    lbl_contentMenu.lineBreakMode = NSLineBreakByTruncatingTail;
    [cornerView addSubview:lbl_contentMenu];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)setData:(id)object withType:(DETAIL_LIST_TYPE)type withRecommendType:(BOOL)isRecommend {

    _isRecommend = isRecommend;
    detailType = type;
    itemObject  = object;

    [[ManagerDownload sharedInstance] getDetailMenu:[Utility getDeviceID] withAppID:[Utility getAppID] withMenuID:[NSString stringWithFormat:@"%@",itemObject.id] delegate:self];
}

- (void)downloadDataSuccess:(DownloadParam *)param {
    
    switch (param.request_type) {
        case RequestType_GET_DETAIL_MENU:
        {
            if (param.result_code == 200) {
                
                alertMessage = NO_RECOMMEND_PRODUCT_MESSAGE;
                [title setHidden:NO];
            }else if (param.result_code == 202){
                
                alertMessage = NO_RECOMMEND_PRODUCT_MESSAGE;
                [title setHidden:NO];
            }
            itemObject = [param.listData lastObject];

            if (itemObject.image) {
                NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,itemObject.image]];
                NSURLRequest* request = [NSURLRequest requestWithURL:url];

                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse * response,
                                                           NSData * data,
                                                           NSError * error) {
                                           UIImage *image = nil;
                                           if (!error){
                                               image = [[UIImage alloc] initWithData:data];
                                               // do whatever you want with image
                                           }else{
                                               image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
                                           }

                                           UIImage *img_curpon = image;
                                           CGFloat cgrange_curpon = imageMenu.frame.size.width / img_curpon.size.width;
                                           imageMenu.frame = CGRectMake(imageMenu.frame.origin.x, imageMenu.frame.origin.y, imageMenu.frame.size.width, img_curpon.size.height * cgrange_curpon);

                                           [imageMenu setImage:image];

                                           titleMenu.frame = CGRectMake(titleMenu.frame.origin.x, imageMenu.frame.origin.y + imageMenu.frame.size.height + 10, titleMenu.frame.size.width, titleMenu.frame.size.height);
                                           [titleMenu sizeToFit];

                                           priceMenu.frame = CGRectMake(priceMenu.frame.origin.x, titleMenu.frame.origin.y + titleMenu.frame.size.height + 10, priceMenu.frame.size.width, priceMenu.frame.size.height);
                                           [priceMenu sizeToFit];

                                           lbl_contentMenu.frame = CGRectMake(lbl_contentMenu.frame.origin.x, priceMenu.frame.origin.y + priceMenu.frame.size.height + 10, lbl_contentMenu.frame.size.width, lbl_contentMenu.frame.size.height);
                                           [lbl_contentMenu sizeToFit];

                                           [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, lbl_contentMenu.frame.origin.y + lbl_contentMenu.frame.size.height + 30)];
                                           _scr_rootview.contentSize = scr_inView.bounds.size;
                                       }];
            }else{
                [imageMenu setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
            }

            [titleMenu setText:itemObject.title];

            NSLog(@"price:%@",itemObject.price);
            if ([[Utility checkNIL:itemObject.price] isEqualToString:@""]) {
                [priceMenu setText:@""];

            }else{
                [priceMenu setText:[NSString stringWithFormat:@"¥%@（＋税）",itemObject.price]];
            }

            [lbl_contentMenu setText:itemObject.content];
        }
            break;
            
        default:
            break;
    }
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

@end
