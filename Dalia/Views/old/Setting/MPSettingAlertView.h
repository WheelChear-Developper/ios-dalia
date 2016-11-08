//
//  MPSettingAlertView.h
//  Misepuri
//
//  Created by M.ama on 26/10/27.
//  Copyright (c) 2016 Akafune All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPSettingAlertViewDelegate<NSObject>
-(void)setUserData;
@end

@interface MPSettingAlertView : UIView

@property (nonatomic, assign) id<MPSettingAlertViewDelegate> delegate;

@end
