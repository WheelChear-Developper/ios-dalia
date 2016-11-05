//
//  MPCouponDetailViewController.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponDetailViewController.h"

@interface MPCouponDetailViewController ()
@end

@implementation MPCouponDetailViewController

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
    
    //テーブル追加
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, cornerView.frame.size.width - 20, cornerView.frame.size.height) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = false;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"MPCouponDetailCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"couponDetailIdentifier"];
    [_tableView reloadData];
}

- (void)setData:(MPCouponObject *)object {
    
    couponObj = object;
    [_tableView reloadData];
}

- (void)backButtonClicked:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MPCouponDetailCell heightForRow:couponObj];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MPCouponDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponDetailIdentifier"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPCouponDetailCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [cell setData:couponObj];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    [self resizeTable];
    
    return nil;
}

- (void)resizeTable {
    
    //テーブル高さをセルの最大値へセット
    _tableView.frame =
    CGRectMake(_tableView.frame.origin.x,
               _tableView.frame.origin.y,
               _tableView.contentSize.width,
               MIN(_tableView.contentSize.height,
                   _tableView.bounds.size.height));
    
    //スクロール内のVIEW幅調整
    [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, _tableView.frame.size.height + 40)];
    
    _scr_rootview.contentSize = scr_inView.bounds.size;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
