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
    // INSERT BY ama 2016.10.31 START
    // キーボードアクション追加
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;
    // INSERT BY ama 2016.10.31 END
}
@end
