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

@end

