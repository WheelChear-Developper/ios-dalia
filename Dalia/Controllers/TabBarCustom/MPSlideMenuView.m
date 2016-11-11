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

    return 5;
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

    //        [cell setData:[self.listObject objectAtIndex:indexPath.row]];
//    cell.backgroundColor = [UIColor clearColor];
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     MPNewDetailViewController *newDetailVC = [[MPNewDetailViewController alloc] initWithNibName:@"MPNewDetailViewController" bundle:nil];
     [newDetailVC setData:[self.listObject objectAtIndex:indexPath.row]];
     [self.navigationController pushViewController:newDetailVC animated:YES];
     */
}


@end

