//
//  MPHomeMenuViewController.m
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPHomeMenuViewController.h"
#import "MPTabBarViewController.h"
#import "MPItemObject.h"
#import "MPMenuObject.h"
#import "CustomColor.h"

@interface MPHomeMenuViewController ()
@end

@implementation MPHomeMenuViewController

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
    
    //メニュー画像追加
    UIImage *img_toppics = [UIImage imageNamed:@"toppic02.png"];
    CGFloat cgrange_toppics = (cornerView.frame.size.width - 20) / img_toppics.size.width;
    
    iv_toppics = [[UIImageView alloc] initWithImage:img_toppics];
    iv_toppics.contentMode = UIViewContentModeScaleAspectFit;
    iv_toppics.frame = CGRectMake(15, 15, cornerView.frame.size.width - 30, img_toppics.size.height * cgrange_toppics);
    [cornerView addSubview:iv_toppics];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 15, cornerView.frame.size.width, 0) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = false;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cornerView addSubview:_tableView];
    
    UINib *nib = [UINib nibWithNibName:@"MPMenuGridCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"gridIdentifier"];
    [_tableView reloadData];
    
    UINib *nib1 = [UINib nibWithNibName:@"MPListCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:@"listIdentifier"];
    [_tableView reloadData];
    
    UINib *nib2 = [UINib nibWithNibName:@"MPPlanTextCell" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:@"planTextIdentifier"];
    [_tableView reloadData];
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
            [[ManagerDownload sharedInstance] getListMenu:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
            break;
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //🔵設定ボタン表示設定
    [self setHiddenSettingButton:NO];
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_COLLECTION:
        case DETAIL_LIST_TYPE_FAVORITE:
            [[ManagerDownload sharedInstance] getListLikedMenu:[Utility getDeviceID] withAppID:[Utility getAppID] delegate:self];
            break;
            
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)backButtonClicked:(UIButton *)sender {
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        case DETAIL_LIST_TYPE_COLLECTION:
        case DETAIL_LIST_TYPE_FAVORITE:
        {
            [self.navigationController popViewControllerAnimated:YES];
            [[MPTabBarViewController sharedInstance] setDisableHomeButton:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ManagerDownloadDelegate
- (void)downloadDataSuccess:(DownloadParam *)param {
    
    switch (param.request_type) {
        case RequestType_GET_LIST_MENU:
        {
            listMenu = param.listData;
        }
            break;
            
        case RequestType_GET_LIST_LIKED_MENU:
        {
            listItem = param.listData;
            for (MPItemObject *item in listItem) {
                NSLog(@"%ld",(long)item.likedd);
            }
        }
            break;
            
        default:
            break;
    }
    [_tableView reloadData];
    
    [self resizeTable];
}

- (void)downloadDataFail:(DownloadParam *)param {
}

- (void)setType:(DETAIL_LIST_TYPE)type {
    
    detailType = type;
}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
        {
            if (listMenu.count > 0) {
                MPMenuObject *menuObj = [listMenu objectAtIndex:section];
                style = menuObj.style;
                switch (menuObj.style) {
                        
                    case STYLE_FORMAT_MENU_TYPE_Grid:
                    {
                        
                        return 1;
                    }
                        
                        break;
                        
                    case STYLE_FORMAT_MENU_TYPE_List:
                        if (menuObj.item.count > 0) {
                            return menuObj.item.count;
                        }else{
                            return 1;
                        }
                        
                        break;
                        
                    case STYLE_FORMAT_MENU_TYPE_Plantext:
                        if (menuObj.item.count > 0) {
                            return menuObj.item.count;
                        }else{
                            return 1;
                        }
                        break;
                        
                    default:
                        break;
                }
                return 1;
            }
        }
            break;
            
        case DETAIL_LIST_TYPE_FAVORITE:
        case DETAIL_LIST_TYPE_COLLECTION:
        default:
            break;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
            if (listMenu.count > 0) {
                return listMenu.count;
            }else{
                return 1;
            }
            break;
            
        case DETAIL_LIST_TYPE_FAVORITE:
        case DETAIL_LIST_TYPE_COLLECTION:
            return 1;
        default:
            break;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (countTemp < 2) {
        if (listMenu.count > 0 || listItem.count > 0) {
            [tableView reloadData];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
        {
            if (listMenu.count > 0 ) {
                MPMenuObject *menuObj = [listMenu objectAtIndex:indexPath.section];
                switch (menuObj.style) {
                        
                    case STYLE_FORMAT_MENU_TYPE_Grid:
                        countTemp = 3;
                        if (menuObj.item.count > 0) {
                            return [MPMenuGridCell heightForRow:menuObj.item];
                        }
                        
                        break;
                        
                    case STYLE_FORMAT_MENU_TYPE_List:
                        countTemp = 3;
                        return 103;
                        break;
                        
                    case STYLE_FORMAT_MENU_TYPE_Plantext:
                        
                        //variable count for reload tableview
                        countTemp ++;
                        return [MPPlanTextCell heightForRow:[menuObj.item objectAtIndex:indexPath.row]];
                        break;
                        
                    default:
                        break;
                }
            }else{
                return 50;
            }
        }
            break;
            
        case DETAIL_LIST_TYPE_FAVORITE:
        case DETAIL_LIST_TYPE_COLLECTION:
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
        {
            if (listMenu.count > 0) {
                MPMenuObject *menuObj = [listMenu objectAtIndex:section];
                if (menuObj.item.count > 0) {
                    return 32;
                }
            }
            
        }
            break;
            
        case DETAIL_LIST_TYPE_FAVORITE:
        case DETAIL_LIST_TYPE_COLLECTION:
            return 0;
            
        default:
            break;
    }
    
    return 0;
}

//セクションヘッド設定
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 32)];
    [view setBackgroundColor:[UIColor colorWithRed:241/255.0 green:160/255.0 blue:1/255.0 alpha:1.0]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    [label setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    
    MPMenuObject *menuObj = [listMenu objectAtIndex:section];
    [label setText:menuObj.category];
    
    CGRect labelFrame = label.frame;
    labelFrame.origin.x = 10;
    labelFrame.size.height = 32;
    labelFrame.origin.y = (view.frame.size.height - labelFrame.size.height) / 2;
    [label setBackgroundColor:[UIColor clearColor]];
    label.frame = labelFrame;
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (listMenu.count > 0 ) {
        MPMenuObject *menuObj = [listMenu objectAtIndex:section];
        if (menuObj.item.count > 0 ) {
            return 0.1;
        }
    }
    
    return 0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:LINE_OF_APP]];
    [view setBackgroundColor:[UIColor clearColor]];
    
    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![MPAppDelegate sharedMPAppDelegate].networkStatus) {
        static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
            [cell setUserInteractionEnabled:NO];
        }
        switch (detailType) {
            case DETAIL_LIST_TYPE_MENU:
            case DETAIL_LIST_TYPE_MIXED:
                [cell.textLabel setText:NO_LIST_MENU_MESSAGE];
                
                break;
                
            case DETAIL_LIST_TYPE_COLLECTION:
                [cell.textLabel setText:NO_MY_COLLECTION_MESSAGE];
                
                break;
                
            case DETAIL_LIST_TYPE_FAVORITE:
                [cell.textLabel setText:NO_FAVORITE_MESSAGE];
                break;
                
            default:
                break;
        }
        
        return cell;
        
    }
    
    switch (detailType) {
        case DETAIL_LIST_TYPE_MENU:
        case DETAIL_LIST_TYPE_MIXED:
        {
            if (listMenu.count > 0) {
                MPMenuObject *menuObj = [listMenu objectAtIndex:indexPath.section];
                switch (menuObj.style) {
                    case STYLE_FORMAT_MENU_TYPE_Grid:
                    {
                        MPMenuGridCell *cell = nil;
                        if (cell == nil) {
                            
                            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MPMenuGridCell" owner:self options:nil];
                            
                            for (id currentObject in topLevelObjects){
                                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                                    cell = (MPMenuGridCell *) currentObject;
                                    break;
                                }
                            }
                        }
                        
                        [cell setData:menuObj.item];
                        cell.delegate = self;
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                    }
                        break;
                    case STYLE_FORMAT_MENU_TYPE_List:
                    {
                        MPListCell *cell = nil;
                        if (cell == nil) {
                            
                            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MPListCell" owner:self options:nil];
                            
                            for (id currentObject in topLevelObjects){
                                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                                    cell = (MPListCell *) currentObject;
                                    break;
                                }
                            }
                        }
                        
                        [cell setData:[menuObj.item objectAtIndex:indexPath.row]];
                        return cell;
                    }
                        break;
                        
                    case STYLE_FORMAT_MENU_TYPE_Plantext:
                    {
                        MPPlanTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"planTextIdentifier"];
                        [cell setData:[menuObj.item objectAtIndex:indexPath.row]];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                    }
                        break;
                        
                    default:
                        break;
                }
            }else{
                static NSString *cellIdentifier = @"cellIdentifier";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    [cell setBackgroundColor:[UIColor clearColor]];
                    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:10]];
                    [cell setUserInteractionEnabled:NO];
                }
                if (listMenu) {
                    switch (detailType) {
                        case DETAIL_LIST_TYPE_MENU:
                        case DETAIL_LIST_TYPE_MIXED:
                            if (listMenu) {
                                [cell.textLabel setText:NO_LIST_MENU_MESSAGE];
                            }
                            
                            break;
                            
                        case DETAIL_LIST_TYPE_COLLECTION:
                            if (listMenu) {
                                [cell.textLabel setText:NO_MY_COLLECTION_MESSAGE];
                            }
                            
                            break;
                            
                        default:
                            break;
                    }
                }
                
                return cell;
            }
        }
            break;
            
        case DETAIL_LIST_TYPE_FAVORITE:
        case DETAIL_LIST_TYPE_COLLECTION:
        default:
            break;
    }
    
    return nil;
}

