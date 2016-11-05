//
//  MPShopDetailViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/4/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPShopDetailViewController.h"
#import "MPTabBarViewController.h"

@interface MPShopDetailViewController ()
@end

@implementation MPShopDetailViewController

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
    [self setNavigationHiden:NO];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:NO];
    
    //🔴contentView 高さ自動調整　幅自動調整
    [contentView setAutoresizingMask: UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
    //タイトルビュー
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 30)];
    [contentView addSubview:titleView];
    
    //タイトルのグラデーション
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, titleView.frame.size.width, titleView.frame.size.height);
    gradient.colors = @[
                        (id)[UIColor colorWithRed:0.992 green:0.937 blue:0.831 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.894 green:0.820 blue:0.694 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:0.780 green:0.706 blue:0.576 alpha:1].CGColor
                        ];
    [titleView.layer addSublayer:gradient];
    
    //タイトルラベル
    lbl_title = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, titleView.frame.size.width - 8, 30)];
    [lbl_title setBackgroundColor:[UIColor clearColor]];
    [lbl_title setTextColor:[UIColor blackColor]];
    [lbl_title setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    [titleView addSubview:lbl_title];
    
    //スクロールビュー作成
    _scr_rootview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height, contentView.frame.size.width, contentView.frame.size.height - titleView.frame.size.height)];
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

    //ヘッダーのセット
    headerView = (MPHeaderShopView*) [Utility viewInBundleWithName:@"MPHeaderShopView"];
    headerView.frame = CGRectMake(0, 0, cornerView.frame.size.width, headerView.frame.size.height);
    headerView.delegate = self;
    [cornerView addSubview:headerView];

    //テーブル追加
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headerView.frame.origin.y, cornerView.frame.size.width, 0) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = false;
    _tableView.estimatedRowHeight = 10.0f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_tableView];

    UINib *nib = [UINib nibWithNibName:@"MPShopDetailCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"shopDetailIdentifier"];
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
    
    if (self.shopId) {

        [[ManagerDownload sharedInstance] getDetailShop:[Utility getAppID] withShopID:self.shopId withDeviceID:[Utility getDeviceID] delegate:self];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

    lng_TotalHeight = 0;
    for(long l=0;l<listTitle.count;l++){

        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:l inSection:0];

        CGRect rectOfCellInTableView = [_tableView rectForRowAtIndexPath:indexpath];
        CGRect rectOfCellInSuperview = [_tableView convertRect:rectOfCellInTableView toView:[_tableView superview]];

        lng_TotalHeight += rectOfCellInSuperview.size.height;
    }

    if(listTitle.count > 0){

        //テーブル高さ調整
        [self resizeTable];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

- (void)backButtonClicked:(UIButton *)sender {
    
    if (self.hasOneItem) {
        [(MPTabBarViewController*)[self.navigationController parentViewController] setSelectedIndex:0];
        [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:0];
        [[MPTabBarViewController sharedInstance] setUpTabBar];
        [[MPTabBarViewController sharedInstance] setDisableHomeButton:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ManagerDownload
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    self.shopId = @"";
    self.shopId = nil;
    shopObject = (MPShopObject*)[param.listData lastObject];

    //Head値セット
    [headerView setData:shopObject];

    //店名設定
    lbl_title.text = shopObject.shop_name;

    if(![[Utility checkNIL:shopObject.other_content] isEqualToString:@""]){

        listContent = @[[Utility checkNIL:shopObject.phone],[Utility checkNIL:shopObject.business_hour],[Utility checkNIL:shopObject.regular_holiday],[Utility checkNIL:shopObject.parking],[Utility checkNIL:shopObject.seat_number],[Utility checkNIL:shopObject.other_content]];
        listTitle = @[@"電話番号",@"営業時間",@"定休日",@"駐車場",@"席数",[Utility checkNIL:shopObject.other_title]];
    }else{

        listContent = @[[Utility checkNIL:shopObject.phone],[Utility checkNIL:shopObject.business_hour],[Utility checkNIL:shopObject.regular_holiday],[Utility checkNIL:shopObject.parking],[Utility checkNIL:shopObject.seat_number],[Utility checkNIL:shopObject.other_content]];
        listTitle = @[@"電話番号",@"営業時間",@"定休日",@"駐車場",@"席数"];
    }

    [_tableView reloadData];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return listTitle.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPShopDetailCell *shop_cell = [tableView dequeueReusableCellWithIdentifier:@"shopDetailIdentifier"];
    if(shop_cell == nil){

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPShopDetailCell" owner:self options:nil];
        shop_cell = [nib objectAtIndex:0];
    }

    [shop_cell.titleLabel setText:listTitle[indexPath.row]];
    if(![listContent[indexPath.row] isEqualToString:@""]){

        [shop_cell.contentLabel setText:listContent[indexPath.row]];
    }else{

        [shop_cell.contentLabel setText:@"　"];
    }

    [shop_cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return shop_cell;
}

- (void)resizeTable {

    headerView.frame = CGRectMake(0, 0, cornerView.frame.size.width, 618);

    NSLog(@"%f",headerView.frame.size.height);

    //テーブル高さをセルの最大値へセット
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, headerView.frame.origin.y + headerView.frame.size.height, _tableView.frame.size.width, 0);
    _tableView.frame =
    CGRectMake(_tableView.frame.origin.x,
               _tableView.frame.origin.y,
               _tableView.contentSize.width,
               lng_TotalHeight);
    
    //スクロール内のVIEW幅調整
    [scr_inView setFrame:CGRectMake(0, 0, scr_inView.frame.size.width, headerView.frame.size.height + _tableView.frame.size.height + 30)];
    
    _scr_rootview.contentSize = scr_inView.bounds.size;
}

- (void)delShop {
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"マイショップから解除しました。"
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setShop {
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"マイショップに登録しました。"
                                        message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
