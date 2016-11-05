//
//  MPTheFifthViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPTheFifthViewController.h"
#import "MPTabBarViewController.h"
#import "MPShopDetailViewController.h"
#import "MPShopCell.h"
#import "MPShopEliaCell.h"
#import "MPShopCatObject.h"
#include <objc/runtime.h>

//カテゴリで機能拡張
@interface NSMutableArray (Extended)
@property (getter=isExtended) BOOL extended;
@end

@implementation NSMutableArray (Extended)
// アコーディオンが開いているかどうかを設定するところ
- (BOOL)isExtended
{
    return [objc_getAssociatedObject(self, @"extended") boolValue];
}
- (void)setExtended:(BOOL)extended
{
    objc_setAssociatedObject(self, @"extended", [NSNumber numberWithLongLong:extended], OBJC_ASSOCIATION_ASSIGN);
}
@end

@implementation MPTheFifthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //🔴バックアクション非表示
    [self setHiddenBackButton:YES];
    
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

    //タイトル
    myShopTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, cornerView.frame.size.width - 30, 26)];
    myShopTitle.numberOfLines = 0;
    myShopTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [myShopTitle setBackgroundColor:[UIColor clearColor]];
    [myShopTitle setTextColor:[UIColor blackColor]];
    [myShopTitle setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    
    [myShopTitle setText:[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab4] objectForKey:@"titleMyshop"]];
    [cornerView addSubview:myShopTitle];

    //未登録時の説明文
    myShopNotSetInfo = [[UILabel alloc] initWithFrame:CGRectMake(15, myShopTitle.frame.origin.y + myShopTitle.frame.size.height, cornerView.frame.size.width - 30, 50)];
    myShopNotSetInfo.numberOfLines = 0;
    myShopNotSetInfo.lineBreakMode = NSLineBreakByWordWrapping;
    [myShopNotSetInfo setBackgroundColor:[UIColor clearColor]];
    [myShopNotSetInfo setTextColor:[UIColor blackColor]];
    [myShopNotSetInfo setFont:[UIFont fontWithName:FONT_MESSAGE_APP size:FONT_SIZE_TITLE_APP]];

    [myShopNotSetInfo setText:[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab4] objectForKey:@"messageMyShop"]];
    [cornerView addSubview:myShopNotSetInfo];

    //マイショップテーブル
    _myshop_tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, myShopNotSetInfo.frame.origin.y + myShopNotSetInfo.frame.size.height, cornerView.frame.size.width - 30, 0) style:UITableViewStylePlain];
    [_myshop_tableView setBackgroundColor:[UIColor clearColor]];
    _myshop_tableView.delegate = self;
    _myshop_tableView.dataSource = self;
    _myshop_tableView.scrollEnabled = false;
    [_myshop_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_myshop_tableView];
    
    UINib *nib_myshop = [UINib nibWithNibName:@"MPShopCell" bundle:nil];
    [_myshop_tableView registerNib:nib_myshop forCellReuseIdentifier:@"shopIdentifier"];
    [_myshop_tableView reloadData];

    //タイトル2
    title2 = [[UILabel alloc] initWithFrame:CGRectMake(15, _myshop_tableView.frame.origin.y + _myshop_tableView.frame.size.height + 5, cornerView.frame.size.width, 26)];
    CGRect titleFrame2 = title2.frame;
    title2.frame = titleFrame2;
    [title2 setBackgroundColor:[UIColor clearColor]];
    [title2 setTextColor:[UIColor blackColor]];
    [title2 setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    
    [title2 setText:[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab4] objectForKey:@"titleElia"]];
    [cornerView addSubview:title2];
    
    //エリアテーブル
    _elia_tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, title2.frame.origin.y + title2.frame.size.height, cornerView.frame.size.width - 30, 0) style:UITableViewStylePlain];
    [_elia_tableView setBackgroundColor:[UIColor clearColor]];
    _elia_tableView.delegate = self;
    _elia_tableView.dataSource = self;
