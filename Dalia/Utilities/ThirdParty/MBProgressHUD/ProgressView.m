//
//  ProgressView.m
//  MakeUpApp
//
//  Created by TUYENBQ on 7/30/13.
//  Copyright (c) 2013 tvo. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView
+ (ProgressView *)sharedInstance
{
    static ProgressView *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[ProgressView alloc] init];
            
        }
    });
    
    
    return sharedInstance;
}
#pragma mark - ProgressBar
//create progress with title label
- (void) loadedImage
{
    float progress = 0.0f;
    while (progress < 1.0f) {
        
        progress += 0.1f;
        HUD.progress = progress;
        usleep(900000000);
        
    }
    
}

//initial progress
- (void) progressWithTitle: (NSString*) title andView: (UIView*) view andDelegate: (NSObject<MBProgressHUDDelegate>*) delegate
{
    if (!is_Show) {
        // REPLACED BY M.FUJII 2015.12.12 START
        // 電子スタンプ対応
        //if (!is_Show) {
        if (!is_Show && !HUD) {
            // REPLACED BY M.FUJII 2015.12.12 END
            [HUD removeFromSuperview];
        }
        HUD  = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        HUD.delegate = delegate;
        HUD.labelText = title;
        HUD.mode = MBProgressHUDModeIndeterminate;
        [HUD showWhileExecuting:@selector(loadedImage) onTarget:self withObject:nil animated:YES];
        is_Show = YES;
    }
    
}
- (UIView *)getHubView{
    return HUD;
}
- (void)removeHUD
{
    is_Show = NO;
    [HUD removeFromSuperview];
    // INSERTED BY M.FUJII 2015.12.12 START
    // 電子スタンプ対応
    HUD = nil;
    // INSERTED BY M.FUJII 2015.12.12 END
}
@end
