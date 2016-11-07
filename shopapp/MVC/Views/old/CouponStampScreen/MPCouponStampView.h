//
//  MPCouponStampView.h
//  Misepuri
//
//  Created by TUYENBQ on 12/9/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerDownload.h"
#import "MPConfirmView.h"

@protocol MPCouponStampViewDelegate<NSObject>
- (void)backToCouponTab;
- (void)getCurponButtonClicked:(long)No;
- (void)setUserIDColor:(NSString*)colorNo;
// REPLACED BY M.ama 2016.10.08 START
// クーポン件数取得用更新
- (void)setArertCurpon:(NSString*)no;
// REPLACED BY M.ama 2016.10.08 END

// INSERTED BY M.ama 2016.10.13 START
// 手入力時のエラー表示
- (void)arert_StampErr;
// INSERTED BY M.ama 2016.10.13 END
// INSERT BY ama 2016.10.26 START
// 説明の更新
- (void)setInfomation:(NSString*)comment;
// INSERT BY ama 2016.10.26 END

// INSERTED BY M.ama 2016.10.27 START
// 複数スタンプ選択更新
- (void)arert_AllStamp:(NSString*)strFromInt UUID:(NSString*)uuid;
// INSERTED BY M.ama 2016.10.27 END

// INSERTED BY M.ama 2016.10.27 START
// スタンプない場合の表示
-(void)setNotStampForm;
// INSERTED BY M.ama 2016.10.27 END

@end

@interface MPCouponStampView : UIView<ManagerDownloadDelegate, MPConfirmViewDelegate>
{
    IBOutlet UIView *stampView;
    
    MPCouponObject *couponObject;
    long stampCount;
    // INSERTED BY ama 2016.10.04 START
    //スタンプ数保持用
    long numberStampSelected;
    // INSERTED BY ama 2016.10.04 END
}
@property (nonatomic, assign) id<MPCouponStampViewDelegate> delegate;

// INSERTED BY M.ama 2016.10.27 START
// 複数スタンプ選択更新
-(void)setTotalStamp:(NSString*)uuid;
// INSERTED BY M.ama 2016.10.27 END

@end
