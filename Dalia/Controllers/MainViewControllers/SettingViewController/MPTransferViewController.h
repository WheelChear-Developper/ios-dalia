//
//  MPTransferViewController.h
//  
//
//  Created by Fujii-iMac on 2015/12/12.
//
//

#import "MPBaseViewController.h"

@interface MPTransferViewController : MPBaseViewController<ManagerDownloadDelegate>
{
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;
}
@end
