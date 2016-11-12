//
//  MPPlanTextCell.m
//  Misepuri
//
//  Created by 3SI-TUYENBQ on 12/3/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPPlanTextCell.h"

#define BONUS_HEIGHT_MENU 20
@implementation MPPlanTextCell

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
    
    [titleMenu setText:itemObject.title];
    [contentMenu setText:itemObject.content];
    
//    CGSize titleSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:293 value:itemObject.title];
//    CGRect titleFrame = titleMenu.frame;
//    titleFrame.size.height = titleSize.height;
//    titleMenu.frame = titleFrame;
    
    CGSize contentSize = [Utility sizeWithFont:[UIFont systemFontOfSize:11] width:293 value:itemObject.content];
    CGRect contentFrame = contentMenu.frame;
    //contentFrame.origin.y = titleFrame.origin.y + titleFrame.size.height + BONUS_HEIGHT_MENU;
    contentFrame.size.height = contentSize.height + BONUS_HEIGHT_MENU;
    contentMenu.frame = contentFrame;
    NSLog(@"%f",contentMenu.frame.size.height);
}

+ (CGFloat)heightForRow:(MPItemObject *)object{
//    CGSize titleSize = [Utility sizeWithFont:[UIFont systemFontOfSize:12] width:293 value:object.title];
    CGSize contentSize = [Utility sizeWithFont:[UIFont systemFontOfSize:11] width:293 value:object.content];
    return (contentSize.height + BONUS_HEIGHT_MENU*2);
}

@end
