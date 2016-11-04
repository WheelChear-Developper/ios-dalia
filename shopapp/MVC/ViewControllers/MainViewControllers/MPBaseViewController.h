//
//  MPBaseViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ElevenFunctionType) {
    ElevenFunctionType_1 = 1, //Recommended product
    ElevenFunctionType_2,     //Visiting-shop stamp
    ElevenFunctionType_3,     //WEBSiteLink
    ElevenFunctionType_4,     //Social network(FB + TW)
    ElevenFunctionType_5,     //
    ElevenFunctionType_6,     //
    ElevenFunctionType_7,     //
    ElevenFunctionType_8,     //
    ElevenFunctionType_9,     //
    ElevenFunctionType_10,    //
    ElevenFunctionType_11,    //Video channel
    ElevenFunctionType_12
};
@interface MPBaseViewController : UIViewController
{
    UIImageView *navigationView;
    UIView *contentView;
    UIButton *backButton;
    
    // REPLACED BY M.ama 2016.10.08 START
    // 設定ボタン設置
    UIImageView *iv_config;
    UIButton *btn_setting;
    // REPLACED BY M.ama 2016.10.08 END
}

- (void)getTaskWithFunctions:(ElevenFunctionType)type;
- (void)backButtonClicked:(UIButton*)sender;
- (void)setHiddenBackButton:(BOOL)isHidden;
// REPLACED BY M.ama 2016.10.08 START
// 設定ボタン設置
- (void)setHiddenSettingButton:(BOOL)isEnable;
// REPLACED BY M.ama 2016.10.08 END

@end
