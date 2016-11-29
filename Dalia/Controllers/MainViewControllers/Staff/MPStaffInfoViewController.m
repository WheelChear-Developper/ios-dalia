//
//  MPStaffInfoViewController.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPStaffInfoViewController.h"

@interface MPStaffInfoViewController ()
@end

@implementation MPStaffInfoViewController

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
    [self setImage_BasicNavigation:[UIImage imageNamed:@"header_ttl_staff.png"]];
    [self setHiddenBackButton:NO];

    //🔴カスタムnavigation
    [self setHidden_CustomNavigation:YES];
    [self setImage_CustomNavigation:nil];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //load cell xib and attach with collectionView
    UINib *cellNib1 = [UINib nibWithNibName:@"MPStaffCollectionCell" bundle:nil];
    [_col_photolist registerNib:cellNib1 forCellWithReuseIdentifier:@"staffCollectionCellIdentifier"];
    [_col_photolist reloadData];



    _ary_photoList = [@[@"lady_01.png", @"lady_02.png", @"lady_03.png", @"lady_04.png", @"lady_05.png", @"lady_06.png", @"lady_07.png", @"lady_08.png", @"lady_09.png", @"lady_10.png"] mutableCopy];

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
        //カスタムトップナビゲーション　クローズ
        [self setFadeOut_CustomNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_CustomNavigation:false];

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

        MPStaffCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"staffCollectionCellIdentifier" forIndexPath:indexPath];
        if(cell == nil){

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPStaffCollectionCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        cell.img_photo.image = [UIImage imageNamed:[_ary_photoList objectAtIndex:indexPath.row]];

        return cell;
    }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"Clicked %ld-%ld",indexPath.section,indexPath.row);
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

@end

