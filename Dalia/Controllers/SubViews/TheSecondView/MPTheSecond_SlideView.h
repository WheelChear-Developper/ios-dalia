//
//  MPTheSecond_SlideView.h
//  Dalia
//
//  Created by M.Amatani on 2016/11/16.
//  Copyright © 2016年 Mobile Innovation. All rights reserved.
//

@protocol MPTheSecond_SlideViewDelegate<NSObject>

@end

@interface MPTheSecond_SlideView : UIView
{
    __weak IBOutlet UIPageControl *_pgc_page;
}
@property (nonatomic, assign) id<MPTheSecond_SlideViewDelegate> delegate;

-(void)setNumberOfPages:(long)count;
-(void)setCurrentCount:(long)count;
-(long)getCurrentCount;

@end