//    _elia_tableView.scrollEnabled = false;
    [_elia_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_elia_tableView];
    
    UINib *nib_elia = [UINib nibWithNibName:@"MPShopEliaCell" bundle:nil];
    [_elia_tableView registerNib:nib_elia forCellReuseIdentifier:@"shopEliaIdentifier"];
    [_elia_tableView reloadData];
    
    UINib *nib_elia_myshop = [UINib nibWithNibName:@"MPShopCell" bundle:nil];
    [_elia_tableView registerNib:nib_elia_myshop forCellReuseIdentifier:@"shopIdentifier"];
    [_elia_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];

    //データ取得
    [[ManagerDownload sharedInstance] getListCatShop:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    NSMutableArray* ary_root_shops = [NSMutableArray array];
    NSMutableArray* ary_roor_elias = [NSMutableArray array];
    
    NSMutableArray* ary_shops = [NSMutableArray array];
    NSMutableArray* ary_elias = [NSMutableArray array];
    NSMutableArray* subItems = [NSMutableArray array];

    ary_root_shops = [[[param.listData valueForKey:@"favorite_list"] objectAtIndex:0] objectAtIndex:0];
    ary_roor_elias = [[[param.listData valueForKey:@"shops"] objectAtIndex:0] objectAtIndex:0];
    
    NSLog(@"%@",ary_root_shops);

    if(![ary_root_shops isEqual:[NSNull null]]){
        
        ary_shops = ary_root_shops;

        // myshop有り無しでの表示切り替え
        if(ary_shops.count == 0){

            // 未登録時のメッセージ表示
            myShopNotSetInfo.hidden = NO;
            myShopNotSetInfo.frame = CGRectMake(myShopNotSetInfo.frame.origin.x, myShopNotSetInfo.frame.origin.y, myShopNotSetInfo.frame.size.width, 50);
            _myshop_tableView.frame = CGRectMake(10, myShopNotSetInfo.frame.origin.y + myShopNotSetInfo.frame.size.height, cornerView.frame.size.width - 20, 0);
            title2.frame = CGRectMake(0, _myshop_tableView.frame.origin.y + _myshop_tableView.frame.size.height, cornerView.frame.size.width, 32);
            _elia_tableView.frame = CGRectMake(10, title2.frame.origin.y + title2.frame.size.height, cornerView.frame.size.width - 20, 0);

        }else{

            // 未登録時のメッセージ表示
            myShopNotSetInfo.hidden = YES;
            myShopNotSetInfo.frame = CGRectMake(myShopNotSetInfo.frame.origin.x, myShopNotSetInfo.frame.origin.y, myShopNotSetInfo.frame.size.width, 0);
            _myshop_tableView.frame = CGRectMake(10, myShopNotSetInfo.frame.origin.y + myShopNotSetInfo.frame.size.height, cornerView.frame.size.width - 20, 0);
            // REPRASED BY M.ama 2016.10.25 END
            title2.frame = CGRectMake(0, _myshop_tableView.frame.origin.y + _myshop_tableView.frame.size.height, cornerView.frame.size.width, 32);
            _elia_tableView.frame = CGRectMake(10, title2.frame.origin.y + title2.frame.size.height, cornerView.frame.size.width - 20, 0);

        }
    }
    
    if(![ary_roor_elias isEqual:[NSNull null]]){
        
        ary_elias_groupe = [NSMutableArray new];
        for (long c = 0;c < [ary_roor_elias count];c++){
            
            NSString* str_ShopName = [[ary_roor_elias valueForKey:@"cat_name"] objectAtIndex:c];
//            NSLog(@"%@",str_ShopName);
            [ary_elias_groupe addObject:str_ShopName];
            
            subItems = [NSMutableArray array];
            
            subItems.extended = NO;
            for (long d = 0;d < [[[ary_roor_elias valueForKey:@"shop_list"] objectAtIndex:c] count];d++){
                
                NSMutableArray* subShop = [[ary_roor_elias valueForKey:@"shop_list"] objectAtIndex:c];
                [subItems addObject:subShop];
            }
            [ary_elias addObject:subItems];
        }
    }
    
    arr_myShop = ary_shops;
    [_myshop_tableView reloadData];
    
    arr_eliaShop = ary_elias;
    [_elia_tableView reloadData];
    
    //テーブル高さ調整
    [self resizeTable];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)setListShop:(NSArray *)array {

}

