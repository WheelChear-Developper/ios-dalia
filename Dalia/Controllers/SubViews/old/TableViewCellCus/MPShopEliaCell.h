//
//  MPShopEliaCell.h
//  Misepuri
//
//  Created by ama
//

#import <UIKit/UIKit.h>

@interface MPShopEliaCell : UITableViewCell

// ▽ 2016年9月29日 リスト背景色変更
@property (weak, nonatomic) IBOutlet UIView *view_back;
// △ 2016年9月29日 リスト背景色変更
@property (strong, nonatomic) IBOutlet UILabel *titleShop;
@property (strong, nonatomic) IBOutlet UIImageView *imgUpLine;
@property (strong, nonatomic) IBOutlet UIImageView *imgCursol;

@end
