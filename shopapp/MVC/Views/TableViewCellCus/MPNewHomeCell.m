//
//  MPNewHomeCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPNewHomeCell.h"

@implementation MPNewHomeCell

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

- (void)setData:(MPNewHomeObject*)object {
    
    //非同期画像セット
    if (object.image) {
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
                                   [img_Photo setImage:image];
                               }];
    }else{
        [img_Photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }
    
    //時間設定
    if(object.update_at != nil){
        if(![object.update_at isEqualToString:@""]){
            NSArray *dateArr1 = [[[object.update_at componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"];
            NSArray *dateArr2 = [[[object.update_at componentsSeparatedByString:@" "] objectAtIndex:1] componentsSeparatedByString:@":"];
            [dateNewLabel setText:[NSString stringWithFormat:@"%@ 年 %@ 月 %@ 日（%@）%@ 時 %@ 分", [dateArr1 objectAtIndex:0], [dateArr1 objectAtIndex:1], [dateArr1 objectAtIndex:2], [self getWeekday:object.update_at], [dateArr2 objectAtIndex:0], [dateArr2 objectAtIndex:1]]];
        }
    }
    
    //タイトル設定
    [titleNewLabel setText:object.title];
    
    //メッセージ設定
    [lbl_Message setText:object.content];
    // REPLACED BY ama 2016.10.04 START
    //文字位置調整
    [txt_Message setText:object.content];
    // REPLACED BY ama 2016.10.04 END
    
    //NEW表示
    if (object.is_read == 0) {
        
        [newIcon setHidden:NO];
    }else{
        
        [newIcon setHidden:YES];
    }
    
    if (object.is_read == 0) {
        
        // REPLACED BY ama 2016.10.04 START
        //フォント更新
        [titleNewLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
        [lbl_Message setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
        [txt_Message setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
        // REPLACED BY ama 2016.10.04 END
    }else{

        // REPLACED BY ama 2016.10.04 START
        //フォント更新
        [titleNewLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        [lbl_Message setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        [txt_Message setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
        // REPLACED BY ama 2016.10.04 END
        
    }
    
    // INSERTED BY ama 2016.10.04 START
    // TEXTFIELDのマージンを０に設定
    txt_Message.textContainerInset = UIEdgeInsetsZero;
    txt_Message.textContainer.lineFragmentPadding = 0;
    // INSERTED BY ama 2016.10.04 END
}

//曜日取得
- (NSString*)getWeekday:(NSString*)dateString {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60 * 60 * 9]];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* comps = [calendar components:NSWeekdayCalendarUnit
                                          fromDate:[formatter dateFromString:dateString]];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    
    //comps.weekdayは 1-7の値が取得できるので-1する
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    
    return weekDayStr;
}

@end
