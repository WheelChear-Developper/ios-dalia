//
//  MPView+Border.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPView+Border.h"

@implementation MPView_Border

// 枠線の色
- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

// 枠線のWidth
-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

// 角丸設定
-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

@end
