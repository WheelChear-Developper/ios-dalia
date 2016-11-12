//
//  MPShopDetailCell.h
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/4/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPShopDetailCell : UITableViewCell

// INSERTED BY ama 2016.10.18 START
// ヘッダーVIEWの表示変更
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic) long lng_Height;
// INSERTED BY ama 2016.10.18 END

@end
