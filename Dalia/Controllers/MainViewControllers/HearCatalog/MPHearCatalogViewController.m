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
}

- (void)viewWillAppear:(BOOL)animated {

    //🔴標準navigation
    [self setHidden_BasicNavigation:NO];
    [self setImage_BasicNavigation:[UIImage imageNamed:@"hearcatalog_ttl_title.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //load cell xib and attach with collectionView
    UINib *cellNib1 = [UINib nibWithNibName:@"HearCatalogCategoryCollectionCell" bundle:nil];
    [_col_category registerNib:cellNib1 forCellWithReuseIdentifier:@"hearCatalogCategoryCollectionCellIdentifier"];
    [_col_category reloadData];

    UINib *cellNib2 = [UINib nibWithNibName:@"HearCatalogNewstyleCollectionCell" bundle:nil];
    [_col_newstyle registerNib:cellNib2 forCellWithReuseIdentifier:@"hearCatalogNewstyleCollectionCellIdentifier"];
    [_col_newstyle reloadData];



    _ary_ledies_off = [@[@"hearcatalog_cate_ladies_short_s_dark.png", @"hearcatalog_cate_ladies_bob_s_dark.png", @"hearcatalog_cate_ladies_medium_s_dark.png", @"hearcatalog_cate_ladies_semilong_s_dark.png", @"hearcatalog_cate_ladies_long_s_dark.png", @"hearcatalog_cate_ladies_arrange_s_dark.png"] mutableCopy];
    _ary_ledies_on = [@[@"hearcatalog_cate_ladies_short_s_light.png", @"hearcatalog_cate_ladies_bob_s_light.png", @"hearcatalog_cate_ladies_medium_s_light.png", @"hearcatalog_cate_ladies_semilong_s_light.png", @"hearcatalog_cate_ladies_long_s_light.png", @"hearcatalog_cate_ladies_arrange_s_light.png"] mutableCopy];
    _ary_mens_off = [@[@"hearcatalog_cate_mens_short_s_dark.png", @"hearcatalog_cate_mens_medium_s_dark.png", @"hearcatalog_cate_mens_long_s_dark.png", @"hearcatalog_cate_mens_veryshort_s_dark.png"] mutableCopy];
    _ary_mens_on = [@[@"hearcatalog_cate_mens_short_s_light.png", @"hearcatalog_cate_mens_medium_s_light.png", @"hearcatalog_cate_mens_long_s_light.png", @"hearcatalog_cate_mens_veryshort_s_light.png"] mutableCopy];
    _ary_colection_off = nil;
    _ary_colection_on = nil;

    _ary_news = [@[@"hearcatalog_cate_ladies_short_s_dark.png", @"hearcatalog_cate_ladies_bob_s_dark.png", @"hearcatalog_cate_ladies_medium_s_dark.png", @"hearcatalog_cate_ladies_semilong_s_dark.png", @"hearcatalog_cate_ladies_long_s_dark.png", @"hearcatalog_cate_ladies_arrange_s_dark.png"] mutableCopy];

    [self setCategolyType:_lng_category];

    [_col_newstyle reloadData];
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

    [self resizeTable];
}

#pragma mark - ScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    _scrollBeginingPoint = [scrollView contentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint currentPoint = [scrollView contentOffset];
    if(_scrollBeginingPoint.y < currentPoint.y){

        //下方向の時のアクション
        //ナビゲーション　クローズ
//        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //ナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //ナビゲーション　オープン
//        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

- (void)setCategolyType:(long)type {

    _lng_category = type;

    switch (type) {
        case 0:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_dark.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];

            _ary_selectCategory_off = _ary_ledies_off;
            _ary_selectCategory_on = _ary_ledies_on;
        }
            break;
        case 1:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_dark.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];

            _ary_selectCategory_off = _ary_mens_off;
            _ary_selectCategory_on = _ary_mens_on;
        }
            break;
        case 2:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_dark.png"];

            _ary_selectCategory_off = _ary_colection_off;
            _ary_selectCategory_on = _ary_colection_on;
        }
    }

    [_col_category reloadData];
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

    if(collectionView == _col_category){

        return CGSizeMake(135.0f, 135.0f);
    }

    if(collectionView == _col_newstyle){

        return CGSizeMake(90.0f, 90.0f);
    }

    return CGSizeMake(90.0f, 90.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if(collectionView == _col_category){

        return UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    }

    if(collectionView == _col_newstyle){
        
        return UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    }
    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    if(collectionView == _col_category){

        return 0.0f;
    }

    if(collectionView == _col_newstyle){
        
        return 0.0f;
    }
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    if(collectionView == _col_category){

        return 10.0f;
    }

    if(collectionView == _col_newstyle){

        return 5.0f;
    }
    return 0.0f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if(collectionView == _col_category){

        return _ary_selectCategory_off.count;
    }

    if(collectionView == _col_newstyle){

        return _ary_news.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if(collectionView == _col_category){

        HearCatalogCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hearCatalogCategoryCollectionCellIdentifier" forIndexPath:indexPath];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HearCatalogCategoryCollectionCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        [cell.btn_image setImage:[UIImage imageNamed:[_ary_selectCategory_off objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        [cell.btn_image setImage:[UIImage imageNamed:[_ary_selectCategory_on objectAtIndex:indexPath.row]] forState:UIControlStateHighlighted];
        [cell.btn_image setImage:[UIImage imageNamed:[_ary_selectCategory_on objectAtIndex:indexPath.row]] forState:UIControlStateSelected];

        // イベントを付ける
        [cell.btn_image addTarget:self action:@selector(categolyTouchButton:event:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }

    if(collectionView == _col_newstyle){

        HearCatalogNewstyleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hearCatalogNewstyleCollectionCellIdentifier" forIndexPath:indexPath];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HearCatalogNewstyleCollectionCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        [cell setImage:[UIImage imageNamed:@"lady_01.png"]];
        
        return cell;
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if(collectionView == _col_category){


    }

    if(collectionView == _col_newstyle){


    }
}

- (void)resizeTable {

    _col_category.translatesAutoresizingMaskIntoConstraints = YES;
    CGRect rct_category = _col_category.frame;
    rct_category.size.height = ceil((double)_ary_selectCategory_off.count/2)*150;
    _col_category.frame = rct_category;

    _col_newstyle.translatesAutoresizingMaskIntoConstraints = YES;
    CGRect rct_newstyle = _col_newstyle.frame;
    rct_newstyle.size.height = ceil((double)_ary_news.count/3)*100;
    _col_newstyle.frame = rct_newstyle;
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
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

- (void)categolyTouchButton:(UIButton *)sender event:(UIEvent *)event {

    NSIndexPath *indexPath = [self indexPathForControlEvent:event];
    NSString *messageString = [NSString stringWithFormat:@"Button at section %d row %d was tapped.", indexPath.section, indexPath.row];

    MPHearCatalogCategoryListViewController *vc = [[MPHearCatalogCategoryListViewController alloc] initWithNibName:@"MPHearCatalogCategoryListViewController" bundle:nil];
    vc.delegate = self;
    vc.lng_categolyType = _lng_category;
    vc.lng_categolyNo = indexPath.row;

    [self.navigationController pushViewController:vc animated:YES];
}

// UIControlEventからタッチ位置のindexPathを取得する
- (NSIndexPath *)indexPathForControlEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint p = [touch locationInView:_col_category];
    NSIndexPath *indexPath = [_col_category indexPathForItemAtPoint:p];
    return indexPath;
}

@end
