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

    //サイドメニュー情報をplistから読み込み
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"UIConfig" ofType:@"plist"];
    NSDictionary* dic = [NSDictionary dictionaryWithContentsOfFile:path];
    _ary_menuData =[NSArray arrayWithArray:[dic objectForKey:@"SideMenuType"]];
}

//画面のスタンプViewを追加
- (void)setUpView:(MPCouponObject*)object {

}

#pragma mark - UITableViewDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _ary_menuData.count;
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

    //1.ホーム
    //2.メンバーズカード
    //3.リサーブ
    //4.ポイント
    //5.WhatNew
    //6.オンラインショップ
    //7.クーポン
    //8.メニュー
    //9.アクセス
    //10.設定
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

