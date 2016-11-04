//
//  MPAlertView.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/2/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPAlertView.h"

@implementation MPAlertView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.75f]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)okButtonClicked:(UIButton *)sender {
    
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(detailCoupon)]) {
        [self.delegate detailCoupon];
    }
}

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    
    [self removeFromSuperview];
}

- (void)setData:(long)number{
    
    [titleMessage setText:[NSString stringWithFormat:@"本クーポンは残り%ld回表示出来ます。表示しますか？",number]];
}

@end
