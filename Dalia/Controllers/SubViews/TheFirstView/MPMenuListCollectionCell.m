//
//  MPMenuListCollectionCell.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPMenuListCollectionCell.h"

@implementation MPMenuListCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    [imageView setImage:image];
}

@end
