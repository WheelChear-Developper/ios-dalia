//
//  MPBaseViewController.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "DeployGateSDK/DeployGateSDK.h"

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
//    UIImageView *_basic_navigationView;
    UIImageView *_basic_navigationIcon;
    UIView *_contentView;
    UIButton *_backButton;

    UIView* _view_custom_navigationView;
    UIImageView* _iv_custom_config;
    UIButton* _btn_custom_setting;

    float _statusHeight;
    
    UIImageView* _iv_custom_navigationIcon;
    UIView* _view_NaviFrame;
}
@property (nonatomic) UIImageView *basic_navigationView;

- (void)getTaskWithFunctions:(ElevenFunctionType)type;
- (void)backButtonClicked:(UIButton*)sender;
- (void)setHiddenBackButton:(BOOL)isHidden;

- (void)setImage_BasicNavigation:(UIImage*)image;
- (void)setFadeOut_BasicNavigation:(BOOL)isEnable;
- (void)setHidden_BasicNavigation:(BOOL)isEnable;

- (void)setCustomNavigaion;
- (void)setImage_CustomNavigation:(UIImage*)image;
- (void)setFadeOut_CustomNavigation:(BOOL)isEnable;
- (void)setHidden_CustomNavigation:(BOOL)isEnable;

@end
