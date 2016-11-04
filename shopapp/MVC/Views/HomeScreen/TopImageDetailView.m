//
//  TopImageDetailView.m
//  Misepuri
//
//  Created by TUYENBQ on 3/4/14.
//  Copyright (c) 2014 3SI-TUYENBQ. All rights reserved.
//

#import "TopImageDetailView.h"

@implementation TopImageDetailView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(UIImage*)imageData
    withContent:(NSString*)content {
    
    [imageView setImage:imageData];
    
    [contentView setText:content];
    
    CGSize contentSize   = [Utility sizeWithFont:[UIFont systemFontOfSize:13] width:290 value:content];
    CGRect contentViewFrame = contentView.frame;
    CGRect wrapViewParentFrame = wrapViewParent.frame;
    CGRect imageViewFrame = imageView.frame;
    CGRect imageViewWrapFrame = imageViewWrap.frame;
    imageViewFrame.size.height = imageData.size.height;
    imageViewWrapFrame.size.height = imageData.size.height;
    
    if ([contentView.text isEqualToString:@""]) {
      
        wrapViewParentFrame.size.height -=5;
        contentViewFrame.size.height = 0;
    } else {
    contentViewFrame.size.height = contentSize.height+5;
    wrapViewParentFrame.size.height = wrapViewParentFrame.size.height + contentSize.height+5;
    }
    
    CGPoint wrapViewParentPoint = wrapViewParent.center;
    switch ([Utility deviceType]) {
            
        case DEVICE_TYPE_iPhone5Retina:
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
                
                if (wrapViewParentFrame.size.height >= 568.0f) {
                    wrapViewParentFrame.size.height = 568.0f;
                }
                            } else {
                 wrapViewParentPoint = self.center;
                if (wrapViewParentFrame.size.height >= 568.0f) {
                    wrapViewParentFrame.size.height = 568.0f;

                }
            }
                wrapViewParent.center = wrapViewParentPoint;
            contentView.frame = contentViewFrame;
            wrapViewParent.frame = wrapViewParentFrame;
            
            wrapViewParentPoint = self.center;
            wrapViewParent.center = wrapViewParentPoint;
            
            break;
            
        case DEVICE_TYPE_iPhone4Retina:
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
//                    wrapViewParentPoint = self.center;
                    if (wrapViewParentFrame.size.height >= 460.0f) {
                        wrapViewParentFrame.size.height = 460.0f;
                        contentViewFrame.size.height    = 135.0f;
                        
                    }
                } else {
                    if (wrapViewParentFrame.size.height >= 460.0f) {
                        wrapViewParentFrame.size.height = 460.0f;
                        contentViewFrame.size.height    = 135.0f;
                        
                    }
                }
            
            wrapViewParentFrame.origin.y = (480 - wrapViewParentFrame.size.height) /2;
            contentView.frame = contentViewFrame;
            wrapViewParent.frame = wrapViewParentFrame;

            break;
            
        case DEVICE_TYPE_iPhone:
            
            break;
            
        default:
            break;
    }
//    imageViewWrap.frame = imageViewWrapFrame;
    
    

    
    
//    [wrapView setBackgroundColor:[UIColor redColor]];
//    [contentView setBackgroundColor:[UIColor yellowColor]];
//    [[self viewWithTag:100].layer setBorderWidth:2.0f];
//    [[self viewWithTag:100].layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
}

- (void)awakeFromNib {
    
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7f]] ;
}

- (IBAction)hiddenButtonClicked:(id)sender {
    
    [UIView animateWithDuration:0.2 animations:
     ^(void){
         self.alpha = 0.9;
         self.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
         
     }
                     completion:^(BOOL finished){
                         //[self bounceOutAnimationStoped];
                         [self removeFromSuperview];
                         
                     }];
    //
}

@end
