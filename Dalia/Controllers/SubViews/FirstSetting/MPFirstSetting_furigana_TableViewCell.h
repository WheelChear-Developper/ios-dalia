//
//  MPFirstSetting_furigana_TableViewCell.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/30.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol MPFirstSetting_furigana_TableViewCellDelegate<NSObject>
@end

@interface MPFirstSetting_furigana_TableViewCell : UITableViewCell

@property (nonatomic) id<MPFirstSetting_furigana_TableViewCellDelegate> delegate;

@property (nonatomic) long IndexPathRow;

@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_field1;
@property (weak, nonatomic) IBOutlet UITextField *txt_field2;

@end
