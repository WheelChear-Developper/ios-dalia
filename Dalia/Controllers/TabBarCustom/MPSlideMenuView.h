//
//  MPSlideMenuView.h
//  shopapp
//
//  Created by M.Amatani on 2016/11/07.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerDownload.h"

@protocol MPSlideMenuViewDelegate<NSObject>

@end

@interface MPSlideMenuView : UIView <ManagerDownloadDelegate>
{
IBOutlet UIView *slideMenuView;
    
}
@property (nonatomic, assign) id<MPSlideMenuViewDelegate> delegate;

@end