// ロード時に呼び出される。セクション数を返すように実装する
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // テーブルごとでのセクション数設定
    if(tableView == _myshop_tableView){
        
        return 1;
    }
    
    if(tableView == _elia_tableView){
        
        return [arr_eliaShop count];
    }
    return 0;
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == _myshop_tableView){
        
        if (arr_myShop.count > 0) {
            
            return arr_myShop.count;
        }
        if ([MPAppDelegate sharedMPAppDelegate].networkStatus) {
            if (!arr_myShop) {
                return 0;
            }
        }
    }
    
    if(tableView == _elia_tableView){
        
        if (arr_eliaShop.count > 0) {
            
            return ((NSMutableArray*)arr_eliaShop[(NSUInteger) section]).extended ? [arr_eliaShop[(NSUInteger) section] count] + 1 : 1;
        }
        if ([MPAppDelegate sharedMPAppDelegate].networkStatus) {
            if (!arr_eliaShop) {
                return 0;
            }
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == _myshop_tableView){

        // お気に入り設定
        MPShopCell *shop_cell = [tableView dequeueReusableCellWithIdentifier:@"shopIdentifier"];
        
        // ハイライトなし
        shop_cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        if(indexPath.row == 0){
            
            //セル上部のライン表示切り替え
            [shop_cell.imgUpLine setHidden:NO];
        }else{
            
            //セル上部のライン表示切り替え
            [shop_cell.imgUpLine setHidden:YES];
        }
        
        NSMutableArray* ary_groupeItems = [arr_myShop objectAtIndex:indexPath.row];
        NSString* strText = [ary_groupeItems valueForKey:@"shop_name"];
        
        [shop_cell.titleShop setText:strText];
        
        NSString* strListCGUrl = [ary_groupeItems valueForKey:@"thumbnail"];
        if(![strListCGUrl isEqual:[NSNull null]] && [strListCGUrl length] > 0){
            
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            shop_cell.imageView.image = nil;
            dispatch_async(q_global, ^{
                NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,strListCGUrl];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
                
                dispatch_async(q_main, ^{
                    shop_cell.shopImage.image = image;
                    [shop_cell layoutSubviews];
                });
            });
        }else{
            
            UIImage *image = nil;
            image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
            [shop_cell.shopImage setBackgroundColor:[UIColor whiteColor]];
            [shop_cell.shopImage setImage:image];
        }
        
        return shop_cell;
    }
    
    if(tableView == _elia_tableView){
        
        MPShopEliaCell *elia_groupe_cell = [tableView dequeueReusableCellWithIdentifier:@"shopEliaIdentifier"];
        MPShopCell *shop_cell = [tableView dequeueReusableCellWithIdentifier:@"shopIdentifier"];
    
        static NSString *ParentCellIdentifier = @"shopEliaIdentifier";
        static NSString *ChildCellIdentifier = @"shopIdentifier";
        NSInteger section = indexPath.section;
        NSInteger row =indexPath.row;
        NSMutableArray *subItems;
        subItems = arr_eliaShop[(NSUInteger) section];
        
        NSString *identifier;
        if(row == 0){
            identifier = ParentCellIdentifier;
        } else {
            identifier = ChildCellIdentifier;
        }
        
        //グループ用セル設定
        elia_groupe_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (elia_groupe_cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPShopEliaCell" owner:self options:nil];
            elia_groupe_cell = [nib objectAtIndex:0];
        }
        
        //ショップ用セル設定
        shop_cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (shop_cell == nil) {
            
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPShopCell" owner:self options:nil];
            shop_cell = [nib objectAtIndex:0];
        }
        
        // ハイライトなし
        elia_groupe_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        shop_cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        //セル上部のライン表示切り替え
        [shop_cell.imgUpLine setHidden:YES];
        
        if(row == 0){

            [elia_groupe_cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            NSString* str_ShopName = [ary_elias_groupe objectAtIndex:indexPath.section];
//            NSLog(@"%@",str_ShopName);

            NSMutableArray* ary_groupeItems = [arr_eliaShop objectAtIndex:indexPath.section];
            NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];
            
            [elia_groupe_cell.titleShop setText:[NSString stringWithFormat:@"%@ （ %ld ）", str_ShopName, (long)ary_shopItems.count]];
            
            //セル上部のライン表示切り替え
            if(indexPath.section == 0){
                
                [elia_groupe_cell.imgUpLine setHidden:NO];
            }else{
                
                [elia_groupe_cell.imgUpLine setHidden:YES];
            }
            
            //オープン・クローズの状態画像変更
            if(subItems.extended == NO){

                [elia_groupe_cell.view_back setBackgroundColor:[UIColor clearColor]];
                
                UIImage *image = [UIImage imageNamed:@"idicator_close.png"];
                [elia_groupe_cell.imgCursol setImage:image];
            }else{

                [elia_groupe_cell.view_back setBackgroundColor:[UIColor lightGrayColor]];
                
                UIImage *image = [UIImage imageNamed:@"idicator_open.png"];
                [elia_groupe_cell.imgCursol setImage:image];
            }
            
            return elia_groupe_cell;
            
        }else{
            
            NSMutableArray* ary_groupeItems = [arr_eliaShop objectAtIndex:indexPath.section];
            NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];
            NSString* strText = [[ary_shopItems valueForKey:@"shop_name"] objectAtIndex:indexPath.row-1];
            
            [shop_cell.titleShop setText:strText];

            NSString* strListCGUrl = [[ary_shopItems valueForKey:@"thumbnail"] objectAtIndex:indexPath.row-1];
            if(![strListCGUrl isEqual:[NSNull null]] && [strListCGUrl length] > 0){
                
                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                shop_cell.imageView.image = nil;
                dispatch_async(q_global, ^{
                    NSString *imageURL = [NSString stringWithFormat:BASE_PREFIX_URL,strListCGUrl];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
                    
                    dispatch_async(q_main, ^{
                        shop_cell.shopImage.image = image;
                        [shop_cell layoutSubviews];
                    });
                });
            }else{
                
                UIImage *image = nil;
                image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
                [shop_cell.shopImage setBackgroundColor:[UIColor whiteColor]];
                [shop_cell.shopImage setImage:image];
            }
            
            return shop_cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == _myshop_tableView){
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        MPShopDetailViewController *shopDetailVC = [[MPShopDetailViewController alloc] initWithNibName:@"MPShopDetailViewController" bundle:nil];

        NSMutableArray* ary_groupeItems = [arr_myShop objectAtIndex:indexPath.row];
        NSString* strID = [ary_groupeItems valueForKey:@"shop_id"];
        shopDetailVC.shopId = strID;
        [self.navigationController pushViewController:shopDetailVC animated:YES];
    }
    
    if(tableView == _elia_tableView){
        
        NSInteger section = indexPath.section;
        NSInteger row =indexPath.row;
        
        if(row == 0){
            
            NSMutableArray *subItems;
            subItems = arr_eliaShop[(NSUInteger) section];
            
            subItems.extended = !subItems.extended;
            if(subItems.extended == NO){
                
                [self collapseSubItemsAtIndex:row+1 maxRow:[subItems count]+1 section:section];
                [_elia_tableView reloadData];
            }else{
                
                [self expandItemAtIndex:row+1 maxRow:[subItems count]+1 section:section];
                [_elia_tableView reloadData];
            }
        }else{
            
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            MPShopDetailViewController *shopDetailVC = [[MPShopDetailViewController alloc] initWithNibName:@"MPShopDetailViewController" bundle:nil];
            
            NSMutableArray* ary_groupeItems = [arr_eliaShop objectAtIndex:indexPath.section];
            NSMutableArray* ary_shopItems = [ary_groupeItems objectAtIndex:0];
            NSString* strID = [[ary_shopItems valueForKey:@"id"] objectAtIndex:indexPath.row-1];
            shopDetailVC.shopId = strID;
            [self.navigationController pushViewController:shopDetailVC animated:YES];
        }
    }
}

