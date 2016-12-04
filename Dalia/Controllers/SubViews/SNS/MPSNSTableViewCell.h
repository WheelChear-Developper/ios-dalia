//
//  MPSNSTableViewCell.h
//  Dalia
//
//  Created by M.Amatani on 2016/12/04.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPSNSTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img_photo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_head;
@property (weak, nonatomic) IBOutlet UILabel *lbl_comment;

@end
