//
//  MPSettingAlertView.m
//  Misepuri
//
//  Created by M.ama on 26/10/27.
//  Copyright (c) 2016 Akafune All rights reserved.
//

#import "MPSettingAlertView.h"

@implementation MPSettingAlertView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3f]];
}

- (IBAction)okButtonClicked:(UIButton *)sender {
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(setUserData)]) {
        [self.delegate setUserData];
    }
}

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    
    [self removeFromSuperview];
}

@end