// 縮小アニメーション
- (void)collapseSubItemsAtIndex:(int)firstRow maxRow:(int)maxRow section:(int)section {
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for(int i=firstRow;i<maxRow;i++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    [_elia_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}
//拡張アニメーション
- (void)expandItemAtIndex:(int)firstRow maxRow:(int)maxRow section:(int)section {
    
    NSMutableArray *indexPaths = [NSMutableArray new];
    for(int i=firstRow;i<maxRow;i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    [_elia_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    // ヘッダー表示できるように更新
    [_elia_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:firstRow - 1 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)resizeTable {
    
    //テーブル高さをセルの最大値へセット
    _myshop_tableView.frame = CGRectMake(10, _myshop_tableView.frame.origin.y, _myshop_tableView.frame.size.width, 0);
    _myshop_tableView.frame =
    CGRectMake(_myshop_tableView.frame.origin.x,
               _myshop_tableView.frame.origin.y,
               _myshop_tableView.contentSize.width,
               MAX(_myshop_tableView.contentSize.height,
                   _myshop_tableView.bounds.size.height));
    
    _myshop_tableView.frame = CGRectMake(10, _myshop_tableView.frame.origin.y, _myshop_tableView.frame.size.width, _myshop_tableView.frame.size.height);

    //エリア用タイトル位置セット
    title2.frame = CGRectMake(15, _myshop_tableView.frame.origin.y + _myshop_tableView.frame.size.height + 5, cornerView.frame.size.width, 26);
    
    //エリアテーブル位置設定
    _elia_tableView.frame = CGRectMake(10, title2.frame.origin.y + title2.frame.size.height, _elia_tableView.frame.size.width, 0);
    _elia_tableView.frame =
    CGRectMake(_elia_tableView.frame.origin.x,
               _elia_tableView.frame.origin.y,
               _elia_tableView.contentSize.width,
               MAX(_elia_tableView.contentSize.height,
                   _elia_tableView.bounds.size.height));
    
    _elia_tableView.frame = CGRectMake(10, title2.frame.origin.y + title2.frame.size.height, _elia_tableView.frame.size.width, _elia_tableView.frame.size.height);

    // myshop有り無しでの表示切り替え
    [scr_inView setFrame:CGRectMake(0, 0, scr_inView.frame.size.width, _myshop_tableView.frame.size.height + title2.frame.size.height + _elia_tableView.frame.size.height + 30 + myShopTitle.frame.size.height + 10)];
    
    _scr_rootview.contentSize = scr_inView.bounds.size;
    
    CGRect screen_height = [[UIScreen mainScreen] bounds];
    if(screen_height.size.height < 568){
        
        _elia_tableView.frame = CGRectMake(0, title2.frame.origin.y + title2.frame.size.height, _elia_tableView.frame.size.width, _elia_tableView.frame.size.height - (568 - screen_height.size.height));
        
        //スクロール内のVIEW幅調整
        [scr_inView setFrame:CGRectMake(0, 0, scr_inView.frame.size.width,  _myshop_tableView.frame.size.height + title2.frame.size.height + _elia_tableView.frame.size.height + 30)];
        
        _scr_rootview.contentSize = scr_inView.bounds.size;
    }

    // 未登録時のメッセージ表示
    if(myShopNotSetInfo.hidden == NO){

        [scr_inView setFrame:CGRectMake(0, 0, scr_inView.frame.size.width, scr_inView.frame.size.height + 50)];

        _scr_rootview.contentSize = scr_inView.bounds.size;
    }
}

- (void)dealloc {
    
    arr_myShop = nil;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
