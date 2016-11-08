//
//  MPListCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPListCell.h"

@implementation MPListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(MPItemObject *)item{
    itemObject = item;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData * data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:BASE_PREFIX_URL,itemObject.image]]];
        [self performSelectorOnMainThread:@selector(setImage1:) withObject:data waitUntilDone:YES];
    });
    
    
    [titleLabel setText:itemObject.title];
    [contentLabel setText:itemObject.content];
    if ([[Utility checkNIL:itemObject.price] isEqualToString:@""]) {
        [priceLabel setText:@""];
        
    }else{
        [priceLabel setText:[NSString stringWithFormat:@"¥%@",itemObject.price]];
    }
    //[priceLabel setText:[NSString stringWithFormat:@"¥%@",itemObject.price]];
}

- (void) setImage1: (NSData*) data{
    UIImage *image = nil;
    if (data) {
        image = [UIImage imageWithData:data];
    }else{
        image = [UIImage imageNamed:UNAVAILABLE_IMAGE];
    }
    [imageButton setImage:image];
    [imageButton setContentMode:UIViewContentModeScaleAspectFill];
    imageButton.clipsToBounds = YES;
}
@end
