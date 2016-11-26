//
//  MPMovieTableViewCell.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/26.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@interface MPMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_photo;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_love;

@end
