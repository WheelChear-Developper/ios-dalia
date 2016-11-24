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
    __weak IBOutlet UIView* _scr_inView;
    CGPoint _scrollBeginingPoint;
    
    __weak IBOutlet UIPageControl *_pgc_page;

    __weak IBOutlet UIView *_view_specialMark;
//    __weak IBOutlet UILabel *_lbl_title;
    __weak IBOutlet UIImageView *_img_photo;
    __weak IBOutlet UILabel *_lbl_name;

    __weak IBOutlet UILabel *_lbl_Info1;
    __weak IBOutlet UILabel *_lbl_Info2;

    __weak IBOutlet UILabel *_lbl_turn;
    __weak IBOutlet UIImageView *_img_stamp;
    __weak IBOutlet UILabel *_lbl_date;

    __weak IBOutlet UIView *_view_message;
    __weak IBOutlet UILabel *_lbl_message;

}
+ (instancetype)myView;
@property (nonatomic, assign) id<MPTheSecond_SlideViewDelegate> delegate;

@property (nonatomic) UIScrollView* scr_rootview;

@property (nonatomic) UILabel *lbl_title;

- (IBAction)btn_detail:(id)sender;

-(void)setNumberOfPages:(long)count;
-(void)setCurrentCount:(long)count;
-(long)getCurrentCount;

@end
