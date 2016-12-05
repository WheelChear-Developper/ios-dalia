//
//  TheFifth_nick_name_TableViewCell.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/30.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol TheFifth_nick_name_TableViewCellDelegate<NSObject>
@end

@interface TheFifth_nick_name_TableViewCell : UITableViewCell

@property (nonatomic) id<TheFifth_nick_name_TableViewCellDelegate> delegate;

@property (nonatomic) long IndexPathRow;

@property (nonatomic) BOOL fld_essential;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_field;

@end
