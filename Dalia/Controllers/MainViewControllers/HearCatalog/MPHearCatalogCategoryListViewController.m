//
//  MPHearCatalogCategoryListViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPHearCatalogCategoryListViewController.h"

@interface MPHearCatalogCategoryListViewController ()
@end

@implementation MPHearCatalogCategoryListViewController

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
    [self setImage_BasicNavigation:[UIImage imageNamed:@"hearcatalog_ttl_title.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //load cell xib and attach with collectionView
    UINib *cellNib1 = [UINib nibWithNibName:@"HearCatalogCategoryListViewControllerCell" bundle:nil];
    [_col_photolist registerNib:cellNib1 forCellWithReuseIdentifier:@"hearCatalogCategoryListViewControllerCellIdentifier"];
    [_col_photolist reloadData];



    _ary_photoList = [@[@"lady_01.png", @"lady_02.png", @"lady_03.png", @"lady_04.png", @"lady_05.png", @"lady_06.png", @"lady_07.png", @"lady_08.png", @"lady_09.png", @"lady_10.png"] mutableCopy];

    //カテゴリ初期値設定
    _lng_category = self.lng_categolyType;
    [self setCategolyType:_lng_category];

    [_col_photolist reloadData];
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
        //トップナビゲーション　クローズ
//        [self setFadeOut_BasicNavigation:true];

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

            switch (self.lng_categolyNo) {
                case 0:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_ladies_short_w.png"];
                }
                    break;
                case 1:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_ladies_bob_w.png"];
                }
                    break;
                case 2:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_ladies_medium_w.png"];
                }
                    break;
                case 3:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_ladies_semilong_w.png"];
                }
                    break;
                case 4:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_ladies_long_w.png"];
                }
                    break;
                case 5:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_ladies_arrange_w.png"];
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 1:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_dark.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_light.png"];

            switch (self.lng_categolyNo) {
                case 0:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_mens_short_w.png"];
                }
                    break;
                case 1:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_mens_medium_w.png"];
                }
                    break;
                case 2:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_mens_long_w.png"];
                }
                    break;
                case 3:
                {
                    _img_photo.image = [UIImage imageNamed:@"hearcatalog_cate_mens_veryshort_w.png"];
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 2:
        {
            _img_ladies.image = [UIImage imageNamed:@"hearcatalog_btn_ladies_light.png"];
            _img_mens.image = [UIImage imageNamed:@"hearcatalog_btn_mens_light.png"];
            _img_favorite.image = [UIImage imageNamed:@"hearcatalog_btn_favorit_dark.png"];

            _img_photo.image = nil;
        }
    }

    [_col_photolist reloadData];
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

    if(collectionView == _col_photolist){

        return CGSizeMake(90.0f, 90.0f);
    }

    return CGSizeMake(0.0f, 0.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    if(collectionView == _col_photolist){

        return UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
    }

    return UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {

    if(collectionView == _col_photolist){

        return 0.0f;
    }
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {

    if(collectionView == _col_photolist){

        return 10.0f;
    }
    return 0.0f;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if(collectionView == _col_photolist){

        return _ary_photoList.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if(collectionView == _col_photolist){

        HearCatalogCategoryListViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hearCatalogCategoryListViewControllerCellIdentifier" forIndexPath:indexPath];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HearCatalogCategoryListViewControllerCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        cell.img_photo.image = [UIImage imageNamed:[_ary_photoList objectAtIndex:indexPath.row]];

        CGSize size_img = [UIImage imageNamed:[_ary_photoList objectAtIndex:indexPath.row]].size;

        double sizeFix = size_img.width / cell.img_photo.frame.size.width;

        CGRect rct_cell = cell.img_photo.frame;
//        rct_cell.size.height = size_img.height * sizeFix;
        cell.img_photo.frame = rct_cell;

        return cell;
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Clicked %ld-%ld",indexPath.section,indexPath.row);

    MPHearCatalogCategoryListInfoViewController *vc = [[MPHearCatalogCategoryListInfoViewController alloc] initWithNibName:@"MPHearCatalogCategoryListInfoViewController" bundle:nil];
    vc.delegate = self;
    vc.lng_categolyType = _lng_category;
    vc.lng_categolyNo = indexPath.row;
    vc.ary_photoList = _ary_photoList;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)resizeTable {

    _col_photolist.translatesAutoresizingMaskIntoConstraints = YES;
    CGRect rct_photolist = _col_photolist.frame;
    rct_photolist.size.height = ceil((double)_ary_photoList.count/3)*150;
    _col_photolist.frame = rct_photolist;
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


@end