- (void)resizeTable {

    //テーブル高さをセルの最大値へセット
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 0);
    _tableView.frame =
    CGRectMake(_tableView.frame.origin.x,
               _tableView.frame.origin.y,
               _tableView.contentSize.width,
               MAX(_tableView.contentSize.height,
                   _tableView.bounds.size.height));
    
    //スクロール内のVIEW幅調整
    [scr_inView setFrame:CGRectMake(scr_inView.frame.origin.x, scr_inView.frame.origin.y, scr_inView.frame.size.width, iv_toppics.frame.origin.y + iv_toppics.frame.size.height + 15 + _tableView.frame.size.height + 15 + 8)];
    
    //スクロール幅再設定
    _scr_rootview.contentSize = scr_inView.bounds.size;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (style) {
            
        case STYLE_FORMAT_MENU_TYPE_Grid:
        {
            
        }
            
            break;
            
        case STYLE_FORMAT_MENU_TYPE_List:
        {
            switch (detailType) {
                case DETAIL_LIST_TYPE_MENU:
                case DETAIL_LIST_TYPE_MIXED:
                {
                    MPMenuObject *menuObj = [listMenu objectAtIndex:indexPath.section];
                    MPHomeMenuDetailViewController *menuDetailVC = [[MPHomeMenuDetailViewController alloc] initWithNibName:@"MPHomeMenuDetailViewController" bundle:nil];
                    [menuDetailVC setData:[menuObj.item objectAtIndex:indexPath.row] withType:detailType withRecommendType:NO];
                    [self.navigationController pushViewController:menuDetailVC animated:YES];
                }
                    break;
                    
                case DETAIL_LIST_TYPE_FAVORITE:
                case DETAIL_LIST_TYPE_COLLECTION:
                {
                    
                    MPHomeMenuDetailViewController *menuDetailVC = [[MPHomeMenuDetailViewController alloc] initWithNibName:@"MPHomeMenuDetailViewController" bundle:nil];
                    [menuDetailVC setData:[listItem objectAtIndex:indexPath.row] withType:detailType withRecommendType:NO];
                    [self.navigationController pushViewController:menuDetailVC animated:YES];
                }
                default:
                    break;
            }
            
        }
            break;
            
        case STYLE_FORMAT_MENU_TYPE_Plantext:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - MPMenuGridCellDelegate
- (void)selectProduct:(MPItemObject *)item {
    
    MPHomeMenuDetailViewController *menuDetailVC = [[MPHomeMenuDetailViewController alloc] initWithNibName:@"MPHomeMenuDetailViewController" bundle:nil];
    [menuDetailVC setData:item withType:detailType withRecommendType:NO];
    [self.navigationController pushViewController:menuDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



@end
