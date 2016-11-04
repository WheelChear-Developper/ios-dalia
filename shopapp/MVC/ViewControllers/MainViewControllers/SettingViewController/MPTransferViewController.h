//
//  MPTransferViewController.h
//  
//
//  Created by Fujii-iMac on 2015/12/12.
//
//

#import "MPBaseViewController.h"

@interface MPTransferViewController : MPBaseViewController<ManagerDownloadDelegate, UITextFieldDelegate>
{
    CGPoint cgpoint_tf;
    UIKeyboardType kb_type;
    NSString* transfer_code;
}
@property (strong, nonatomic) IBOutlet UIScrollView *baseView;
@property (strong, nonatomic) IBOutlet UILabel *labelTransferCode;
@property (strong, nonatomic) IBOutlet UITextField *activeTextFeild;
@property (strong, nonatomic) IBOutlet UIView *inputView;
@property (strong, nonatomic) IBOutlet UIButton *btnTransfer;
@property (strong, nonatomic) IBOutlet UITextField *textTransferCode;

@end
