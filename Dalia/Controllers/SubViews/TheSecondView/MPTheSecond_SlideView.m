//
//  MPTheSecond_SlideView.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheSecond_SlideView.h"

@implementation MPTheSecond_SlideView

+ (instancetype)myView
{
    // xib ファイルから MyView のインスタンスを得る
    UINib *nib = [UINib nibWithNibName:@"MPTheSecond_SlideView" bundle:nil];
    MPTheSecond_SlideView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

-(void)setNumberOfPages:(long)count {

    _pgc_page.numberOfPages = count;
}

-(void)setCurrentCount:(long)count {

    _pgc_page.currentPage = count;
}

-(long)getCurrentCount {

    return _pgc_page.currentPage;
}

- (IBAction)btn_detail:(id)sender {

    if(_view_message.translatesAutoresizingMaskIntoConstraints){

        _view_message.translatesAutoresizingMaskIntoConstraints = NO;

        [self.scr_rootview setContentOffset:CGPointMake(0, _lng_messageHeight) animated:NO];

        _pgc_page.hidden = YES;
    }else{

        _view_message.translatesAutoresizingMaskIntoConstraints = YES;
        CGRect rct_message = _view_message.frame;
        rct_message.size.height = 0;
        _view_message.frame = rct_message;

        _pgc_page.hidden = NO;
    }
}

@end
