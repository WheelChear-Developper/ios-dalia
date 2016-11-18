//
//  MPMenuNewCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 11/27/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPMenuNewsCell.h"

@implementation MPMenuNewsCell

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

- (void)setData:(MPMenuNewsObject*)object {
    
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
                                   [_img_Photo setImage:image];
                               }];
    }else{
        [_img_Photo setImage:[UIImage imageNamed:UNAVAILABLE_IMAGE]];
    }
    
    //時間設定
    if(object.update_at != nil){
        if(![object.update_at isEqualToString:@""]){
            NSArray *dateArr1 = [[[object.update_at componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"];
            [_dateNewLabel setText:[NSString stringWithFormat:@"%@.%@.%@", [dateArr1 objectAtIndex:0], [dateArr1 objectAtIndex:1], [dateArr1 objectAtIndex:2]]];
        }
    }
    
    //タイトル設定
    [_titleLabel setText:object.title];
    
    //メッセージ設定
    [_lbl_Message setText:object.content];
    
    //NEW表示
    if (object.is_read == 0) {
        
        [newIcon setHidden:NO];
    }else{
        
        [newIcon setHidden:YES];
    }
    
    if (object.is_read == 0) {

        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
        [_lbl_Message setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];

    }else{

        [_titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
        [_lbl_Message setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
    }
}

@end
