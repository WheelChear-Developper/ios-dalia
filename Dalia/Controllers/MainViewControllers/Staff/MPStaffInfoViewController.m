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
    [self setImage_CustomNavigation:nil imagePosition:1];

    //🔴タブの表示
    [(MPTabBarViewController*)[self.navigationController parentViewController] setHidden_Tab:NO];

    [super viewWillAppear:animated];

    //画像設定
    if(self.obj_staff.image && [self.obj_staff.image length] > 0 ) {

        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{

            NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,self.obj_staff.image];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

            dispatch_async(q_main, ^{
                [img_photo setImage:image];
            });
        });
    }else{
        [img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }

    lbl_name1.text = [NSString stringWithFormat:@"%@ %@",self.obj_staff.name1, self.obj_staff.name2];
    lbl_name2.text = self.obj_staff.post;
    lbl_comment.text = self.obj_staff.content;

    _str_instagram_url = self.obj_staff.instagram_url;
    _str_facebook_url = self.obj_staff.facebook_url;
    _str_twitter_url = self.obj_staff.twitter_url;
    _str_reserve_url = self.obj_staff.reserve_url;
    _str_blog_url = self.obj_staff.blog_url;

    //load cell xib and attach with collectionView
    UINib *cellNib1 = [UINib nibWithNibName:@"MPStaffCollectionCell" bundle:nil];
    [_col_photolist registerNib:cellNib1 forCellWithReuseIdentifier:@"staffCollectionCellIdentifier"];
    [_col_photolist reloadData];

    //行間設定
    CGFloat customLineHeight = 16.0f;

    // パラグラフスタイルにlineHeightをセット
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.minimumLineHeight = customLineHeight;
    paragrahStyle.maximumLineHeight = customLineHeight;

    // NSAttributedStringを生成してパラグラフスタイルをセット
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:lbl_comment.text];
    [attributedText addAttribute:NSParagraphStyleAttributeName
                           value:paragrahStyle
                           range:NSMakeRange(0, attributedText.length)];

    lbl_comment.numberOfLines = 0;
    lbl_comment.attributedText = attributedText;
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
        [self setFadeOut_BasicNavigation:true];

        //タブのクローズ
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:true];

    }else if(_scrollBeginingPoint.y ==0){

        //スクロール０
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];

    }else if(_scrollBeginingPoint.y > currentPoint.y){

        //上方向の時のアクション
        //カスタムトップナビゲーション　オープン
        [self setFadeOut_BasicNavigation:false];

        //タブのオープン
        [(MPTabBarViewController*)[self.navigationController parentViewController] setFadeOut_Tab:false];
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
}

- (void)downloadDataFail:(DownloadParam *)param {
}

#pragma mark - UICollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if(collectionView == _col_photolist){

        return CGSizeMake(70.0f, 70.0f);
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

        return self.ary_photoImage.count;
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

        //画像設定
        if([self.ary_photoImage objectAtIndex:indexPath.row] && [[self.ary_photoImage objectAtIndex:indexPath.row] length] > 0 ) {

            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{

                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,[self.ary_photoImage objectAtIndex:indexPath.row]];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];

                dispatch_async(q_main, ^{
                    [cell.img_photo setImage:image];
                });
            });
        }else{
            [cell.img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
        }

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
    rct_photolist.size.height = ceil((double)self.ary_photoImage.count/3)*150;
    _col_photolist.frame = rct_photolist;
}

- (void)backButtonClicked:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btn_yoyaku:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_reserve_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_insta:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_instagram_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_facebook:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_facebook_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_twitter:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_twitter_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

- (IBAction)btn_blog:(id)sender {

    MPWebViewController *webViewVC = [[MPWebViewController alloc] initWithNibName:@"MPWebViewController" bundle:nil];
    webViewVC.linkUrl = _str_blog_url;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

@end

