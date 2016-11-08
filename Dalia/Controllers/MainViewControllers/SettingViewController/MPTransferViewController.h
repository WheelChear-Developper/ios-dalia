//
//  MPTransferViewController.h
//  
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"

@interface MPTransferViewController : MPBaseViewController<ManagerDownloadDelegate>
{
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;
}
@end
