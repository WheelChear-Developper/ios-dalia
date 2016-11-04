//
//  MPCouponShareCell.m
//  Misepuri
//
//  Created by TUYENBQ on 12/10/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponShareCell.h"
#import "CustomColor.h"
#import "MPUIConfigObject.h"

@implementation MPCouponShareCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib {

    [super awakeFromNib];
    
    [self setUpView];
}

- (void)setUpView {
    
    [nameCouponLabel setTextColor:[UIColor colorWithHexString:[[[[(MPUIConfigObject*)[MPUIConfigObject sharedInstance] objectAfterParsedPlistFile:[Utility getPatternType]] tab1] objectForKey:@"Function4"] objectForKey:@"textColor"]]];
}

- (void)setData:(MPCouponObject*)object {
    
    [nameCouponLabel setText:object.coupon_name];
    
    if (object.limit_date == 0) {
        [dueDateLabel setText:@"無期限"];
    }else{
        if (object.limit_num == 0) {
            [dueDateLabel setText:@"何回でも利用可"];
        }else{
            [dueDateLabel setText:[NSString stringWithFormat:@"発行から%ld日間",(long)object.limit_date]];
        }
    }
    
    [conditionLabel setText:object.condition];
    
    CGSize coditionSize = [Utility sizeWithFont:[UIFont systemFontOfSize:11] width:213 value:object.condition];
    CGRect conditionFrame = conditionLabel.frame;
    conditionFrame.size.height = coditionSize.height;
    conditionLabel.frame = conditionFrame;
    
    
    CGRect indicatorFrame = indicatorView.frame;
    indicatorFrame.origin.y = (coditionSize.height + 100 - indicatorFrame.size.height)/2;
    indicatorView.frame = indicatorFrame;
    
    CGRect lineViewFrame = lineView.frame;
    lineViewFrame.origin.y = conditionLabel.frame.origin.y + coditionSize.height +5;
    lineView.frame = lineViewFrame;
}

+ (CGFloat)heightForRow:(MPCouponObject*)object {
    
    CGSize coditionSize = [Utility sizeWithFont:[UIFont systemFontOfSize:11] width:213 value:object.condition];
    return (coditionSize.height + 105);
}

@end
