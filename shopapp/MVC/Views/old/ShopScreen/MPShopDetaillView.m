//
//  MPShopDetaillView.m
//  Misepuri
//
//  Created by TUYENBQ on 3/6/14.
//  Copyright (c) 2014 3SI-TUYENBQ. All rights reserved.
//

#import "MPShopDetaillView.h"

#define Margrin_Top_Bottom 20
#define Margin_Top_Bottom_iOS6 30

@implementation MPShopDetaillView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(NSString*)title content:(NSString*)content {
    
    [titleLabel setText:title];
    [contentLabel setText:content];
}

+ (CGFloat)heightForRow:(NSString *)content {
    
    if (content) {
        CGSize contentSize = [Utility sizeWithFont:[UIFont systemFontOfSize:13] width:179 value:content];
        return (contentSize.height + 21);
    }
    return 43;
}

@end
