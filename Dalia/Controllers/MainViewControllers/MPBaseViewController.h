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
    ElevenFunctionType_11,    //
    ElevenFunctionType_12
};

@interface MPBaseViewController : UIViewController
{
    float statusHeight;
    UIImageView *basic_navigationView;
    UIView *contentView;
    UIButton *backButton;
    UIImageView *iv_config;
    UIButton *btn_setting;
}
- (void)getTaskWithFunctions:(ElevenFunctionType)type;
- (void)backButtonClicked:(UIButton*)sender;
- (void)setHiddenBackButton:(BOOL)isHidden;
- (void)setHiddenSettingButton:(BOOL)isEnable;
- (void)setBasicNavigationHiden:(BOOL)isEnable;

@end
