//
//  MPTheThirdViewController.h
//  Misepuri
//
//  Created by TUYENBQ on 11/25/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
// INSERT BY ama 2016.10.05 START
// Bluetooth設定確認
#import <CoreBluetooth/CoreBluetooth.h>
// INSERT BY ama 2016.10.05 END
#import "MPBaseViewController.h"
#import "MPCouponStampView.h"

@interface MPTheThirdViewController : MPBaseViewController <ManagerDownloadDelegate, MPCouponStampViewDelegate, UIScrollViewDelegate, CBCentralManagerDelegate>
{
    // INSERT BY ama 2016.10.08 START
    // 土台設定修正
    MPCouponStampView *couponStampView;
    // INSERT BY ama 2016.10.08 END
    // INSERT BY ama 2016.10.05 START
    // Bluetooth設定確認
    CBCentralManager* bluetoothManager;
    // INSERT BY ama 2016.10.05 END
    // INSERT BY M.ama 2016.10.26 START
    // 説明の更新
    __weak IBOutlet UILabel *lbl_Infomation;
    // INSERT BY M.ama 2016.10.26 END

    // INSERTED BY M.ama 2016.10.27 START
    // スタンプ無効時の表示
    IBOutlet UIScrollView* scr_rootview;
    IBOutlet UIView *scr_inView;
    IBOutlet UIView *cornerView;
    // INSERTED BY M.ama 2016.10.27 END
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_recipe;
@property (weak, nonatomic) IBOutlet UIView *view_stamp;
// INSERTED BY ama 2016.10.05 START
// ランクカラー設定
@property (weak, nonatomic) IBOutlet UIView *view_IdBackColor;
// INSERTED BY ama 2016.10.05 END

// INSERTED BY M.ama 2016.10.08 START
// クーポン件数取得用更新
- (void)setArertCurpon:(NSString*)no;
// INSERT BY M.ama 2016.10.08 END

@end
