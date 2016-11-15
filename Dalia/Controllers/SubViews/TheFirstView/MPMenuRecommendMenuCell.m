//
//  MPMenuRecommendMenuCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenuRecommendMenuCell.h"

@implementation MPMenuRecommendMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setData:(MPMenuRecommend_menuObject*)object {
    
    //非同期画像セット
    if (![object.thumbnail isEqualToString:@""] && [object.thumbnail length] > 0) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,object.thumbnail]];
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
                                   [_img_Photo setImage:image];
                               }];
    }else{

        [_img_Photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }
    
    //時間設定
    if(object.updated_at != nil){
        if(![object.updated_at isEqualToString:@""]){
            NSArray *dateArr1 = [[[object.updated_at componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"];
            NSArray *dateArr2 = [[[object.updated_at componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"];
            [_dateNewLabel setText:[NSString stringWithFormat:@"%@ 年 %@ 月 %@ 日（%@）%@ 時 %@ 分", [dateArr1 objectAtIndex:0], [dateArr1 objectAtIndex:1], [dateArr1 objectAtIndex:2], [self getWeekday:object.updated_at], [dateArr2 objectAtIndex:0], [dateArr2 objectAtIndex:1]]];
        }
    }
    
    //タイトル設定
    [_titleLabel setText:object.title];
    
    //メッセージ設定
    [_lbl_Message setText:object.content];
}

//曜日取得
- (NSString*)getWeekday:(NSString*)dateString {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday
                                          fromDate:[formatter dateFromString:dateString]];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    
    //comps.weekdayは 1-7の値が取得できるので-1する
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    
    return weekDayStr;
}

@end
