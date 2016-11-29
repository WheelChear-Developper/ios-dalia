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
}
+ (instancetype)myView;
@property (nonatomic, assign) id<MPTheSecond_SlideViewDelegate> delegate;

@property (nonatomic) UIScrollView* scr_rootview;

@property (nonatomic) UIView *view_specialMark;
@property (nonatomic) UILabel *lbl_title;

@property (nonatomic) UIImageView* img_photo;
@property (nonatomic) UILabel* lbl_name;

@property (nonatomic) UILabel* lbl_Info1;
@property (nonatomic) UILabel* lbl_Info2;

@property (nonatomic) UILabel* lbl_turn;
@property (nonatomic) UIImageView* img_stamp;
@property (nonatomic) UILabel* lbl_date;

@property (nonatomic) UIView* view_message;
@property (nonatomic) UILabel* lbl_message;
@property (nonatomic) long lng_messageHeight;
@property (weak, nonatomic) IBOutlet UIView *view_left;
@property (weak, nonatomic) IBOutlet UIView *view_right;

- (IBAction)btn_detail:(id)sender;

-(void)setNumberOfPages:(long)count;
-(void)setCurrentCount:(long)count;
-(long)getCurrentCount;

@end
