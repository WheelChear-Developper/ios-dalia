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

- (IBAction)btn_detail:(id)sender {
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

@end
