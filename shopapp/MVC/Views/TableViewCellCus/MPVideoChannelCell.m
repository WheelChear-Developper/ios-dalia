//
//  MPVideoChannelCell.m
//  Misepuri
//
//  Created by TUYENBQ on 12/16/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPVideoChannelCell.h"

@implementation MPVideoChannelCell

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

- (void)setData:(MPVideoObject *)object {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData * data=[NSData dataWithContentsOfURL:[NSURL URLWithString:object.thumbnail]];
        NSLog(@"url thumbnail:%@",[NSURL URLWithString:object.thumbnail]);
        [self performSelectorOnMainThread:@selector(setImage:) withObject:data waitUntilDone:YES];
    });
    
    [titleLabel setText:object.title];
    [detailLabel setText:object.detail];
    //[timeLabel setText:[Utility checkNIL:[[object.published componentsSeparatedByString:@"T"] objectAtIndex:0]]];
    
    CGSize detailSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:183 value:object.detail];
    CGRect detailFrame = detailLabel.frame;
    if (detailSize.height > 78) {
        detailSize.height = 78;
    }
    detailFrame.size.height = detailSize.height;
    
    
    detailLabel.frame = detailFrame;
}

- (void)setImage:(NSData*)data {
    
    UIImage *image = nil;
    if (data) {
        image = [UIImage imageWithData:data];
    }else{
        image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
    }
    [myImageView setImage:image];
}

@end
