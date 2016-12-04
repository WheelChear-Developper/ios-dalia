//
//  MPSNSAreartView.m
//  Dalia
//
//  Created by M.Amatani on 2016/12/04.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPSNSAreartView.h"

@implementation MPSNSAreartView

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

- (void)setData:(NSString*)title comment:(NSString*)comment {

    [lbl_title setText:title];

    if([comment length] > 0){

        [lbl_comment setText:comment];
    }else{
        [lbl_comment setText:@"　"];
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (IBAction)btn_cansel:(id)sender {

    [self removeFromSuperview];
}

- (IBAction)btn_shar:(id)sender {

    switch (self.lng_snsType) {
        case 1:
        {
            //Facebook
            [self removeFromSuperview];
            [self.delegate postFacebook:lbl_comment.text];
        }
            break;
        case 2:
        {
            //Twitter
            [self removeFromSuperview];
            [self.delegate postTwitter:lbl_comment.text];
        }
            break;
        case 3:
        {
            //Line
            [self removeFromSuperview];
            [self.delegate postLine:lbl_comment.text];
        }
            break;
            
        default:
            break;
    }
}
@end
