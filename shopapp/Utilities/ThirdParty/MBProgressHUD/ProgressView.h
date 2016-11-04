//
//  ProgressView.h
//  MakeUpApp
//
//  Created by TUYENBQ on 7/30/13.
//  Copyright (c) 2013 tvo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface ProgressView : NSObject
{
    MBProgressHUD *HUD;
    BOOL is_Show;
}
+(ProgressView*) sharedInstance;
- (void) loadedImage;
- (void) progressWithTitle: (NSString*) title andView: (UIView*) view andDelegate: (NSObject<MBProgressHUDDelegate>*) delegate;
- (void) removeHUD;
- (UIView *)getHubView;
@end
