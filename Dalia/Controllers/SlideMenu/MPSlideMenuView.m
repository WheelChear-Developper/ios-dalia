//
//  MPSlideMenuView.m
//  shopapp
//
//  Created by M.Amatani on 2016/11/07.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPSlideMenuView.h"

@implementation MPSlideMenuView

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {

    [super awakeFromNib];

}

#pragma mark - ManagerDownloadDelegateƒ
- (void)downloadDataSuccess:(DownloadParam *)param {


}

- (void)downloadDataFail:(DownloadParam *)param {
}

//画面のスタンプViewを追加
- (void)setUpView:(MPCouponObject*)object {

}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MPSlideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SlideMenuCellIdentifier"];
    if(cell == nil){

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MPSlideMenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    _ary_menuData = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];

    long lng_ch = [[_ary_menuData objectAtIndex:indexPath.row] integerValue];
    switch (lng_ch) {
        case 1:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_home.png"];

            break;
        case 2:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_memberscard.png"];

            break;
        case 3:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_reserve.png"];

            break;
        case 4:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_point.png"];

            break;
        case 5:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_whatsnew.png"];

            break;
        case 6:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_onlineshop.png"];

            break;
        case 7:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_coupon.png"];

            break;
        case 8:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_menu.png"];

            break;
        case 9:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_access.png"];

            break;
        case 10:
            cell.img_menu.image = [UIImage imageNamed:@"sidemenu_setting.png"];

            break;

        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //メニュー指定
    long menuNo = [[_ary_menuData objectAtIndex:indexPath.row] integerValue];
    [self.delegate setNavigationSetView:menuNo];
}


@end

