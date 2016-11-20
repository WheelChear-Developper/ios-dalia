//
//  MPTransferViewController.h
//  
//
//  Created by M.Amatani on 2016/11/02.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPBaseViewController.h"
#import "MPTabBarViewController.h"

@interface MPTransferViewController : MPBaseViewController<ManagerDownloadDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UIScrollView* _scr_rootview;
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;

    NSString* transfer_code;
}

//@property (strong, nonatomic) IBOutlet UIScrollView *baseView;
@property (strong, nonatomic) IBOutlet UILabel *labelTransferCode;
@property (strong, nonatomic) IBOutlet UITextField *activeTextFeild;
@property (strong, nonatomic) IBOutlet UIView *inputView;
@property (strong, nonatomic) IBOutlet UIButton *btnTransfer;
@property (strong, nonatomic) IBOutlet UITextField *textTransferCode;

@end
