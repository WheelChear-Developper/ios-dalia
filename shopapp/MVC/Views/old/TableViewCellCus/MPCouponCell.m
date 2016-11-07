//
//  MPCouponCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponCell.h"

#define HEIGHT_NORMAL 118
#define HEIGHT_BONUS 50
#define Y_ORGIN_BONUS_WHEN_CONDITION_NULL 140

@implementation MPCouponCell

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

- (void)setData:(MPCouponObject*)object {
    
    couponObject = object;

    // INSERTED BY M.ama 2016.10.25 START
    // 画像取得
    //非同期画像セット
    if (![couponObject.coupon_image isEqualToString:@""]) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,couponObject.coupon_image]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];

        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   UIImage *image = nil;
                                   if (!error){
                                       image = [[UIImage alloc] initWithData:data];
                                       // do whatever you want with image
                                   }else{
                                       image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
                                   }
                                   [img_photo setImage:image];
                               }];
    }else{
        [img_photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }
    // INSERTED BY M.ama 2016.10.25 END

    [couponNameLabel setText:couponObject.coupon_name];
    
    if (couponObject.is_due_date == 0) {
        [dueDateValueLabel setText:@"無期限"];// format date
        [numberUsingLabel setText:@"何回でも利用可"];
    }else{
        //[dueDateValueLabel setText:couponObject.due_date];
        
        [dueDateValueLabel setText:[Utility dateDisplayedOnUI:couponObject.due_date]];
    }
    
    [conditionValueLabel setText:couponObject.condition];
    
    if (couponObject.limit_num <= 0) {
        [numberUsingLabel setText:@"何回でも利用可"];
    }else{
        [numberUsingLabel setText:[NSString stringWithFormat:@"残り%ld回",(long)couponObject.limit_num]];
    }
}

+ (CGFloat)heightForRow:(MPCouponObject*)object {
    
    CGSize conditionSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:162 value:object.condition];
    float height = (HEIGHT_NORMAL + conditionSize.height);
    if (height < Y_ORGIN_BONUS_WHEN_CONDITION_NULL) {
        height = Y_ORGIN_BONUS_WHEN_CONDITION_NULL;
    }
    return height;
}

- (IBAction)useCouponButtonClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(useCoupon:)]) {
        [self.delegate useCoupon:couponObject];
    }
}

@end
