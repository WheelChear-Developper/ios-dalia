//
//  MPTheSecond_SlideView.m
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

#import "MPTheSecond_SlideView.h"

@implementation MPTheSecond_SlideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
