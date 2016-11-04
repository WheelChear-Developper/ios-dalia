//
//  MPListFuntionView.m
//  Misepuri
//
//  Created by TUYENBQ on 11/26/13.
//  Copyright (c) 2013 3SI-TUYENBQ. All rights reserved.
//

#import "MPListFuntionView.h"
#import "MPConfigObject.h"
#import "MPFunctionViewController.h"

#define NUMBER_FUNCTION 4
#define WIDTH_BUTTON 70
#define SIZE_BADGE_NUMBER 30

@implementation MPListFuntionView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    listButton = [[NSMutableArray alloc] init];
    
    listFunction = [(MPConfigObject*)[[MPConfigObject sharedInstance] objectAfterParsedPlistFile:CONFIG_FILE] listFunctions];
    
    [self calculateFunction:listFunction];
}

- (void)calculateFunction:(NSArray*)list {
    
    float padding = (self.frame.size.width - (NUMBER_FUNCTION*WIDTH_BUTTON))/(NUMBER_FUNCTION+1);
    
    
    for (int i = 0; i < list.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        
        NSString *urlImageNomal = @"";
        NSString *urlImageSelected = @"";
        
        urlImageNomal = [NSString stringWithFormat:@"f%@.png",[list objectAtIndex:i]];
        
        urlImageSelected = [NSString stringWithFormat:@"f%@_click.png",[list objectAtIndex:i]];
        
        
        button.frame = CGRectMake(i*WIDTH_BUTTON+ padding* (i+1), padding/2, WIDTH_BUTTON, WIDTH_BUTTON);
        [button setTag:i];
        [button setBackgroundImage:[UIImage imageNamed:urlImageNomal] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:urlImageSelected] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [listButton addObject:button];
    }
}

- (void)buttonClicked:(UIButton*)sender {
    
    if ([self.delegate respondsToSelector:@selector(choiceFunction:)]) {
        [self.delegate choiceFunction:sender.tag];
    }
}

@end
