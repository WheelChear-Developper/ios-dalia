//
//  MPFirstSetting_gender_TableViewCell.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/30.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol MPFirstSetting_gender_TableViewCellDelegate<NSObject>
@end

@interface MPFirstSetting_gender_TableViewCell : UITableViewCell

@property (nonatomic) id<MPFirstSetting_gender_TableViewCellDelegate> delegate;

@property (nonatomic) long IndexPathRow;

@property (nonatomic) BOOL fld_essential;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_field;

@end
