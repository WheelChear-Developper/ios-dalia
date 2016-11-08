//
//  MPCouponDetailCell.m
//  Misepuri
//
//  Created by TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPCouponDetailCell.h"

#define HEIGHT_BONUS 20

@implementation MPCouponDetailCell

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

- (void)setData:(MPCouponObject *)object {
        
    couponObj = object;

    // INSERTED BY M.ama 2016.10.25 START
    // 画像取得
    //非同期画像セット
    if (![couponObj.coupon_image isEqualToString:@""]) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,couponObj.coupon_image]];
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
    
    [titleCoupon setText:couponObj.coupon_name];
    NSLog(@"%@",couponObj.due_date);
    if (couponObj.is_due_date == 0) {
       [dueDateCouponLabel setText:@"無期限"];
    }else{
        [dueDateCouponLabel setText:[Utility dateDisplayedOnUI:couponObj.due_date]];
    }
    
    [contentCouponLabel setText:couponObj.condition];
    /*
    CGSize conditionSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:175 value:object.condition];
    CGRect conditionFrame = contentCouponLabel.frame;
    conditionFrame.size.height = conditionSize.height + HEIGHT_BONUS;
    contentCouponLabel.frame = conditionFrame;
    
    if (!couponObj.condition) {
        conditionSize.height = 10;
    }
    CGRect backgroundFrame = imageBg.frame;
    backgroundFrame.size.height += conditionSize.height - HEIGHT_BONUS*3;
    imageBg.frame = backgroundFrame;
    
    CGRect smallBackgroundFrame = imageSmall.frame;
    smallBackgroundFrame.size.height += conditionSize.height - HEIGHT_BONUS*3;
    imageSmall.frame = smallBackgroundFrame;
    
    //edited by tuyenbq 19/01/2014
    [imageSmall.layer setCornerRadius:5.0f];
    
    CGRect bottomImageSmallFrame = bottomImageSmall.frame;
    bottomImageSmallFrame.origin.y = backgroundFrame.origin.y + backgroundFrame.size.height;
    bottomImageSmall.frame = bottomImageSmallFrame;
*/
    //発行日の設定
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    // INSERTED BY M.ama 2016.10.25 START
    // 時間追加
    [df setDateFormat:@"yyyy年M月d日 HH時mm分"];
    // INSERTED BY M.ama 2016.10.25 END
    NSDate *now = [NSDate date];
    lbl_fromtodate.textAlignment = NSTextAlignmentLeft;
    lbl_fromtodate.textColor = [UIColor whiteColor];
    [lbl_fromtodate setFont:[UIFont fontWithName:FONT_TITLE_APP size:FONT_SIZE_TITLE_APP]];
    lbl_fromtodate.text = [NSString stringWithFormat:@"※ %@ 発行", [df stringFromDate:now]];
}

+ (CGFloat)heightForRow:(MPCouponObject *)object {
    
    CGSize conditionSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:175 value:object.condition];
    if (!object.condition) {
        conditionSize.height = 10;
    }
    return conditionSize.height + 190;
}

@end
