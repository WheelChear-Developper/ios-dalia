//
//  MPHearCatalogViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/25.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPHearCatalogViewController.h"

@interface MPHearCatalogViewController ()
@end

@implementation MPHearCatalogViewController

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

    //カテゴリ初期値設定
    _lng_category = 0;
    [self setCategolyType:_lng_category];
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"hearcatalog_ttl_title.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_CustomNavigation:YES];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //load cell xib and attach with collectionView
    UINib *cellNib = [UINib nibWithNibName:@"HearCatalogCollectionCell" bundle:nil];
    [_col_catalog registerNib:cellNib forCellWithReuseIdentifier:@"hearCatalogCollectionIdentifier"];
    [_col_catalog reloadData];
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
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:true];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　クローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_CustomNavigation:false];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)setCategolyType:(long)type {

    [_view_ladies setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_view_ladies sizeToFit];
    [_view_mens setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_view_mens sizeToFit];

    switch (type) {
        case 0:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_dark.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];

            [_view_ladies setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies1 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies2 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies3 setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect rct_lady1 = _view_ladies1.frame;
            rct_lady1.size.height = 150;
            _view_ladies1.frame = rct_lady1;
            CGRect rct_lady2 = _view_ladies2.frame;
            rct_lady2.size.height = 150;
            _view_ladies2.frame = rct_lady2;
            CGRect rct_lady3 = _view_ladies3.frame;
            rct_lady3.size.height = 150;
            _view_ladies3.frame = rct_lady3;
            CGRect rct_lady = _view_ladies.frame;
            rct_lady.size.height = 300;
            _view_ladies.frame = rct_lady;

            [_view_mens setTranslatesAutoresizingMaskIntoConstraints:NO];
            [_view_mens1 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_mens2 setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect rct_mens1 = _view_mens1.frame;
            rct_mens1.size.height = 0;
            _view_mens1.frame = rct_mens1;
            CGRect rct_mens2 = _view_mens2.frame;
            rct_mens2.size.height = 0;
            _view_mens2.frame = rct_mens2;
            CGRect rct_mens = _view_mens.frame;
            rct_mens.size.height = 0;
            _view_mens.frame = rct_mens;

            [_btn_lady_short setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_short_s_dark.png"] forState:UIControlStateNormal];
            [_btn_lady_short setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_short_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_lady_short setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_short_s_light.png"] forState:UIControlStateSelected];

            [_btn_lady_bob setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_bob_s_dark.png"] forState:UIControlStateNormal];
            [_btn_lady_bob setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_bob_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_lady_bob setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_bob_s_light.png"] forState:UIControlStateSelected];

            [_btn_lady_medium setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_medium_s_dark.png"] forState:UIControlStateNormal];
            [_btn_lady_medium setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_medium_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_lady_medium setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_medium_s_light.png"] forState:UIControlStateSelected];

            [_btn_lady_semilong setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_semilong_s_dark.png"] forState:UIControlStateNormal];
            [_btn_lady_semilong setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_semilong_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_lady_semilong setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_semilong_s_light.png"] forState:UIControlStateSelected];

            [_btn_lady_long setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_long_s_dark.png"] forState:UIControlStateNormal];
            [_btn_lady_long setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_long_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_lady_long setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_long_s_light.png"] forState:UIControlStateSelected];

            [_btn_lady_arenge setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_arrange_s_dark.png"] forState:UIControlStateNormal];
            [_btn_lady_arenge setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_arrenge_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_lady_arenge setImage:[UIImage imageNamed:@"hearcatalog_cate_ladies_arrenge_s_light.png"] forState:UIControlStateSelected];
        }
            break;
        case 1:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_dark.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];

            [_view_ladies setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies1 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies2 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies3 setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect rct_lady1 = _view_ladies1.frame;
            rct_lady1.size.height = 0;
            _view_ladies1.frame = rct_lady1;
            CGRect rct_lady2 = _view_ladies2.frame;
            rct_lady2.size.height = 0;
            _view_ladies2.frame = rct_lady2;
            CGRect rct_lady3 = _view_ladies3.frame;
            rct_lady3.size.height = 0;
            _view_ladies3.frame = rct_lady3;
            CGRect rct_lady = _view_ladies.frame;
            rct_lady.size.height = 0;
            _view_ladies.frame = rct_lady;

            [_view_mens setTranslatesAutoresizingMaskIntoConstraints:NO];
            [_view_mens1 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_mens2 setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect rct_mens1 = _view_mens1.frame;
            rct_mens1.size.height = 150;
            _view_mens1.frame = rct_mens1;
            CGRect rct_mens2 = _view_mens2.frame;
            rct_mens2.size.height = 150;
            _view_mens2.frame = rct_mens2;
            CGRect rct_mens = _view_mens.frame;
            rct_mens.size.height = 150;
            _view_mens.frame = rct_mens;

            [_btn_mens_short setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_short_s_dark.png"] forState:UIControlStateNormal];
            [_btn_mens_short setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_short_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_mens_short setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_short_s_light.png"] forState:UIControlStateSelected];

            [_btn_mens_medium setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_medium_s_dark.png"] forState:UIControlStateNormal];
            [_btn_mens_medium setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_medium_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_mens_medium setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_medium_s_light.png"] forState:UIControlStateSelected];

            [_btn_mens_long setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_long_s_dark.png"] forState:UIControlStateNormal];
            [_btn_mens_long setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_long_s_light.png"] forState:UIControlStateHighlighted];
            [_btn_mens_long setImage:[UIImage imageNamed:@"hearcatalog_cate_mens_long_s_light.png"] forState:UIControlStateSelected];
        }
            break;
        case 2:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_dark.png"];

            [_view_ladies setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies1 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies2 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_ladies3 setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect rct_lady1 = _view_ladies1.frame;
            rct_lady1.size.height = 0;
            _view_ladies1.frame = rct_lady1;
            CGRect rct_lady2 = _view_ladies2.frame;
            rct_lady2.size.height = 0;
            _view_ladies2.frame = rct_lady2;
            CGRect rct_lady3 = _view_ladies3.frame;
            rct_lady3.size.height = 0;
            _view_ladies3.frame = rct_lady3;
            CGRect rct_lady = _view_ladies.frame;
            rct_lady.size.height = 0;
            _view_ladies.frame = rct_lady;

            [_view_mens setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_mens1 setTranslatesAutoresizingMaskIntoConstraints:YES];
            [_view_mens2 setTranslatesAutoresizingMaskIntoConstraints:YES];
            CGRect rct_mens1 = _view_mens1.frame;
            rct_mens1.size.height = 0;
            _view_mens1.frame = rct_mens1;
            CGRect rct_mens2 = _view_mens2.frame;
            rct_mens2.size.height = 0;
            _view_mens2.frame = rct_mens2;
            CGRect rct_mens = _view_mens.frame;
            rct_mens.size.height = 0;
            _view_mens.frame = rct_mens;
        }
            break;

        default:
            break;
    }
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

#pragma mark - UICollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(90.0f, 90.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HearCatalogCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hearCatalogCollectionIdentifier" forIndexPath:indexPath];
    if(cell == nil){

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HearCatalogCollectionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setImage:[UIImage imageNamed:@"lady_01.png"]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Clicked %ld-%ld",indexPath.section,indexPath.row);
}

- (void)backButtonClicked:(UIButton *)sender {

    [(MPTabBarViewController*)[self.navigationController parentViewController] setTabViewIndex:_lng_tabNo];
    [(MPTabBarViewController*)[self.navigationController parentViewController] selectTab:_lng_tabNo];
    [(MPTabBarViewController*)[self.navigationController parentViewController] setUpTabBar];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)btn_ladies:(id)sender {

    [self setCategolyType:0];
}

- (IBAction)btn_mens:(id)sender {


    [self setCategolyType:1];
}

- (IBAction)btn_favorite:(id)sender {

    [self setCategolyType:2];
}

-(IBAction)btn_lady_short:(id)sender {
}

-(IBAction)btn_lady_bob:(id)sender {
}

-(IBAction)btn_lady_medium:(id)sender {
}

-(IBAction)btn_lady_semilong:(id)sender {
}

-(IBAction)btn_lady_long:(id)sender {
}

-(IBAction)btn_lady_arenge:(id)sender {
}

-(IBAction)btn_mens_short:(id)sender {
}

-(IBAction)btn_mens_medium:(id)sender {
}

-(IBAction)btn_mens_long:(id)sender {
}

@end
